import 'dart:io';
import 'package:belah_duren/global/variable.dart';
import 'package:belah_duren/model/user.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

Future<ApiProfile> futureApiProfile(String token) async{
  var dio = Dio();
  String url = api_url + "profile";
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  Response response = await dio.get(url);
  print(response.data);

  return ApiProfile.fromStringJson(response.toString());
}

class ApiProfile {
  String status;
  String message;
  User user;

  ApiProfile({
    this.status,
    this.message,
    this.user,
  });

  ApiProfile.fromJson(Map<String, dynamic> json) :
        status = json["status"],
        message = json["message"],
        user = User.fromJson(json);

  ApiProfile.fromStringJson(String stringJson) :
        this.fromJson(json.decode(stringJson));

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "id": user.id,
    "name": user.name,
    "email": user.email,
    "id_token": user.token,
  };

  String toStringJson() => json.encode(this.toJson());

  bool isSuccess() => status == "success";
}