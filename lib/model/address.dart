class Address {
  int id;
  String name;
  String address;
  String lat;
  String long;

  Address({this.id, this.name, this.address, this.lat, this.long});

  Address.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        address = json["address"],
        lat = json["lat"],
        long = json["long"];

  Map<String, dynamic> toJson() =>
      {"id": id, "name": name, "address": address, "lat": lat, "long": long};
}
