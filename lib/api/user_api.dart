import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit_sample/model/user.dart';
part '../gen/api/user_api.g.dart';

@RestApi()
@Injectable() // dependensi yang diperlukan oleh kelas dengan anotasi injectable akan diresolve otomatis
abstract class UserApi {
  @factoryMethod // diperlukan anotasi factoryMethod jika objek dibuat menggunakan factory
  factory UserApi(Dio dio) = _UserApi;

  // sisanya sama persis seperti retrofit di android
  @GET('/user/{id}')
  Future<User> getUser(@Path('id') String userId);
}
