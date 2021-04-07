class PaymentMethod{
  int id;
  String name;
  String description;

  PaymentMethod(
      this.id,
      this.name,
      this.description,
      );

  PaymentMethod.fromJson(Map<String, dynamic> json) :
        id = json["id"],
        name = json["name"],
        description = json["description"]
  ;

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description
  };

}