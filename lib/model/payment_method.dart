class PaymentMethod{
  int id;
  String name;
  String description;
  String image_url;

  PaymentMethod(
      this.id,
      this.name,
      this.description,
      this.image_url
      );

  PaymentMethod.fromJson(Map<String, dynamic> json) :
        id = json["id"],
        name = json["name"],
        description = json["description"],
        image_url = json["image_url"]
  ;

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "image_url" : image_url
  };

}