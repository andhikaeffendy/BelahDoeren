import 'package:belah_duren/model/order.dart';

class DetailTransaction{
    int id;
    String transaction_number;
    String total_price;
    String tax;
    String grand_total;
    String discount;
    String voucher_code;
    String branch_name;
    String my_address;
    String payment_method;
    String payment_method_image_url;
    String transaction_type;
    List<Items> order = [];

    DetailTransaction(
      this.id,
      this.transaction_number,
      this.total_price,
      this.tax,
      this.grand_total,
      this.discount,
      this.voucher_code,
      this.branch_name,
      this.my_address,
      this.payment_method,
      this.payment_method_image_url,
        this.transaction_type);

    DetailTransaction.fromJson(Map<String, dynamic> json) :
        id = json["id"],
        transaction_number = json["transaction_number"],
        total_price = json["total_price"],
        tax = json["tax"],
        grand_total = json["grand_total"],
        discount = json["discount"],
        voucher_code = json["voucher_code"],
        branch_name = json["branch_name"],
        my_address = json["my_address"],
        payment_method = json["payment_method"],
        payment_method_image_url = json["payment_method_image_url"],
    transaction_type = json["transaction_type"];

    Map<String, dynamic> toJson() => {
      "id" : id,
      "transaction_number" : transaction_number,
      "total_price" : total_price,
      "tax" : tax,
      "grand_total" : grand_total,
      "discount" : discount,
      "voucher_code" : voucher_code,
      "branch_name" : branch_name,
      "my_address" : my_address,
      "payment_method" : payment_method,
      "payment_method_image_url" : payment_method_image_url,
      "transaction_type" : transaction_type
    };

}