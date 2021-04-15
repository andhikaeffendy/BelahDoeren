import 'dart:convert';
import 'package:dio/dio.dart';

Future<ApiPlace> futureApiAutocompletePlace(String input, String sessionToken) async{
  if(input.length < 3 ) return null;
  var dio = Dio();
  String url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';

  try {
    Response response = await dio.get(url, queryParameters: {
      "input" : input,
      "language" : "id",
      "region" : "id",
      "types" : "address",
      "key" : "AIzaSyDllOyM0HSlXy3UPYq02Z6I5CZ3dOivAxc",
      "sessiontoken" : sessionToken,
    });
    print(response.data);
    return ApiPlace.fromStringJson(response.toString());
  } on DioError catch (e) {
    if (e.response != null ) {
      return ApiPlace(predictions: null);
    } else {
      return ApiPlace(predictions: null);
    }
  }
}

class ApiPlace {
  List<Prediction> predictions;

  ApiPlace({
    this.predictions,
  });

  ApiPlace.fromJson(Map<String, dynamic> json) :
        predictions = json.containsKey("predictions") ? List<Prediction>.from(json["predictions"].map((x) => Prediction.fromJson(x))) : null ;

  ApiPlace.fromStringJson(String stringJson) :
        this.fromJson(json.decode(stringJson));

  Map<String, dynamic> toJson() => {
    "predictions": List<dynamic>.from(predictions.map((x) => x.toJson())),
  };

  String toStringJson() => json.encode(this.toJson());

}

class Prediction {
  String description;

  Prediction({
    this.description,
  });

  Prediction.fromJson(Map<String, dynamic> json) :
        description = json["description"];

  Map<String, dynamic> toJson() => {
    "description": description,
  };
}