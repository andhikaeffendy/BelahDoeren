import 'package:belah_duren/global/error_message.dart';
import 'package:belah_duren/global/variable.dart';
import 'package:belah_duren/model/global_response.dart';
import 'package:dio/dio.dart';

Future<GlobalResponse> futureApiRegister(String email, String name,
    String password, String password_confirmation, String phone_number) async{
  var dio = Dio();
  String url = api_url + "register";
  FormData formData = new FormData.fromMap({
    "email": email,
    "name": name,
    "password": password,
    "password_confirmation": password_confirmation,
    "phone_number" : phone_number
  });
  Options(
    followRedirects: false,
    validateStatus: (status) {return status <500;}
  );
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