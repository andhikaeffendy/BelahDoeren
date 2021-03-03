import 'dart:convert';
import 'dart:io';
import 'package:belah_duren/global/variable.dart';
import 'package:belah_duren/model/about.dart';
import 'package:belah_duren/model/faq_list.dart';
import 'package:dio/dio.dart';

Future<ApiAbout> futureApiGetAbout(String token) async{
  var dio = Dio();
  String url = api_url + "about";
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  Response response = await dio.get(url);
  print(response.data);

  return ApiAbout.fromStringJson(response.toString());
}

Future<ApiFaq> futureApiListFaq(String token) async{
  var dio = Dio();
  String url = api_url + "faqs_list";
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  Response response = await dio.get(url);
  print(response.data);

  return ApiFaq.fromStringJson(response.toString());
}

class ApiAbout{
  String status;
  String message;
  About data;

  ApiAbout({this.status, this.message, this.data});

  ApiAbout.fromJson(Map<String, dynamic> json ) :
      status = json["status"],
      message = json["message"],
      data = About.fromJson(json);

  ApiAbout.fromStringJson(String stringJson) :
        this.fromJson(json.decode(stringJson));

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data" : data.toJson(),
  };

  String toStringJson() => json.encode(this.toJson());

  bool isSuccess() => status == "success";
}

class ApiFaq{
  String status;
  String message;
  List<FaqList> data;

  ApiFaq({this.status, this.message, this.data});

  ApiFaq.fromJson(Map<String, dynamic> json ) :
        status = json["status"],
        message = json["message"],
        data = List<FaqList>.from(json["data"].map((x) => FaqList.fromJson(x)));

  ApiFaq.fromStringJson(String stringJson) :
        this.fromJson(json.decode(stringJson));

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data" : List<dynamic>.from(data.map((x) => x.toJson())),
  };

  String toStringJson() => json.encode(this.toJson());

  bool isSuccess() => status == "success";
}