import 'dart:convert';
import 'dart:io';
import 'package:belah_duren/global/variable.dart';
import 'package:belah_duren/model/global_response.dart';
import 'package:belah_duren/model/point_transaction_list.dart';
import 'package:belah_duren/model/present_list.dart';
import 'package:dio/dio.dart';

Future<ApiPresentList> futureApiPresentList(String token) async{
  var dio = Dio();
  String url = api_url + "presents_list";
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  Response response = await dio.get(url);
  print(response.data);

  return ApiPresentList.fromStringJson(response.toString());
}

Future<ApiPointTransaction> futureApiPointTransaction(String token) async{
  var dio = Dio();
  String url = api_url + "point_transactions_list";
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  Response response = await dio.get(url);
  print(response.data);

  return ApiPointTransaction.fromStringJson(response.toString());
}

Future<GlobalResponse> futureApiSubmitPointsTransaction(String token,
    int present_id) async{
  var dio = Dio();
  String url = api_url + "submit_point_transaction";
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  FormData formData = new FormData.fromMap({
    "present_id": present_id,
  });
  Response response = await dio.post(url, data: formData);
  print(response.data);

  return GlobalResponse.fromStringJson(response.toString());
}

class ApiPresentList{
  String status;
  String message;
  List<PresentList> data;

  ApiPresentList({this.status, this.message, this.data});

  ApiPresentList.fromJson(Map<String, dynamic> json) :
        status = json["status"],
        message = json["message"],
        data = List<PresentList>.from(json["data"].map((x) => PresentList.fromJson(x)));

  ApiPresentList.fromStringJson(String stringJson) :
        this.fromJson(json.decode(stringJson));

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };

  String toStringJson() => json.encode(this.toJson());

  bool isSuccess() => status == "success";
}

class ApiPointTransaction{
  String status;
  String message;
  List<PointTransactionList> data;

  ApiPointTransaction({this.status, this.message, this.data});

  ApiPointTransaction.fromJson(Map<String, dynamic> json) :
        status = json["status"],
        message = json["message"],
        data = List<PointTransactionList>.from(json["data"].map((x) => PointTransactionList.fromJson(x)));

  ApiPointTransaction.fromStringJson(String stringJson) :
        this.fromJson(json.decode(stringJson));

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };

  String toStringJson() => json.encode(this.toJson());

  bool isSuccess() => status == "success";
}