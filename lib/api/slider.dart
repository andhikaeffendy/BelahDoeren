import 'dart:io';
import 'package:belah_duren/global/variable.dart';
import 'package:belah_duren/model/slider.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

Future<ApiSlider> futureApiSliders(String token) async{
  var dio = Dio();
  String url = api_url + "sliders_list";
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  Response response = await dio.get(url);
  print(response.data);

  return ApiSlider.fromStringJson(response.toString());
}

class ApiSlider {
  String status;
  String message;
  List<SliderMenu> data;

  ApiSlider({
    this.status,
    this.message,
    this.data,
  });

  ApiSlider.fromJson(Map<String, dynamic> json) :
        status = json["status"],
        message = json["message"],
        data = json.containsKey("data") ? List<SliderMenu>.from(json["data"].map((x) => SliderMenu.fromJson(x))) : null ;

  ApiSlider.fromStringJson(String stringJson) :
        this.fromJson(json.decode(stringJson));

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };

  String toStringJson() => json.encode(this.toJson());

  bool isSuccess() => status == "success";
}