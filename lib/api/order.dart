import 'dart:io';
import 'package:belah_duren/global/error_message.dart';
import 'package:belah_duren/global/variable.dart';
import 'package:belah_duren/model/detail_transaction.dart';
import 'package:belah_duren/model/order.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

Future<ApiOrder> futureDetailOrder(String token, int id) async{
  var dio = Dio();
  String url = api_url + "transaction_detail/" + id.toString();
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  try {
    Response response = await dio.get(url);
    // print(response.data);
    return ApiOrder.fromStringJson(response.toString());
  } on DioError catch (e) {
    if (e.response != null ) {
      return ApiOrder(status: "fail", message: ErrorMessage.getMessage(e.response.statusCode));
    } else {
      return ApiOrder(status: "fail", message: ErrorMessage.getMessage(0));
    }
  }
}

class ApiOrder{
  String status;
  String message;
  DetailTransaction data;
  List<Items> items;

  ApiOrder({
    this.status,
    this.message,
    this.data,
    this.items
  });

  ApiOrder.fromJson(Map<String, dynamic> json) :
        status = json["status"],
        message = json["message"],
        data = json.containsKey("id") ? DetailTransaction.fromJson(json) : null,
        items = json.containsKey("items") ? List<Items>.from(json["items"].map((x) => Items.fromJson(x))) : null;

  ApiOrder.fromStringJson(String stringJson) :
        this.fromJson(json.decode(stringJson));

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data" : data.toJson(),
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };

  String toStringJson() => json.encode(this.toJson());

  bool isSuccess() => status.toUpperCase() == "SUCCESS";
}