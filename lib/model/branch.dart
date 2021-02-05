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
        latitude = json["lat"],
        longitude = json["long"],
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
}