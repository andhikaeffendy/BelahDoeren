import 'dart:io';
import 'package:belah_duren/global/error_message.dart';
import 'package:belah_duren/global/variable.dart';
import 'package:belah_duren/model/cart.dart';
import 'package:belah_duren/model/global_response.dart';
import 'package:belah_duren/model/transaction.dart';
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
  try {
    Response response = await dio.post(url, data: formData);
    // print(response.data);
    return GlobalResponse.fromStringJson(response.toString());
  } on DioError catch (e) {
    if (e.response != null ) {
      return GlobalResponse(status: "fail", message: ErrorMessage.getMessage(e.response.statusCode));
    } else {
      return GlobalResponse(status: "fail", message: ErrorMessage.getMessage(0));
    }
  }
}

Future<ApiCart> futureApiCartList(String token) async{
  var dio = Dio();
    String url = api_url + "carts_list";
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  try {
    Response response = await dio.get(url);
    // print(response.data);
    return ApiCart.fromStringJson(response.toString());
  } on DioError catch (e) {
    if (e.response != null ) {
      return ApiCart(status: "fail", message: ErrorMessage.getMessage(e.response.statusCode));
    } else {
      return ApiCart(status: "fail", message: ErrorMessage.getMessage(0));
    }
  }
}

Future<ApiCart> futureApiCartListCheckBranch(String token, int branch_id) async{
  var dio = Dio();
  String url = api_url + "carts_list?branch_id=" + branch_id.toString();
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  try {
    Response response = await dio.get(url);
    // print(response.data);
    return ApiCart.fromStringJson(response.toString());
  } on DioError catch (e) {
    if (e.response != null ) {
      return ApiCart(status: "fail", message: ErrorMessage.getMessage(e.response.statusCode));
    } else {
      return ApiCart(status: "fail", message: ErrorMessage.getMessage(0));
    }
  }
}

Future<GlobalResponse> futureApiChangeQuantityCart(String token, int cartId,
    int quantity) async{
  var dio = Dio();
  String url = api_url + "change_quantity_to_cart/"+cartId.toString();
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  FormData formData = new FormData.fromMap({
    "quantity": quantity,
  });
  try {
    Response response = await dio.post(url, data: formData);
    // print(response.data);
    return GlobalResponse.fromStringJson(response.toString());
  } on DioError catch (e) {
    if (e.response != null ) {
      return GlobalResponse(status: "fail", message: ErrorMessage.getMessage(e.response.statusCode));
    } else {
      return GlobalResponse(status: "fail", message: ErrorMessage.getMessage(0));
    }
  }
}

Future<GlobalResponse> futureApiChangeNotesCart(String token,int cart_id, String note) async{
  var dio = Dio();
  String url = api_url + "update_cart_note/"+cart_id.toString();
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  FormData formData = new FormData.fromMap({
    "note": note,
  });
  try {
    Response response = await dio.post(url, data: formData);
    // print(response.data);
    return GlobalResponse.fromStringJson(response.toString());
  } on DioError catch (e) {
    if (e.response != null ) {
      return GlobalResponse(status: "fail", message: ErrorMessage.getMessage(e.response.statusCode));
    } else {
      return GlobalResponse(status: "fail", message: ErrorMessage.getMessage(0));
    }
  }
}

Future<GlobalResponse> futureApiRemoveCart(String token, int cart_id) async{
  var dio = Dio();
  String url = api_url + "remove_from_cart/"+cart_id.toString();
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  try {
    Response response = await dio.delete(url);
    // print(response.data);
    return GlobalResponse.fromStringJson(response.toString());
  } on DioError catch (e) {
    if (e.response != null ) {
      return GlobalResponse(status: "fail", message: ErrorMessage.getMessage(e.response.statusCode));
    } else {
      return GlobalResponse(status: "fail", message: ErrorMessage.getMessage(0));
    }
  }
}

Future<ApiSubmit> futureApiSubmitCart(String token, String order_id, int branch_id,
    int order_type, List<Cart> carts, int payment_method_id, [int discount = 0,
      String voucher = "", int address_id = 0]) async{
  var dio = Dio();
  String url = api_url + "submit_order_payment";
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  var data = {
    // "order_id": order_id,
    "branch_id": branch_id,
    "transaction_type_id": order_type,
    "discount": discount,
    "voucher_code": voucher,
    "payment_method_id": payment_method_id,
    "carts": toStringJson(carts),
  };
  if(address_id > 0) data["my_address_id"] = address_id;
  FormData formData = new FormData.fromMap(data);
  try {
    Response response = await dio.post(url, data: formData);
    // print(response.data);
    return ApiSubmit.fromStringJson(response.toString());
  } on DioError catch (e) {
    if (e.response != null ) {
      return ApiSubmit(status: "fail", message: ErrorMessage.getMessage(e.response.statusCode));
    } else {
      return ApiSubmit(status: "fail", message: ErrorMessage.getMessage(0));
    }
  }
}

class ApiSubmit {
  String status;
  String message;
  int transactionStatus;
  String deadline;
  String vaBank;
  String vaNumber;
  String billerCode;
  String billKey;
  int id;
  String qrCode;
  String deeplink;

  ApiSubmit({
    this.status,
    this.message,
    this.transactionStatus,
    this.deadline,
    this.vaBank,
    this.vaNumber,
    this.billerCode,
    this.billKey,
    this.id,
    this.qrCode,
    this.deeplink,
  });

  ApiSubmit.fromJson(Map<String, dynamic> json) :
        status = json["status"],
        message = json["message"],
        transactionStatus = json.containsKey("transaction_status") ? json["transaction_status"] : 0,
        deadline = json.containsKey("deadline") ? json["deadline"] : "",
        vaNumber = json.containsKey("va_number") ? json["va_number"] : "",
        vaBank = json.containsKey("va_bank") ? json["va_bank"] : "",
        billerCode = json.containsKey("biller_code") ? json["biller_code"] : "",
        billKey = json.containsKey("bill_key") ? json["bill_key"] : "",
        id = json.containsKey("id") ? json["id"] : 0,
        qrCode = json.containsKey("qr_code") ? json["qr_code"] : "",
        deeplink = json.containsKey("deeplink") ? json["deeplink"] : "";

  ApiSubmit.fromStringJson(String stringJson) :
        this.fromJson(json.decode(stringJson));

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "transaction_status": transactionStatus,
    "deadline": deadline,
    "va_bank": vaBank,
    "va_number": vaNumber,
    "biller_code": billerCode,
    "bill_key": billKey,
    "id": id,
    "qr_code": qrCode,
    "deeplink": deeplink,
  };

  String toStringJson() => json.encode(this.toJson());

  String bankName(){
    var splits = vaBank.split("_");
    if(splits.length == 2) return splits[0]+ " "+splits[1];
    return vaBank;
  }

  bool isSuccess() => status.toUpperCase() == "SUCCESS" ;
}

class ApiCart {
  String status;
  String message;
  int discountMember;
  String discountMemberStr;
  List<Cart> data;

  ApiCart({
    this.status,
    this.message,
    this.discountMember,
    this.discountMemberStr,
    this.data,
  });

  ApiCart.fromJson(Map<String, dynamic> json) :
        status = json["status"],
        message = json["message"],
        discountMember = json.containsKey("discount_member") ? json["discount_member"] : 0,
        discountMemberStr = json.containsKey("discount_member_str") ? json["discount_member_str"] : "0",
        data = json.containsKey("data") ? List<Cart>.from(json["data"].map((x) => Cart.fromJson(x))) : null;

  ApiCart.fromStringJson(String stringJson) :
        this.fromJson(json.decode(stringJson));

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "discount_member": discountMember,
    "discount_member_str": discountMemberStr,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };

  String toStringJson() => json.encode(this.toJson());

  bool isSuccess() => status.toUpperCase() == "SUCCESS" || status.toUpperCase() == "ADJUSTMENT" ;
}

String toStringJson(List<Cart> carts) => json.encode(List<dynamic>.from(carts.map((x) => x.toJson())));
