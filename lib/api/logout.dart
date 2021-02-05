import 'dart:io';
import 'package:belah_duren/global/variable.dart';
import 'package:belah_duren/model/global_response.dart';
import 'package:dio/dio.dart';

Future<GlobalResponse> futureApiLogout(String token) async{
  var dio = Dio();
  String url = api_url + "logout";
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  Response response = await dio.post(url);
  print(response.data);

  return GlobalResponse.fromStringJson(response.toString());
}