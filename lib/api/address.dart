import 'dart:io';
import 'package:belah_duren/global/variable.dart';
import 'package:belah_duren/model/address.dart';
import 'package:belah_duren/model/user.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

Future<ApiAddress> futureApiAddress(String token, int userId) async{
  var dio = Dio();
  String url = api_url + "my_addresses_list?user_id=" + userId.toString();
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  Response response = await dio.get(url);
  print(response.data);

  return ApiAddress.fromStringJson(response.toString());
}

class ApiAddress {
  String status;
  String message;
  List<Address> data;

  ApiAddress({this.status, this.message, this.data});

  ApiAddress.fromJson(Map<String, dynamic> json) :
        status = json["status"],
        message = json["message"],
        data = List<Address>.from(json["data"].map((x) => Address.fromJson(x)));

  ApiAddress.fromStringJson(String stringJson) :
        this.fromJson(json.decode(stringJson));

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };

  String toStringJson() => json.encode(this.toJson());

  bool isSuccess() => status == "success";

}