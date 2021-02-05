import 'dart:io';
import 'package:belah_duren/global/variable.dart';
import 'package:belah_duren/model/menu.dart';
import 'package:belah_duren/model/menu_category.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

Future<ApiMenuCategory> futureApiMenuCategories(String token) async{
  var dio = Dio();
  String url = api_url + "menu_categories_list";
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  Response response = await dio.get(url);
  print(response.data);

  return ApiMenuCategory.fromStringJson(response.toString());
}

Future<ApiMenu> futureApiMenus(String token, int categoryId) async{
  var dio = Dio();
  String url = api_url + "menus_list?menu_category_id="+categoryId.toString();
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  Response response = await dio.get(url);
  print(response.data);

  return ApiMenu.fromStringJson(response.toString());
}

Future<ApiMenu> futureApiFeaturedMenus(String token) async{
  var dio = Dio();
  String url = api_url + "featured_menus_list";
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  Response response = await dio.get(url);
  print(response.data);

  return ApiMenu.fromStringJson(response.toString());
}

Future<ApiMenuDetail> futureApiMenu(String token, int menuId) async{
  var dio = Dio();
  String url = api_url + "detail_menu?id="+menuId.toString();
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  Response response = await dio.get(url);
  print(response.data);

  return ApiMenuDetail.fromStringJson(response.toString());
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
        data = Menu.fromJson(json);

  ApiMenuDetail.fromStringJson(String stringJson) :
        this.fromJson(json.decode(stringJson));

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };

  String toStringJson() => json.encode(this.toJson());

  bool isSuccess() => status == "success";
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
        data = List<MenuCategory>.from(json["data"].map((x) => MenuCategory.fromJson(x)));

  ApiMenuCategory.fromStringJson(String stringJson) :
        this.fromJson(json.decode(stringJson));

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };

  String toStringJson() => json.encode(this.toJson());

  bool isSuccess() => status == "success";
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
        data = List<Menu>.from(json["data"].map((x) => Menu.fromJson(x)));

  ApiMenu.fromStringJson(String stringJson) :
        this.fromJson(json.decode(stringJson));

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };

  String toStringJson() => json.encode(this.toJson());

  bool isSuccess() => status == "success";
}