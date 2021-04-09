import 'package:belah_duren/api/order.dart';
import 'package:belah_duren/api/transactions.dart';
import 'package:belah_duren/global/variable.dart';
import 'package:belah_duren/model/detail_transaction.dart';
import 'package:belah_duren/model/order.dart';
import 'package:belah_duren/model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class DetailOrder extends StatefulWidget {
  final Transaction transactionMenu;

  @override
  _DetailOrderState createState() => _DetailOrderState(transactionMenu);

  const DetailOrder({Key key, @required this.transactionMenu}) : super(key: key);
}

class _DetailOrderState extends State<DetailOrder> {
  final Transaction transactionMenu;
  _DetailOrderState(this.transactionMenu);

  List<Items> items = List<Items>.empty();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.brown),
        title: Text(
          "Detail Order",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.brown[700]),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: _detailView(),
      ),
    );
  }

  Future<void> _refreshData() async{
    await Future.delayed(Duration(seconds: 2), (){
      futureDetailOrder(currentUser.token, transactionMenu.id).then((value) {
        if(value.isSuccess()){
          alertDialog(context, "Refresh", value.message);
        }
      });
    });
  }

  Widget _detailView(){
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: FutureBuilder(
            future: futureDetailOrder(currentUser.token, transactionMenu.id),
            builder: (context, snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }else if(snapshot.connectionState == ConnectionState.done){
                ApiOrder data = snapshot.data;
                if(data.isSuccess()){
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 3,
                            child: Text(
                              "No. Transaksi",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.brown[700]),
                            ),
                          ),
                          Text(
                            data.data.transaction_number,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.brown[700]),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 3,
                            child: Text(
                              "Outlet Pembelian",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.brown[700]),
                            ),
                          ),
                          Container(
                            child: Text(
                              data.data.branch_name,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.brown[700]),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 3,
                            child: Text(
                              "Metode Pembayaran ",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.brown[700]),
                            ),
                          ),
                          Container(
                            child: Image.network(data.data.payment_method_image_url,
                            height: 30,
                            width: 30,
                            fit: BoxFit.contain,),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      data.data.transaction_type == "Pickup"? Container():
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 3,
                            child: Text(
                              "Alamat Pengiriman",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.brown[700]),
                            ),
                          ),
                          Container(
                            child: Text(
                              data.data.my_address,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.brown[700]),
                            ),
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 3,
                            child: Text(
                              "Status ",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.brown[700]),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color(int.parse(data.data.transaction_status_color)),
                            ),
                            child: Text(
                              data.data.transaction_status_name,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.brown[700]),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 3,
                            child: Text(
                              "Tanggal Transaksi ",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.brown[700]),
                            ),
                          ),
                          Container(
                            child: Text(
                              transactionMenu.transaction_date.toString(),
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.brown[700]),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        height: 1,
                        color: Colors.brown[100],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Container(
                          width: double.infinity,
                          margin: EdgeInsets.all(4),
                          padding: EdgeInsets.all(12), //Same as `blurRadius` i guess
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.0, 1.0), //(x,y)
                                blurRadius: 4.0,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Pesanan",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.brown[700],
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 60,
                                    child: Text(
                                      "Jumlah",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black26,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width/2.8,
                                    child: Text(
                                      "Nama Barang",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black26,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    child: Text(
                                      "Harga",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black26,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),SizedBox(width: 16,)
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              FutureBuilder(
                                  future: futureDetailOrder(currentUser.token, transactionMenu.id),
                                  builder: (context, snapshot){
                                    if(snapshot.connectionState == ConnectionState.waiting){
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    else if(snapshot.connectionState == ConnectionState.done){
                                      print(snapshot.data);
                                      ApiOrder apiorder = snapshot.data;
                                      if(apiorder.isSuccess()){
                                        items = apiorder.items;
                                      }
                                      return ListView.builder(
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          itemCount: items.length,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              padding: EdgeInsets.only(bottom: 8),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 60,
                                                    child: Text(
                                                      items[index].quantity.toString(),
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.brown[700],
                                                          fontWeight: FontWeight.bold),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ),
                                                  Container(
                                                    width: MediaQuery.of(context).size.width/2.8,
                                                    child: Text(
                                                      items[index].menu_name,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.brown[700],
                                                          fontWeight: FontWeight.bold),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 100,
                                                    child: Text(
                                                      items[index].sub_total,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.brown[700],
                                                          fontWeight: FontWeight.bold),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ),SizedBox(width: 16,)
                                                ],
                                              ),
                                            );
                                          });
                                    }
                                  })
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Container(
                          width: double.infinity,
                          margin: EdgeInsets.all(4),
                          padding: EdgeInsets.all(12), //Same as `blurRadius` i guess
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.0, 1.0), //(x,y)
                                blurRadius: 4.0,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Payment Summary",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.brown,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Subtotal",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black26,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    data.data.total_price,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black26,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Tax",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black26,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    data.data.tax,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black26,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Discount Member",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.green[900],
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    data.data.discount == null ? "0" : data.data.discount,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.green[900],
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Container(
                                height: 1,
                                color: Colors.brown[100],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.brown[700],
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    data.data.grand_total,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.brown[700],
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                            ],
                          ),
                        ),
                      ),
                      !transactionMenu.isPaid() ?
                      Container() :
                      SizedBox(
                        height: 16,
                      ),
                      !transactionMenu.isPaid() ? Container() :
                      QrImage(
                        data: '/store_api/v1/transaction_detail/'+transactionMenu.id.toString(),
                        version: QrVersions.auto,
                        size: MediaQuery. of(context).size.width * 0.5,
                        gapless: false,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 16, right: 16),
                        child: SizedBox(
                          width: double.infinity,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(color: Colors.yellow[600])),
                            onPressed: () => cancelOrder() ,//doSubmit(),
                            color: Colors.yellow[600],
                            textColor: Colors.black,
                            child: Text("Cancel Order",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
                          ),
                        ),
                      ),SizedBox(
                        height: 16,
                      ),
                    ],
                  );
                }
              }
            }),
      ),
    );
  }

  cancelOrder(){
    showCircular(context);
    futureApiCancelTransaction(currentUser.token, transactionMenu.id)
        .then((value) async {
        Navigator.of(context, rootNavigator: true).pop();
        if(value.isSuccess()){
          await alertDialog(
              context, "Cancel Order Berhasil", "Order Berhasil Dicancel");
          Navigator.of(context, rootNavigator: true).pop();
        } else
          alertDialog(
              context, "Cancel Order Gagal", "Order Gagal dicancel");
    });
  }

}
