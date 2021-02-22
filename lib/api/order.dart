import 'dart:io';
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
  Response response = await dio.get(url);
  print(response.data);

  return ApiOrder.fromStringJson(response.toString());
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
        data = DetailTransaction.fromJson(json),
        items = List<Items>.from(json["items"].map((x) => Items.fromJson(x)));

  ApiOrder.fromStringJson(String stringJson) :
        this.fromJson(json.decode(stringJson));

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data" : data.toJson(),
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };

  String toStringJson() => json.encode(this.toJson());

  bool isSuccess() => status == "success";
}