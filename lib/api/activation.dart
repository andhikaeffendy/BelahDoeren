import 'package:belah_duren/global/error_message.dart';
import 'package:belah_duren/global/variable.dart';
import 'package:belah_duren/model/global_response.dart';
import 'package:dio/dio.dart';

Future<GlobalResponse> futureApiActivation(String email,
    String activation_code) async{
  var dio = Dio();
  String url = api_url + "activation";
  FormData formData = new FormData.fromMap({
    "email": email,
    "activation_code": activation_code,
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