import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/app_constants.dart';
import 'iptv_org_client.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      connectTimeout: AppConstants.apiTimeout,
      receiveTimeout: AppConstants.apiTimeout,
      sendTimeout: AppConstants.apiTimeout,
      responseType: ResponseType.json,
      headers: const {'Accept': 'application/json'},
    ),
  );
  ref.onDispose(dio.close);
  return dio;
});

final iptvOrgClientProvider = Provider<IptvOrgClient>(
  (ref) => IptvOrgClient(ref.watch(dioProvider)),
);
