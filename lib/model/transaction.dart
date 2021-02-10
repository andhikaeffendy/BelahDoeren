class Transaction {
  int id;
  double transaction_number;
  double total_price;
  int tax;
  double grand_total;
  double discount;
  String voucher_code;

  Transaction({this.id, this.transaction_number, this.total_price, this.tax,
      this.grand_total, this.discount, this.voucher_code});

  Transaction.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        transaction_number = json["transaction_number"],
        total_price = json["total_price"],
        tax = json["tax"],
        grand_total = json["grand_total"],
        discount = json["discount"],
        voucher_code = json["voucher_code"];

  Map<String, dynamic> toJson() => {
    "id": id,
    "transaction_number" : transaction_number,
    "total_price" : total_price,
    "tax" : tax,
    "grand_total" : grand_total,
    "discount" : discount,
    "voucher_code" : voucher_code
  };

}
