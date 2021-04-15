import 'dart:io';
import 'package:belah_duren/global/error_message.dart';
import 'package:belah_duren/global/variable.dart';
import 'package:belah_duren/model/global_response.dart';
import 'package:belah_duren/model/transaction.dart';
import 'package:belah_duren/model/transaction_list.dart';
import 'package:belah_duren/model/user.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

Future<ApiTransaction> futureApiTransaction(String token, int userId) async{
  var dio = Dio();
  String url = api_url + "transactions_list?user_id=" + userId.toString();
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  try {
    Response response = await dio.get(url);
    // print(response.data);
    return ApiTransaction.fromStringJson(response.toString());
  } on DioError catch (e) {
    if (e.response != null ) {
      return ApiTransaction(status: "fail", message: ErrorMessage.getMessage(e.response.statusCode));
    } else {
      return ApiTransaction(status: "fail", message: ErrorMessage.getMessage(0));
    }
  }
}

Future<ApiActiveTransaction> futureApiActiveTransaction(String token, int userId) async{
  var dio = Dio();
  String url = api_url + "active_transactions_list?user_id=" + userId.toString();
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  try {
    Response response = await dio.get(url);
    // print(response.data);
    return ApiActiveTransaction.fromStringJson(response.toString());
  } on DioError catch (e) {
    if (e.response != null ) {
      return ApiActiveTransaction(status: "fail", message: ErrorMessage.getMessage(e.response.statusCode));
    } else {
      return ApiActiveTransaction(status: "fail", message: ErrorMessage.getMessage(0));
    }
  }
}

Future<ApiPastTransaction> futureApiPastTransaction(String token, int userId) async{
  var dio = Dio();
  String url = api_url + "past_transactions_list?user_id=" + userId.toString();
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  try {
    Response response = await dio.get(url);
    // print(response.data);
    return ApiPastTransaction.fromStringJson(response.toString());
  } on DioError catch (e) {
    if (e.response != null ) {
      return ApiPastTransaction(status: "fail", message: ErrorMessage.getMessage(e.response.statusCode));
    } else {
      return ApiPastTransaction(status: "fail", message: ErrorMessage.getMessage(0));
    }
  }
}

Future<ApiTransactionDetail> futureApiTransactionDetail(String token, int id) async{
  var dio = Dio();
  String url = api_url + "transaction_detail?id=" + id.toString();
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  try {
    Response response = await dio.get(url);
    // print(response.data);
    return ApiTransactionDetail.fromStringJson(response.toString());
  } on DioError catch (e) {
    if (e.response != null ) {
      return ApiTransactionDetail(status: "fail", message: ErrorMessage.getMessage(e.response.statusCode));
    } else {
      return ApiTransactionDetail(status: "fail", message: ErrorMessage.getMessage(0));
    }
  }
}

Future<ApiListTransaction> futureApiGetActiveTransaction(String token) async{
  var dio = Dio();
  String url = api_url + "active_transactions_list";
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  try {
    Response response = await dio.get(url);
    // print(response.data);
    return ApiListTransaction.fromStringJson(response.toString());
  } on DioError catch (e) {
    if (e.response != null ) {
      return ApiListTransaction(status: "fail", message: ErrorMessage.getMessage(e.response.statusCode));
    } else {
      return ApiListTransaction(status: "fail", message: ErrorMessage.getMessage(0));
    }
  }
}

Future<ApiListTransaction> futureApiGetPastTransaction(String token) async{
  var dio = Dio();
  String url = api_url + "past_transactions_list";
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  try {
    Response response = await dio.get(url);
    // print(response.data);
    return ApiListTransaction.fromStringJson(response.toString());
  } on DioError catch (e) {
    if (e.response != null ) {
      return ApiListTransaction(status: "fail", message: ErrorMessage.getMessage(e.response.statusCode));
    } else {
      return ApiListTransaction(status: "fail", message: ErrorMessage.getMessage(0));
    }
  }
}

Future<ApiListTransaction> futureApiGetCanceledTransaction(String token) async{
  var dio = Dio();
  String url = api_url + "cancelled_transactions_list";
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  try {
    Response response = await dio.get(url);
    // print(response.data);
    return ApiListTransaction.fromStringJson(response.toString());
  } on DioError catch (e) {
    if (e.response != null ) {
      return ApiListTransaction(status: "fail", message: ErrorMessage.getMessage(e.response.statusCode));
    } else {
      return ApiListTransaction(status: "fail", message: ErrorMessage.getMessage(0));
    }
  }
}

Future<GlobalResponse> futureApiCancelTransaction(String token, int id) async{
  var dio = Dio();
  String url = api_url + "cancel_order/" + id.toString();
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  try {
    Response response = await dio.post(url);
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

class ApiTransaction {
  String status;
  String message;
  List<Transaction> data;

  ApiTransaction({
    this.status,
    this.message,
    this.data
  });

  ApiTransaction.fromJson(Map<String, dynamic> json) :
        status = json["status"],
        message = json["message"],
        data = json.containsKey("data") ? List<Transaction>.from(json["data"].map((x) => Transaction.fromJson(x))) : null ;

  ApiTransaction.fromStringJson(String stringJson) :
        this.fromJson(json.decode(stringJson));

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };

  String toStringJson() => json.encode(this.toJson());

  bool isSuccess() => status.toUpperCase() == "SUCCESS";

}

class ApiActiveTransaction {
  String status;
  String message;
  List<Transaction> data;

  ApiActiveTransaction({this.status, this.message, this.data});

  ApiActiveTransaction.fromJson(Map<String, dynamic> json) :
        status = json["status"],
        message = json["message"],
        data = json.containsKey("data") ? List<Transaction>.from(json["data"].map((x) => Transaction.fromJson(x))) : null ;

  ApiActiveTransaction.fromStringJson(String stringJson) :
        this.fromJson(json.decode(stringJson));

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };

  String toStringJson() => json.encode(this.toJson());

  bool isSuccess() => status.toUpperCase() == "SUCCESS";

}

class ApiPastTransaction {
  String status;
  String message;
  List<Transaction> data;

  ApiPastTransaction({this.status, this.message, this.data});

  ApiPastTransaction.fromJson(Map<String, dynamic> json) :
        status = json["status"],
        message = json["message"],
        data = json.containsKey("data") ? List<Transaction>.from(json["data"].map((x) => Transaction.fromJson(x)))  : null ;

  ApiPastTransaction.fromStringJson(String stringJson) :
        this.fromJson(json.decode(stringJson));

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };

  String toStringJson() => json.encode(this.toJson());

  bool isSuccess() => status.toUpperCase() == "SUCCESS";

}

class ApiTransactionDetail {
  String status;
  String message;
  List<Transaction> data;

  ApiTransactionDetail({this.status, this.message, this.data});

  ApiTransactionDetail.fromJson(Map<String, dynamic> json) :
        status = json["status"],
        message = json["message"],
        data = json.containsKey("data") ? List<Transaction>.from(json["data"].map((x) => Transaction.fromJson(x))) : null ;

  ApiTransactionDetail.fromStringJson(String stringJson) :
        this.fromJson(json.decode(stringJson));

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };

  String toStringJson() => json.encode(this.toJson());

  bool isSuccess() => status.toUpperCase() == "SUCCESS";

}

class ApiListTransaction {
  String status;
  String message;
  List<Transaction> data;

  ApiListTransaction({
    this.status,
    this.message,
    this.data
  });

  ApiListTransaction.fromJson(Map<String, dynamic> json) :
        status = json["status"],
        message = json["message"],
        data = json.containsKey("data") ? List<Transaction>.from(json["data"].map((x) => Transaction.fromJson(x))) : null ;

  ApiListTransaction.fromStringJson(String stringJson) :
        this.fromJson(json.decode(stringJson));

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };

  String toStringJson() => json.encode(this.toJson());

  bool isSuccess() => status.toUpperCase() == "SUCCESS";

}