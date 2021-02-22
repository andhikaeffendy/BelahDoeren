class Items{
  int id;
  int menu_id;
  String menu_name;
  int quantity;
  String price;
  String sub_total;
  String discount;

  Items({
    this.id,
    this.menu_id,
    this.menu_name,
    this.quantity,
    this.price,
    this.sub_total,
    this.discount});

  Items.fromJson(Map<String, dynamic> json) :
      id = json["id"],
      menu_id = json["menu_id"],
      menu_name = json["menu_name"],
      quantity = json["quantity"],
      price = json["price"],
      sub_total = json["sub_total"],
      discount = json["discount"];

  Map<String, dynamic> toJson() => {
    "id" : id,
    "menu_id" : menu_id,
    "menu_name" : menu_name,
    "quantity" : quantity,
    "price" : price,
    "sub_total" : sub_total,
    "discount" : discount
  };

}