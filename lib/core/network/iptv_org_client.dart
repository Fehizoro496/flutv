import 'package:dio/dio.dart';

import '../constants/app_constants.dart';
import 'iptv_failure.dart';

class IptvOrgClient {
  IptvOrgClient(this._dio);

  final Dio _dio;

  Future<List<Map<String, dynamic>>> fetchChannels() =>
      _fetchList(AppConstants.channelsEndpoint);

  Future<List<Map<String, dynamic>>> fetchStreams() =>
      _fetchList(AppConstants.streamsEndpoint);

  Future<List<Map<String, dynamic>>> fetchCategories() =>
      _fetchList(AppConstants.categoriesEndpoint);

  Future<List<Map<String, dynamic>>> fetchCountries() =>
      _fetchList(AppConstants.countriesEndpoint);

  Future<List<Map<String, dynamic>>> _fetchList(String url) async {
    try {
      final response = await _dio.getUri<List<dynamic>>(Uri.parse(url));
      final data = response.data;
      if (data == null) throw const ParseFailure();
      return data
          .whereType<Map>()
          .map((e) => e.cast<String, dynamic>())
          .toList(growable: false);
    } on DioException catch (e) {
      throw _mapDioError(e);
    } on FormatException {
      throw const ParseFailure();
    }
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
        return ServerFailure('Erreur serveur ($code).');
      case DioExceptionType.cancel:
      case DioExceptionType.badCertificate:
        return const NetworkFailure();
    }
  }
}
