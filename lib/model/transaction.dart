class Transaction {
  int id;
  String transaction_number;
  String transaction_type;
  String payment_method;
  String image_url;
  String total_price;
  String tax;
  String grand_total;
  String discount;
  String voucher_code;
  String description;
  int transaction_status;
  String transaction_status_name;
  String transaction_status_color;
  String transaction_date;
  String transaction_date_name;


  Transaction({
    this.id,
    this.transaction_number,
    this.transaction_type,
    this.payment_method,
    this.image_url,
    this.total_price,
    this.tax,
    this.grand_total,
    this.discount,
    this.voucher_code,
    this.description,
    this.transaction_status,
    this.transaction_status_name,
    this.transaction_status_color,
    this.transaction_date,
    this.transaction_date_name});

  Transaction.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        transaction_number = json["transaction_number"],
        transaction_type = json["transaction_type"],
        payment_method = json["payment_method"],
        image_url = json["image_url"],
        total_price = json["total_price"],
        tax = json["tax"],
        grand_total = json["grand_total"],
        discount = json["discount"],
        voucher_code = json["voucher_code"],
        description = json["description"],
        transaction_status = json["transaction_status"],
        transaction_status_name = json["transaction_status_name"],
        transaction_status_color = json["transaction_status_color"],
        transaction_date = json["transaction_date"],
        transaction_date_name = json["transaction_date_name"];

  Map<String, dynamic> toJson() => {
    "id": id,
    "transaction_number" : transaction_number,
    "transaction_type" : transaction_type,
    "payment_method" : payment_method,
    "image_url" : image_url,
    "total_price" : total_price,
    "tax" : tax,
    "grand_total" : grand_total,
    "discount" : discount,
    "voucher_code" : voucher_code,
    "description" : description,
    "transaction_status" : transaction_status,
    "transaction_status_name" : transaction_status_name,
    "transaction_status_color" : transaction_status_color,
    "transaction_date" : transaction_date,
    "transaction_date_name" : transaction_date_name,
  };

  bool isPaid(){
    return this.transaction_status == 3;
  }

}
