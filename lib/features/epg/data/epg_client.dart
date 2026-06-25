import 'dart:convert';

import 'package:archive/archive.dart';
import 'package:dio/dio.dart';
import 'package:xml/xml.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/network/iptv_failure.dart';
import 'models/epg_programme.dart';

class EpgClient {
  EpgClient(this._dio);

  final Dio _dio;

  Future<List<EpgSource>> fetchSources() async {
    try {
      final response = await _dio
          .getUri<List<dynamic>>(Uri.parse(AppConstants.epgGuidesEndpoint));
      final data = response.data;
      if (data == null) throw const ParseFailure();
      final out = <EpgSource>[];
      for (final entry in data) {
        if (entry is! Map) continue;
        final m = entry.cast<String, dynamic>();
        final channel = m['channel'] as String?;
        if (channel == null) continue;
        final rawSources = m['sources'];
        if (rawSources is! List) continue;
        for (final source in rawSources) {
          if (source is! Map) continue;
          final s = source.cast<String, dynamic>();
          final url = s['url'] as String?;
          final format = (s['format'] as String?)?.toUpperCase();
          if (url == null || url.isEmpty) continue;
          // Only handle plain XMLTV for now; GZIP / JSON not supported yet.
          if (format != null && format != 'XML') continue;
          out.add(EpgSource(
            channelId: channel,
            url: url,
            lang: m['lang'] as String?,
          ));
        }
      }
      return out;
    } on DioException catch (e) {
      throw _mapDioError(e);
    } on FormatException {
      throw const ParseFailure();
    }
  }

  Future<List<EpgProgramme>> fetchProgrammes(String url) async {
    final isGzip = url.toLowerCase().endsWith('.gz');
    try {
      final response = await _dio.getUri<List<int>>(
        Uri.parse(url),
        options: Options(
          responseType: ResponseType.bytes,
          receiveTimeout: const Duration(seconds: 60),
        ),
      );
      final bytes = response.data;
      if (bytes == null || bytes.isEmpty) throw const ParseFailure();
      final xmlBytes = (isGzip || _looksGzipped(bytes))
          ? GZipDecoder().decodeBytes(bytes)
          : bytes;
      final xmlBody = utf8.decode(xmlBytes, allowMalformed: true);
      return _parseXmltv(xmlBody);
    } on DioException catch (e) {
      throw _mapDioError(e);
    } on ArchiveException {
      throw const ParseFailure();
    }
  }

  bool _looksGzipped(List<int> bytes) {
    return bytes.length >= 2 && bytes[0] == 0x1F && bytes[1] == 0x8B;
  }

  List<EpgProgramme> _parseXmltv(String body) {
    final XmlDocument doc;
    try {
      doc = XmlDocument.parse(body);
    } on XmlException {
      throw const ParseFailure();
    }
    final programmes = <EpgProgramme>[];
    for (final element in doc.findAllElements('programme')) {
      final channel = element.getAttribute('channel');
      final startRaw = element.getAttribute('start');
      final stopRaw = element.getAttribute('stop');
      if (channel == null || startRaw == null || stopRaw == null) continue;
      final start = _parseXmltvTime(startRaw);
      final stop = _parseXmltvTime(stopRaw);
      if (start == null || stop == null) continue;

      final title = element.getElement('title')?.innerText.trim() ?? '';
      if (title.isEmpty) continue;
      final desc = element.getElement('desc')?.innerText.trim();
      final cat = element.getElement('category')?.innerText.trim();

      programmes.add(EpgProgramme(
        channelId: channel,
        start: start,
        stop: stop,
        title: title,
        description: (desc?.isEmpty ?? true) ? null : desc,
        category: (cat?.isEmpty ?? true) ? null : cat,
      ));
    }
    return programmes;
  }

  /// Parse XMLTV timestamps like `20260623180000 +0200` or `20260623180000`.
  DateTime? _parseXmltvTime(String raw) {
    final value = raw.trim();
    if (value.length < 14) return null;
    final year = int.tryParse(value.substring(0, 4));
    final month = int.tryParse(value.substring(4, 6));
    final day = int.tryParse(value.substring(6, 8));
    final hour = int.tryParse(value.substring(8, 10));
    final minute = int.tryParse(value.substring(10, 12));
    final second = int.tryParse(value.substring(12, 14));
    if (year == null ||
        month == null ||
        day == null ||
        hour == null ||
        minute == null ||
        second == null) {
      return null;
    }
    var dt = DateTime.utc(year, month, day, hour, minute, second);
    final rest = value.substring(14).trim();
    if (rest.isEmpty) return dt.toLocal();
    final match = RegExp(r'^([+-])(\d{2})(\d{2})$').firstMatch(rest);
    if (match == null) return dt.toLocal();
    final sign = match.group(1) == '-' ? 1 : -1;
    final offHours = int.parse(match.group(2)!);
    final offMinutes = int.parse(match.group(3)!);
    dt = dt.add(Duration(hours: sign * offHours, minutes: sign * offMinutes));
    return dt.toLocal();
  }

  IptvFailure _mapDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const TimeoutFailure();
      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        return const NetworkFailure();
      case DioExceptionType.badResponse:
        final code = e.response?.statusCode ?? 0;
        return ServerFailure('EPG erreur serveur ($code).');
      case DioExceptionType.cancel:
      case DioExceptionType.badCertificate:
        return const NetworkFailure();
    }
  }
}
