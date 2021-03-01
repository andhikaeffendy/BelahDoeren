import 'dart:io';
import 'package:belah_duren/global/variable.dart';
import 'package:belah_duren/model/cart.dart';
import 'package:belah_duren/model/global_response.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

Future<GlobalResponse> futureApiAddToCart(String token,
    int menu_id, int quantity, int price, String note) async{
  var dio = Dio();
  String url = api_url + "add_to_cart";
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  FormData formData = new FormData.fromMap({
    "menu_id": menu_id,
    "quantity": quantity,
    "price": price,
    "note" : note
  });
  Response response = await dio.post(url, data: formData);
  print(response.data);

  return GlobalResponse.fromStringJson(response.toString());
}

Future<ApiCart> futureApiCartList(String token) async{
  var dio = Dio();
    String url = api_url + "carts_list";
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  Response response = await dio.get(url);
  print(response.data);

  return ApiCart.fromStringJson(response.toString());
}

Future<GlobalResponse> futureApiChangeQuantityCart(String token, int cart_id,
    int quantity) async{
  var dio = Dio();
  String url = api_url + "change_quantity_to_cart/"+cart_id.toString();
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  FormData formData = new FormData.fromMap({
    "quantity": quantity,
  });
  Response response = await dio.post(url, data: formData);
  print(response.data);

  return GlobalResponse.fromStringJson(response.toString());
}

Future<GlobalResponse> futureApiChangeNotesCart(String token,int cart_id, String note) async{
  var dio = Dio();
  String url = api_url + "update_cart_note/"+cart_id.toString();
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  FormData formData = new FormData.fromMap({
    "note": note,
  });
  Response response = await dio.post(url, data: formData);
  print(response.data);

  return GlobalResponse.fromStringJson(response.toString());
}

Future<GlobalResponse> futureApiRemoveCart(String token, int cart_id) async{
  var dio = Dio();
  String url = api_url + "remove_from_cart/"+cart_id.toString();
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  Response response = await dio.delete(url);
  print(response.data);

  return GlobalResponse.fromStringJson(response.toString());
}

Future<GlobalResponse> futureApiSubmitCart(String token, int branch_id,
    int order_type, List<Cart> carts, [int discount = 0,
      String voucher = "", int address_id = 0]) async{
  var dio = Dio();
  String url = api_url + "submit_order";
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  var data = {
    "branch_id": branch_id,
    "transaction_type_id": order_type,
    "discount": discount,
    "voucher_code": voucher,
    "carts": toStringJson(carts),
  };
  if(address_id > 0) data["my_address_id"] = address_id;
  FormData formData = new FormData.fromMap(data);
  Response response = await dio.post(url, data: formData);
  print(response.data);

  return GlobalResponse.fromStringJson(response.toString());
}

class ApiCart {
  String status;
  String message;
  List<Cart> data;

  ApiCart({
    this.status,
    this.message,
    this.data,
  });

  ApiCart.fromJson(Map<String, dynamic> json) :
        status = json["status"],
        message = json["message"],
        data = List<Cart>.from(json["data"].map((x) => Cart.fromJson(x)));

  ApiCart.fromStringJson(String stringJson) :
        this.fromJson(json.decode(stringJson));

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };

  String toStringJson() => json.encode(this.toJson());

  bool isSuccess() => status.toUpperCase() == "SUCCESS";
}

String toStringJson(List<Cart> carts) => json.encode(List<dynamic>.from(carts.map((x) => x.toJson())));
