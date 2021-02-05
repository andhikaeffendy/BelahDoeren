class MenuCategory{
  int id;
  String name;

  MenuCategory(
      this.id,
      this.name,
      );

  MenuCategory.fromJson(Map<String, dynamic> json) :
        id = json["id"],
        name = json["name"];

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}