import 'dart:io';
import 'package:belah_duren/global/variable.dart';
import 'package:belah_duren/model/branch.dart';
import 'package:belah_duren/model/district_branch.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

Future<ApiBranch> futureApiBranches(String token) async{
  var dio = Dio();
  String url = api_url + "branches_list";
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  Response response = await dio.get(url);
  print(response.data);

  return ApiBranch.fromStringJson(response.toString());
}

Future<ApiBranch> futureApiGetBranches(String token, int district_id) async{
  var dio = Dio();
  String url = api_url + "branches_list?district_id=" + district_id.toString();
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  Response response = await dio.get(url);
  print(response.data);

  return ApiBranch.fromStringJson(response.toString());
}

Future<ApiListBranch> futureApiListBranches(String token) async{
  var dio = Dio();
  String url = api_url + "branch_districts_list";
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  Response response = await dio.get(url);
  print(response.data);

  return ApiListBranch.fromStringJson(response.toString());
}

class ApiBranch {
  String status;
  String message;
  List<Items> data;

  ApiBranch({
    this.status,
    this.message,
    this.data,
  });

  ApiBranch.fromJson(Map<String, dynamic> json) :
        status = json["status"],
        message = json["message"],
        data = List<Items>.from(json["data"].map((x) => Items.fromJson(x)));

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

class ApiListBranch {
  String status;
  String message;
  List<DistrictBranch> data;

  ApiListBranch({
      this.status,
      this.message,
      this.data});

  ApiListBranch.fromJson(Map<String, dynamic> json) :
        status = json["status"],
        message = json["message"],
        data = List<DistrictBranch>.from(json["data"].map((x) => DistrictBranch.fromJson(x)));

  ApiListBranch.fromStringJson(String stringJson) :
        this.fromJson(json.decode(stringJson));

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };

  String toStringJson() => json.encode(this.toJson());

  bool isSuccess() => status == "success";
}