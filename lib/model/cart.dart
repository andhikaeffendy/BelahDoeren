class Cart{
  int id;
  int menuId;
  String menuName;
  String imageUrl;
  int quantity;
  int price;
  int subTotal;
  String priceText;
  String subTotalText;

  Cart(
      this.id,
      this.menuId,
      this.menuName,
      this.imageUrl,
      this.quantity,
      this.price,
      this.subTotal,
      this.priceText,
      this.subTotalText,
      );

  Cart.fromJson(Map<String, dynamic> json) :
        id = json["id"],
        quantity = json["quantity"],
        menuId = json["menu_id"],
        menuName = json["menu_name"],
        imageUrl = json["image_url"],
        price = json["price"],
        subTotal = json["sub_total"],
        priceText = json["price_str"],
        subTotalText = json["sub_total_str"];

  Map<String, dynamic> toJson() => {
    "id": id,
    "cart_id": id,
    "menu_id": menuId,
    "menu_name": menuName,
    "image_url": imageUrl,
    "quantity": quantity,
    "price": price,
    "sub_total": subTotal,
    "price_str": priceText,
    "sub_total_str": subTotalText,
  };
}