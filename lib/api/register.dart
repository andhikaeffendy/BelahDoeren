import 'package:belah_duren/global/variable.dart';
import 'package:belah_duren/model/global_response.dart';
import 'package:dio/dio.dart';

Future<GlobalResponse> futureApiRegister(String email, String name,
    String password, String password_confirmation) async{
  var dio = Dio();
  String url = api_url + "register";
  FormData formData = new FormData.fromMap({
    "email": email,
    "name": name,
    "password": password,
    "password_confirmation": password_confirmation,
  });
  Response response = await dio.post(url, data: formData);
  print(response.data);

  return GlobalResponse.fromStringJson(response.toString());
}