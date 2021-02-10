import 'package:belah_duren/model/menu.dart';

class MenuCategory{
  int id;
  String name;
  List<Menu> menus = [];

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