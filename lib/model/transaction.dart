class Transaction {
  int id;
  String transaction_number;
  String total_price;
  String tax;
  String grand_total;
  String discount;
  String voucher_code;
  String transaction_status;
  String transaction_date;
  String transaction_status_name;

  Transaction({this.id, this.transaction_number, this.total_price, this.tax,
      this.grand_total, this.discount, this.voucher_code,
    this.transaction_status, this.transaction_date, this.transaction_status_name});

  Transaction.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        transaction_number = json["transaction_number"],
        total_price = json["total_price"],
        tax = json["tax"],
        grand_total = json["grand_total"],
        discount = json["discount"],
        voucher_code = json["voucher_code"],
        transaction_status = json["transaction_status_name"],
        transaction_date = json["transaction_date_name"],
        transaction_status_name = json["transaction_status_name"];

  Map<String, dynamic> toJson() => {
    "id": id,
    "transaction_number" : transaction_number,
    "total_price" : total_price,
    "tax" : tax,
    "grand_total" : grand_total,
    "discount" : discount,
    "voucher_code" : voucher_code,
    "transaction_status" : transaction_status,
    "transaction_date" : transaction_date,
    "transaction_status_name" : transaction_status_name,
  };

  bool isPaid(){
    return this.transaction_status.toUpperCase() == "LUNAS";
  }

}
