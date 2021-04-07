import 'dart:io';
import 'package:belah_duren/global/variable.dart';
import 'package:belah_duren/model/payment_method.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

Future<ApiPaymentMethod> futureApiPaymentMethods(String token) async{
  var dio = Dio();
  String url = api_url + "payment_methods_list";
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  Response response = await dio.get(url);
  print(response.data);

  return ApiPaymentMethod.fromStringJson(response.toString());
}

class ApiPaymentMethod {
  String status;
  String message;
  List<PaymentMethod> data;

  ApiPaymentMethod({
    this.status,
    this.message,
    this.data,
  });

  ApiPaymentMethod.fromJson(Map<String, dynamic> json) :
        status = json["status"],
        message = json["message"],
        data = json.containsKey("data") ? List<PaymentMethod>.from(json["data"].map((x) => PaymentMethod.fromJson(x))) : null ;

  ApiPaymentMethod.fromStringJson(String stringJson) :
        this.fromJson(json.decode(stringJson));

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };

  String toStringJson() => json.encode(this.toJson());

  bool isSuccess() => status.toUpperCase() == "SUCCESS";
}