class SliderMenu{
  int id;
  String name;
  String description;
  String imageUrl;

  SliderMenu(
      this.id,
      this.description,
      this.name,
      this.imageUrl
      );

  SliderMenu.fromJson(Map<String, dynamic> json) :
        id = json["id"],
        description = json["description"],
        name = json["name"],
        imageUrl = json["image_url"];

  Map<String, dynamic> toJson() => {
    "id": id,
    "description": description,
    "name": name,
    "image_url": imageUrl,
  };
}