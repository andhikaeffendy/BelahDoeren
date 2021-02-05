import 'dart:io';
import 'package:belah_duren/global/variable.dart';
import 'package:belah_duren/model/branch.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

Future<ApiBranch> futureApiMenuCategories(String token) async{
  var dio = Dio();
  String url = api_url + "branches_list";
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  Response response = await dio.get(url);
  print(response.data);

  return ApiBranch.fromStringJson(response.toString());
}

class ApiBranch {
  String status;
  String message;
  List<Branch> data;

  ApiBranch({
    this.status,
    this.message,
    this.data,
  });

  ApiBranch.fromJson(Map<String, dynamic> json) :
        status = json["status"],
        message = json["message"],
        data = List<Branch>.from(json["data"].map((x) => Branch.fromJson(x)));

  ApiBranch.fromStringJson(String stringJson) :
        this.fromJson(json.decode(stringJson));

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };

  String toStringJson() => json.encode(this.toJson());

  bool isSuccess() => status == "success";
}