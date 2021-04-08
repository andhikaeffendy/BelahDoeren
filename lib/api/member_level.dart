import 'dart:io';
import 'package:belah_duren/global/variable.dart';
import 'package:belah_duren/model/get_reward.dart';
import 'package:belah_duren/model/member_level.dart';
import 'package:belah_duren/model/member_poins.dart';
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

Future<ApiGetReward> futureApiGetReward(String token) async{
  var dio = Dio();
  String url = api_url + "how_to_get_rewards_list";
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  Response response = await dio.get(url);
  print(response.data);

  return ApiGetReward.fromStringJson(response.toString());
}

class ApiMemberLevel {
  String status;
  String message;
  MemberPoints data;
  List<MemberLevel> items;

  ApiMemberLevel({
    this.status,
    this.message,
    this.data,
    this.items,
  });

  ApiMemberLevel.fromJson(Map<String, dynamic> json) :
        status = json["status"],
        message = json["message"],
        data = MemberPoints.fromJson(json),
        items = List<MemberLevel>.from(json["data"].map((x) => MemberLevel.fromJson(x)));

  ApiMemberLevel.fromStringJson(String stringJson) :
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

class ApiGetReward {
  String status;
  String message;
  List<GetReward> items;

  ApiGetReward({
    this.status,
    this.message,
    this.items,
  });

  ApiGetReward.fromJson(Map<String, dynamic> json) :
        status = json["status"],
        message = json["message"],
        items = List<GetReward>.from(json["data"].map((x) => GetReward.fromJson(x)));

  ApiGetReward.fromStringJson(String stringJson) :
        this.fromJson(json.decode(stringJson));

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };

  String toStringJson() => json.encode(this.toJson());

  bool isSuccess() => status == "success";

}