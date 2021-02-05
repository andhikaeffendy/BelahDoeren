class Menu{
  int id;
  String name;
  String description;
  double price;
  int activeStatus;
  int featured;
  String imageUrl;

  Menu(
      this.id,
      this.name,
      this.description,
      this.price,
      this.activeStatus,
      this.featured,
      this.imageUrl,
      );

  Menu.fromJson(Map<String, dynamic> json) :
        id = json["id"],
        name = json["name"],
        description = json["description"],
        price = json["price"],
        activeStatus = json["active_status"],
        featured = json["featured"],
        imageUrl = json["image_url"]
  ;

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "price": price,
    "active_status": activeStatus,
    "featured": featured,
    "image_url": imageUrl,
  };
}