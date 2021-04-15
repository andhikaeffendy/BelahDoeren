import 'dart:io';
import 'package:belah_duren/global/error_message.dart';
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
  try {
    Response response = await dio.get(url);
    // print(response.data);
    return ApiMemberLevel.fromStringJson(response.toString());
  } on DioError catch (e) {
    if (e.response != null ) {
      return ApiMemberLevel(status: "fail", message: ErrorMessage.getMessage(e.response.statusCode));
    } else {
      return ApiMemberLevel(status: "fail", message: ErrorMessage.getMessage(0));
    }
  }
}

Future<ApiGetReward> futureApiGetReward(String token) async{
  var dio = Dio();
  String url = api_url + "how_to_get_rewards_list";
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  try {
    Response response = await dio.get(url);
    // print(response.data);
    return ApiGetReward.fromStringJson(response.toString());
  } on DioError catch (e) {
    if (e.response != null ) {
      return ApiGetReward(status: "fail", message: ErrorMessage.getMessage(e.response.statusCode));
    } else {
      return ApiGetReward(status: "fail", message: ErrorMessage.getMessage(0));
    }
  }
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
        data = json.containsKey("points") ? MemberPoints.fromJson(json) : null,
        items = json.containsKey("data") ? List<MemberLevel>.from(json["data"].map((x) => MemberLevel.fromJson(x))) : null;

  ApiMemberLevel.fromStringJson(String stringJson) :
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
        items = json.containsKey("data") ? List<GetReward>.from(json["data"].map((x) => GetReward.fromJson(x))) : null;

  ApiGetReward.fromStringJson(String stringJson) :
        this.fromJson(json.decode(stringJson));

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };

  String toStringJson() => json.encode(this.toJson());

  bool isSuccess() => status.toUpperCase() == "SUCCESS";

}