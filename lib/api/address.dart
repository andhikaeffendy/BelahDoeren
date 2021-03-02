import 'dart:io';
import 'package:belah_duren/global/variable.dart';
import 'package:belah_duren/model/address.dart';
import 'package:belah_duren/model/global_response.dart';
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

Future<GlobalResponse> futureApiTambahAlamat(String token,
    String name, String address, String lat, String long) async{
  var dio = Dio();
  String url = api_url + "submit_my_address";
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  FormData formData = new FormData.fromMap({
    "name" : name,
    "address" : address,
    "lat" : lat,
    "long" : long
  });
  Response response = await dio.post(url, data: formData);
  print(response.data);

  return GlobalResponse.fromStringJson(response.toString());
}

Future<GlobalResponse> futureApiUpdateAlamat(String token, int id_alamat,
    String name, String address, String lat, String long) async{
  var dio = Dio();
  String url = api_url + "update_my_address/"+id_alamat.toString();
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  FormData formData = new FormData.fromMap({
    "name" : name,
    "address" : address,
    "lat" : lat,
    "long" : long
  });
  Response response = await dio.post(url, data: formData);
  print(response.data);

  return GlobalResponse.fromStringJson(response.toString());
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