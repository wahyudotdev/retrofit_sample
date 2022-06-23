import 'package:dio/dio.dart';
import 'package:dio_logging_interceptor/dio_logging_interceptor.dart';
import 'package:injectable/injectable.dart';

@module
abstract class NetworkModule {
  @injectable
  Dio get dio {
    final client = Dio(
        BaseOptions(baseUrl: 'https://629867c8de3d7eea3c664c1a.mockapi.io'));
    client.interceptors.add(DioLoggingInterceptor(
      level: Level.body,
    ));
    return client;
  }
}
