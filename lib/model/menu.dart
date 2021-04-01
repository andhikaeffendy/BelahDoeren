class Menu{
  int id;
  String name;
  String description;
  int price;
  int new_price;
  int activeStatus;
  int featured;
  String imageUrl;
  int stock_status;

  Menu(
      this.id,
      this.name,
      this.description,
      this.price,
      this.new_price,
      this.activeStatus,
      this.featured,
      this.imageUrl,
      this.stock_status
      );

  Menu.fromJson(Map<String, dynamic> json) :
        id = json["id"],
        name = json["name"],
        description = json["description"],
        price = json["price"],
        new_price = json["new_price"],
        activeStatus = json["active_status"],
        featured = json["featured"],
        imageUrl = json["image_url"],
        stock_status = json["stock_status"]
  ;

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "price": price,
    "new_price" : new_price,
    "active_status": activeStatus,
    "featured": featured,
    "image_url": imageUrl,
    "stock_status" : stock_status,
  };

}