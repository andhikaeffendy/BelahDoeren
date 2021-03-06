import 'dart:io';
import 'package:belah_duren/global/error_message.dart';
import 'package:belah_duren/global/variable.dart';
import 'package:belah_duren/model/global_response.dart';
import 'package:dio/dio.dart';

Future<GlobalResponse> futureApiChangePassword(String token,
    String old_password, String password, String password_confirmation) async{
  var dio = Dio();
  String url = api_url + "change_password";
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  FormData formData = new FormData.fromMap({
    "old_password": old_password,
    "password": password,
    "password_confirmation": password_confirmation,
  });
  try {
    Response response = await dio.post(url, data: formData);
    // print(response.data);
    return GlobalResponse.fromStringJson(response.toString());
  } on DioError catch (e) {
    if (e.response != null ) {
      return GlobalResponse(status: "fail", message: ErrorMessage.getMessage(e.response.statusCode));
    } else {
      return GlobalResponse(status: "fail", message: ErrorMessage.getMessage(0));
    }
  }
}