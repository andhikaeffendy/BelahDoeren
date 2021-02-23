import 'package:belah_duren/api/cart.dart';
import 'package:belah_duren/model/address.dart';
import 'package:belah_duren/model/branch.dart';
import 'package:belah_duren/model/member_level.dart';
import 'package:belah_duren/model/member_poins.dart';
import 'package:belah_duren/model/menu.dart';
import 'package:belah_duren/model/user.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

String domain = "http://belahdoeren.wiradipa.com/";
String api_url = domain+"/api/v1/";

User currentUser;
Items selectedBranch;
MemberPoints currentPoints;
Address selectedAddress;
Position currentPosition;
String selectedOrderType = "pickup";

showCircular(context){
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return new Center(
          child: new CircularProgressIndicator(),
        );
      }
  );
}

alertDialog(context, title, message){
  showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text(title),
          content: Text(message),
        );
      }
  );
}

nextPage(context, page) async {
  return Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}

startNewPage(context, page){
  Navigator.pushAndRemoveUntil(
      context,
      new MaterialPageRoute(
        builder: (context) => page,
      ), (route) => false);
}

String formatCurrency(dynamic number){
  final currency = new NumberFormat("###,###,###.#");
  return currency.format(number);
}

cartBottomSheet(context,Menu menu) {
  int _counter = 1;
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext bc) {
        return StatefulBuilder(builder: (context, setState){
          return Container(
            margin: EdgeInsets.all(16),
            height: MediaQuery.of(context).size.height * .70,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(40)),
                    child: Image.network(
                      menu.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        menu.name,
                        style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        'Rp. '+ formatCurrency(menu.price),
                        style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: MediaQuery.of(context).size.width * .60,
                      child: Text(
                          menu.description),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      '',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    color: Colors.brown[100],
                    height: 1,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Jumlah Pesanan",
                        style: TextStyle(fontSize: 12, color: Colors.brown[200]),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      IconButton(
                          icon: Icon(Icons.remove, size: 20),
                          onPressed: () {
                            setState(() {
                              _counter = _counter;
                              if (_counter != 0) {
                                _counter--;
                              }
                            });
                          }),
                      SizedBox(
                        width: 8,
                      ),
                      Container(
                        padding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        color: Colors.grey[300],
                        child: Text(
                          '$_counter',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      IconButton(
                          icon: Icon(Icons.add, size: 20),
                          onPressed: () {
                            setState(() {
                              _counter++;
                            });
                          }),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: Colors.yellow[700])),
                      onPressed: () {
                        showCircular(context);
                        futureApiAddToCart(currentUser.token, menu.id,
                            _counter, menu.price).then((value){
                          Navigator.of(context, rootNavigator: true).pop();
                          if(value.isSuccess()){
                            alertDialog(context, "Keranjang", "Berhasil Memasukkan Menu Ke Keranjang");
                          } else {
                            alertDialog(context, "Keranjang", value.message);
                          }
                        });
                      },
                      color: Colors.yellow[700],
                      textColor: Colors.black,
                      child: Text("Tambah Ke Keranjang".toUpperCase(),
                          style: TextStyle(fontSize: 14)),
                    ),
                  )
                ],
              ),
            ),
          );
        });
      });
}
