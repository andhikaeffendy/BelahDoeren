import 'package:belah_duren/global/location.dart';
import 'package:belah_duren/global/variable.dart';

class Branch{
  int id;
  String name;
  String address;
  double latitude;
  double longitude;
  String imageUrl;

  Branch(
      this.id,
      this.name,
      this.address,
      this.latitude,
      this.longitude,
      this.imageUrl,
      );

  Branch.fromJson(Map<String, dynamic> json) :
        id = json["id"],
        name = json["name"],
        address = json["address"],
        latitude = json["lat"] is String ? double.parse(json["lat"]) : json["lat"],
        longitude = json["long"] is String ? double.parse(json["long"]) : json["long"],
        imageUrl = json["image_url"]
  ;

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "address": address,
    "lat": latitude,
    "long": longitude,
    "image_url": imageUrl,
  };

  String distanceFromHere(){
    if(currentPosition == null) return "Posisi belum ditemukan";
    double distance = this.distanceFrom(currentPosition.latitude,
        currentPosition.longitude);
    return distance.toStringAsFixed(1) + " KM";
  }

  double distance(){
    double distance = distanceBetween(currentPosition.latitude,
        currentPosition.longitude, this.latitude, this.longitude);
    if(distance < 100 ) return 0.1;
    return distance/1000;
  }

  double distanceFrom(double lat, double long){
    double distance = distanceBetween(lat, long,
        this.latitude, this.longitude);
    if(distance < 100 ) return 0.1;
    return distance/1000;
  }
}