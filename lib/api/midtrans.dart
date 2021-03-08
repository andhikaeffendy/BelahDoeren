import 'dart:io';
import 'package:belah_duren/global/variable.dart';
import 'package:belah_duren/model/cart.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

Future<MidtransResponse> futureApiGetMidtransToken(String token, List<Cart> carts,
    [int discount = 0, String voucher = ""]) async {
  var dio = Dio();
  String url = api_url + "create_midtrans_token";
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  var data = {
    "discount": discount,
    "voucher_code": voucher,
    "carts": toStringJson(carts),
  };
  FormData formData = new FormData.fromMap(data);
  Response response = await dio.post(url, data: formData);
  print(response.data);

  return MidtransResponse.fromStringJson(response.toString());
}

Future<MidtransStatusResponse> futureApiMidtransStatus(String token, String orderId) async {
  var dio = Dio();
  String url = api_url + "payment_status?order_id="+orderId;
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  Response response = await dio.post(url);
  print(response.data);

  return MidtransStatusResponse.fromStringJson(response.toString());
}

class MidtransResponse {
  String status;
  String statusCode;
  String message;
  String token;
  String orderId;

  MidtransResponse({
    this.status,
    this.statusCode,
    this.message,
    this.token,
    this.orderId,
  });

  MidtransResponse.fromJson(Map<String, dynamic> json) :
        status = json["status"],
        statusCode = json["statusCode"],
        message = json["message"],
        token = json.containsKey("token") ? json["token"] : null,
        orderId = json.containsKey("order_id") ? json["order_id"] : null;

  MidtransResponse.fromStringJson(String stringJson) :
        this.fromJson(json.decode(stringJson));

  Map<String, dynamic> toJson() => {
    "status": status,
    "status_code": statusCode,
    "message": message,
    "token": token,
    "order_id": orderId,
  };

  String toStringJson() => json.encode(this.toJson());

  bool isSuccess() => status.toUpperCase() == "SUCCESS" ;
}

String toStringJson(List<Cart> carts) => json.encode(List<dynamic>.from(carts.map((x) => x.toJson())));

class MidtransStatusResponse {
  String status;
  String message;
  String transactionStatus;

  MidtransStatusResponse({
    this.status,
    this.message,
    this.transactionStatus,
  });

  MidtransStatusResponse.fromJson(Map<String, dynamic> json) :
        status = json["status"],
        message = json["message"],
        transactionStatus = json.containsKey("transaction_status") ? json["transaction_status"] : null;

  MidtransStatusResponse.fromStringJson(String stringJson) :
        this.fromJson(json.decode(stringJson));

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "transaction_status": transactionStatus,
  };

  String toStringJson() => json.encode(this.toJson());

  bool isSuccess() => status.toUpperCase() == "SUCCESS" ;
}