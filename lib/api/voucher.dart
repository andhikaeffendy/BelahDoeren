import 'dart:io';
import 'package:belah_duren/global/error_message.dart';
import 'package:belah_duren/global/variable.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

Future<ApiVoucher> futureApiRedeemVoucher(String token,
    String name, int total) async{
  var dio = Dio();
  String url = api_url + "redeem_voucher";
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  FormData formData = new FormData.fromMap({
    "name": name,
    "total_price": total,
  });
  try {
    Response response = await dio.post(url, data: formData);
    // print(response.data);
    return ApiVoucher.fromStringJson(response.toString());
  } on DioError catch (e) {
    if (e.response != null ) {
      return ApiVoucher(status: "fail", message: ErrorMessage.getMessage(e.response.statusCode));
    } else {
      return ApiVoucher(status: "fail", message: ErrorMessage.getMessage(0));
    }
  }
}

class ApiVoucher {
  String status;
  String message;
  int id;
  String name;
  int discount;

  ApiVoucher({
    this.status,
    this.message,
    this.id,
    this.name,
    this.discount,
  });

  ApiVoucher.fromJson(Map<String, dynamic> json) :
        status = json["status"],
        message = json["message"],
        id = json.containsKey("id") ? json["id"] : null ,
        name = json.containsKey("name") ? json["name"] : null ,
        discount = json.containsKey("discount") ? json["discount"] : null ;

  ApiVoucher.fromStringJson(String stringJson) :
        this.fromJson(json.decode(stringJson));

  bool isSuccess() => status.toUpperCase() == "SUCCESS";
}