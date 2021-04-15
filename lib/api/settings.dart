import 'dart:convert';
import 'dart:io';
import 'package:belah_duren/global/error_message.dart';
import 'package:belah_duren/global/variable.dart';
import 'package:belah_duren/model/about.dart';
import 'package:belah_duren/model/faq_list.dart';
import 'package:dio/dio.dart';

Future<ApiAbout> futureApiGetAbout() async{
  var dio = Dio();
  String url = api_url + "about";
  // dio.options.headers[HttpHeaders.authorizationHeader] =
  //     'Bearer ' + token;
  try {
    Response response = await dio.get(url);
    // print(response.data);
    return ApiAbout.fromStringJson(response.toString());
  } on DioError catch (e) {
    if (e.response != null ) {
      return ApiAbout(status: "fail", message: ErrorMessage.getMessage(e.response.statusCode));
    } else {
      return ApiAbout(status: "fail", message: ErrorMessage.getMessage(0));
    }
  }
}

Future<ApiFaq> futureApiListFaq() async{
  var dio = Dio();
  String url = api_url + "faqs_list";
  // dio.options.headers[HttpHeaders.authorizationHeader] =
  //     'Bearer ' + token;
  try {
    Response response = await dio.get(url);
    // print(response.data);
    return ApiFaq.fromStringJson(response.toString());
  } on DioError catch (e) {
    if (e.response != null ) {
      return ApiFaq(status: "fail", message: ErrorMessage.getMessage(e.response.statusCode));
    } else {
      return ApiFaq(status: "fail", message: ErrorMessage.getMessage(0));
    }
  }
}

class ApiAbout{
  String status;
  String message;
  About data;

  ApiAbout({this.status, this.message, this.data});

  ApiAbout.fromJson(Map<String, dynamic> json ) :
      status = json["status"],
      message = json["message"],
      data = json.containsKey("id") ? About.fromJson(json) : null;

  ApiAbout.fromStringJson(String stringJson) :
        this.fromJson(json.decode(stringJson));

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data" : data.toJson(),
  };

  String toStringJson() => json.encode(this.toJson());

  bool isSuccess() => status.toUpperCase()== "SUCCESS";
}

class ApiFaq{
  String status;
  String message;
  List<FaqList> data;

  ApiFaq({this.status, this.message, this.data});

  ApiFaq.fromJson(Map<String, dynamic> json ) :
        status = json["status"],
        message = json["message"],
        data = json.containsKey("data") ? List<FaqList>.from(json["data"].map((x) => FaqList.fromJson(x))) : null;

  ApiFaq.fromStringJson(String stringJson) :
        this.fromJson(json.decode(stringJson));

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data" : List<dynamic>.from(data.map((x) => x.toJson())),
  };

  String toStringJson() => json.encode(this.toJson());

  bool isSuccess() => status.toUpperCase() == "SUCCESS";
}