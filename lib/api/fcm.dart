import 'dart:io';
import 'package:belah_duren/global/variable.dart';
import 'package:belah_duren/model/global_response.dart';
import 'package:dio/dio.dart';

Future<GlobalResponse> futureApiSendRegistrationToken(String token, String registration_token) async{
  var dio = Dio();
  String url = api_url + "register_token";
  FormData formData = new FormData.fromMap({
    "fcm_token": registration_token,
  });
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  Response response = await dio.post(url, data: formData);
  print(response.data);

  return GlobalResponse.fromStringJson(response.toString());
}