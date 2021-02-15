import 'dart:io';
import 'package:belah_duren/global/variable.dart';
import 'package:belah_duren/model/member_level.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

Future<ApiMemberLevel> futureApiMemberLevel(String token) async{
  var dio = Dio();
  String url = api_url + "member_levels_list";
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  Response response = await dio.get(url);
  print(response.data);

  return ApiMemberLevel.fromStringJson(response.toString());
}

class ApiMemberLevel {
  String status;
  String message;
  int points;
  String member_level_name;
  String image_url;
  List<MemberLevel> data;

  ApiMemberLevel({
    this.status,
    this.message,
    this.points,
    this.member_level_name,
    this.image_url,
    this.data,
  });

  ApiMemberLevel.fromJson(Map<String, dynamic> json) :
        status = json["status"],
        message = json["message"],
        points = json["points"],
        member_level_name = json["member_level_name"],
        image_url = json["image_url"],
        data = List<MemberLevel>.from(json["data"].map((x) => MemberLevel.fromJson(x)));

  ApiMemberLevel.fromStringJson(String stringJson) :
      this.fromJson(json.decode(stringJson));

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "points" : points,
    "member_level_name" : member_level_name,
    "image_url" : image_url,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };

  String toStringJson() => json.encode(this.toJson());

  bool isSuccess() => status == "success";

}