import 'dart:io';
import 'package:belah_duren/global/error_message.dart';
import 'package:belah_duren/global/variable.dart';
import 'package:belah_duren/model/menu.dart';
import 'package:belah_duren/model/menu_category.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

Future<ApiMenuCategory> futureApiMenuCategories() async{
  var dio = Dio();
  String url = api_url + "menu_categories_list";
  // dio.options.headers[HttpHeaders.authorizationHeader] =
  //     'Bearer ' + token;
  try {
    Response response = await dio.get(url);
    // print(response.data);
    return ApiMenuCategory.fromStringJson(response.toString());
  } on DioError catch (e) {
    if (e.response != null ) {
      return ApiMenuCategory(status: "fail", message: ErrorMessage.getMessage(e.response.statusCode));
    } else {
      return ApiMenuCategory(status: "fail", message: ErrorMessage.getMessage(0));
    }
  }
}

Future<ApiMenu> futureApiMenus(String token, int categoryId, int branch_id) async{
  var dio = Dio();
  String url = api_url + "menus_list?menu_category_id="+categoryId.toString() + "&branch_id=" + branch_id.toString() ;
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  try {
    Response response = await dio.get(url);
    // print(response.data);
    return ApiMenu.fromStringJson(response.toString());
  } on DioError catch (e) {
    if (e.response != null ) {
      return ApiMenu(status: "fail", message: ErrorMessage.getMessage(e.response.statusCode));
    } else {
      return ApiMenu(status: "fail", message: ErrorMessage.getMessage(0));
    }
  }
}

Future<ApiMenu> futureApiFeaturedMenus(String token, int branch_id) async{
  var dio = Dio();
  String url = api_url + "featured_menus_list?branch_id=" + branch_id.toString();
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  try {
    Response response = await dio.get(url);
    // print(response.data);
    return ApiMenu.fromStringJson(response.toString());
  } on DioError catch (e) {
    if (e.response != null ) {
      return ApiMenu(status: "fail", message: ErrorMessage.getMessage(e.response.statusCode));
    } else {
      return ApiMenu(status: "fail", message: ErrorMessage.getMessage(0));
    }
  }
}

Future<ApiMenuDetail> futureApiMenu(String token, int menuId) async{
  var dio = Dio();
  String url = api_url + "detail_menu?id="+menuId.toString();
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  try {
    Response response = await dio.get(url);
    // print(response.data);
    return ApiMenuDetail.fromStringJson(response.toString());
  } on DioError catch (e) {
    if (e.response != null ) {
      return ApiMenuDetail(status: "fail", message: ErrorMessage.getMessage(e.response.statusCode));
    } else {
      return ApiMenuDetail(status: "fail", message: ErrorMessage.getMessage(0));
    }
  }
}

Future<ApiMenu> futureApiPromotionMenus(int branch_id) async{
  var dio = Dio();
  String url = api_url + "promotion_menus_list?branch_id=" + branch_id.toString();
  // dio.options.headers[HttpHeaders.authorizationHeader] =
  //     'Bearer ' + token;
  try {
    Response response = await dio.get(url);
    // print(response.data);
    return ApiMenu.fromStringJson(response.toString());
  } on DioError catch (e) {
    if (e.response != null ) {
      return ApiMenu(status: "fail", message: ErrorMessage.getMessage(e.response.statusCode));
    } else {
      return ApiMenu(status: "fail", message: ErrorMessage.getMessage(0));
    }
  }
}

Future<ApiMenu> futureApiPromotionMenusNotLogin() async{
  var dio = Dio();
  String url = api_url + "promotion_menus_list";
  // dio.options.headers[HttpHeaders.authorizationHeader] =
  //     'Bearer ' + token;
  try {
    Response response = await dio.get(url);
    // print(response.data);
    return ApiMenu.fromStringJson(response.toString());
  } on DioError catch (e) {
    if (e.response != null ) {
      return ApiMenu(status: "fail", message: ErrorMessage.getMessage(e.response.statusCode));
    } else {
      return ApiMenu(status: "fail", message: ErrorMessage.getMessage(0));
    }
  }
}

class ApiMenuDetail {
  String status;
  String message;
  Menu data;

  ApiMenuDetail({
    this.status,
    this.message,
    this.data,
  });

  ApiMenuDetail.fromJson(Map<String, dynamic> json) :
        status = json["status"],
        message = json["message"],
        data = json.containsKey("id") ? Menu.fromJson(json) : null;

  ApiMenuDetail.fromStringJson(String stringJson) :
        this.fromJson(json.decode(stringJson));

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };

  String toStringJson() => json.encode(this.toJson());

  bool isSuccess() => status.toUpperCase() == "SUCCESS";
}

class ApiMenuCategory {
  String status;
  String message;
  List<MenuCategory> data;

  ApiMenuCategory({
    this.status,
    this.message,
    this.data,
  });

  ApiMenuCategory.fromJson(Map<String, dynamic> json) :
        status = json["status"],
        message = json["message"],
        data = json.containsKey("data") ? List<MenuCategory>.from(json["data"].map((x) => MenuCategory.fromJson(x))) : null;

  ApiMenuCategory.fromStringJson(String stringJson) :
        this.fromJson(json.decode(stringJson));

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };

  String toStringJson() => json.encode(this.toJson());

  bool isSuccess() => status.toUpperCase() == "SUCCESS";
}

class ApiMenu {
  String status;
  String message;
  List<Menu> data;

  ApiMenu({
    this.status,
    this.message,
    this.data,
  });

  ApiMenu.fromJson(Map<String, dynamic> json) :
        status = json["status"],
        message = json["message"],
        data = json.containsKey("data") ? List<Menu>.from(json["data"].map((x) => Menu.fromJson(x))) : null;

  ApiMenu.fromStringJson(String stringJson) :
        this.fromJson(json.decode(stringJson));

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };

  String toStringJson() => json.encode(this.toJson());

  bool isSuccess() => status.toUpperCase() == "SUCCESS";
}