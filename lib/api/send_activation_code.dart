import 'package:belah_duren/global/variable.dart';
import 'package:belah_duren/model/global_response.dart';
import 'package:dio/dio.dart';

Future<GlobalResponse> futureApiSendActivationCode(String email) async{
  var dio = Dio();
  String url = api_url + "send_activation_code";
  FormData formData = new FormData.fromMap({
    "email": email,
  });
  Response response = await dio.post(url, data: formData);
  print(response.data);

  return GlobalResponse.fromStringJson(response.toString());
}