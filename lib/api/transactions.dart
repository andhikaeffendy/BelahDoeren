import 'dart:io';
import 'package:belah_duren/global/variable.dart';
import 'package:belah_duren/model/transaction.dart';
import 'package:belah_duren/model/user.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

Future<ApiTransaction> futureApiTransaction(String token, int userId) async{
  var dio = Dio();
  String url = api_url + "transactions_list?user_id=" + userId.toString();
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  Response response = await dio.get(url);
  print("response : " + response.toString());
  print(response.data);

  return ApiTransaction.fromStringJson(response.toString());
}

Future<ApiActiveTransaction> futureApiActiveTransaction(String token, int userId) async{
  var dio = Dio();
  String url = api_url + "active_transactions_list?user_id=" + userId.toString();
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  Response response = await dio.get(url);
  print("response : " + response.toString());
  print(response.data);

  return ApiActiveTransaction.fromStringJson(response.toString());
}

Future<ApiPastTransaction> futureApiPastTransaction(String token, int userId) async{
  var dio = Dio();
  String url = api_url + "past_transactions_list?user_id=" + userId.toString();
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  Response response = await dio.get(url);
  print("response : " + response.toString());
  print(response.data);

  return ApiPastTransaction.fromStringJson(response.toString());
}

Future<ApiTransactionDetail> futureApiTransactionDetail(String token, int id) async{
  var dio = Dio();
  String url = api_url + "transaction_detail?id=" + id.toString();
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  Response response = await dio.get(url);
  print("response : " + response.toString());
  print(response.data);

  return ApiTransactionDetail.fromStringJson(response.toString());
}


class ApiTransaction {
  String status;
  String message;
  List<Transaction> data;

  ApiTransaction({this.status, this.message, this.data});

  ApiTransaction.fromJson(Map<String, dynamic> json) :
        status = json["status"],
        message = json["message"],
        data = List<Transaction>.from(json["data"].map((x) => Transaction.fromJson(x)));

  ApiTransaction.fromStringJson(String stringJson) :
        this.fromJson(json.decode(stringJson));

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };

  String toStringJson() => json.encode(this.toJson());

  bool isSuccess() => status == "success";

}

class ApiActiveTransaction {
  String status;
  String message;
  List<Transaction> data;

  ApiActiveTransaction({this.status, this.message, this.data});

  ApiActiveTransaction.fromJson(Map<String, dynamic> json) :
        status = json["status"],
        message = json["message"],
        data = List<Transaction>.from(json["data"].map((x) => Transaction.fromJson(x)));

  ApiActiveTransaction.fromStringJson(String stringJson) :
        this.fromJson(json.decode(stringJson));

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };

  String toStringJson() => json.encode(this.toJson());

  bool isSuccess() => status == "success";

}

class ApiPastTransaction {
  String status;
  String message;
  List<Transaction> data;

  ApiPastTransaction({this.status, this.message, this.data});

  ApiPastTransaction.fromJson(Map<String, dynamic> json) :
        status = json["status"],
        message = json["message"],
        data = List<Transaction>.from(json["data"].map((x) => Transaction.fromJson(x)));

  ApiPastTransaction.fromStringJson(String stringJson) :
        this.fromJson(json.decode(stringJson));

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };

  String toStringJson() => json.encode(this.toJson());

  bool isSuccess() => status == "success";

}

class ApiTransactionDetail {
  String status;
  String message;
  List<Transaction> data;

  ApiTransactionDetail({this.status, this.message, this.data});

  ApiTransactionDetail.fromJson(Map<String, dynamic> json) :
        status = json["status"],
        message = json["message"],
        data = List<Transaction>.from(json["data"].map((x) => Transaction.fromJson(x)));

  ApiTransactionDetail.fromStringJson(String stringJson) :
        this.fromJson(json.decode(stringJson));

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };

  String toStringJson() => json.encode(this.toJson());

  bool isSuccess() => status == "success";

}