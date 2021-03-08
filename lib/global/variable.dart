import 'dart:io';

import 'package:belah_duren/api/cart.dart';
import 'package:belah_duren/login.dart';
import 'package:belah_duren/model/address.dart';
import 'package:belah_duren/model/branch.dart';
import 'package:belah_duren/model/cart.dart';
import 'package:belah_duren/model/member_level.dart';
import 'package:belah_duren/model/member_poins.dart';
import 'package:belah_duren/model/menu.dart';
import 'package:belah_duren/model/profile.dart';
import 'package:belah_duren/model/user.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

String domain = "http://belahdoeren.wiradipa.com/";
String api_url = domain+"/api/v1/";

User currentUser;
Items selectedBranch;
MemberPoints currentPoints;
Address selectedAddress;
Profile currentProfile;
PickedFile currentImage;
Position currentPosition;
int currentIdCarts;
int countCart = 0;
String selectedOrderType = "pickup";
String orderId = "";


bool isPickupOrder(){
  return selectedOrderType == "pickup";
}

int orderTypeId(){
  return isPickupOrder() ? 1 : 2;
}

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

alertDialog(context, title, message) async {
  return showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text(title),
          content: Text(message),
        );
      }
  );
}

alertDialogMustLogin(context, title, message) async {
  return showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text(title),
          content: Container(
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(message),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: double.infinity,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: BorderSide(color: Colors.yellow[700])),
                    color: Colors.yellow[700],
                    textColor: Colors.black,
                    onPressed: () {
                      nextPage(context, Login());
                    },
                    child: Text(
                      "Login Sekarang",
                      style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
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
  final TextEditingController notes = TextEditingController();
  notes.text = "";
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
                        menu.new_price == null ?
                        'Rp. '+ formatCurrency(menu.price) :
                        'Rp. '+ formatCurrency(menu.new_price)
                        ,
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
                    height: 8,
                  ),
                  TextFormField(
                    controller: notes,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 14, color: Colors.brown[700]),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      hoverColor: Colors.white,
                      filled: true,
                      contentPadding: EdgeInsets.only(left: 16),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[400], width: 3),
                          borderRadius: BorderRadius.circular(8.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[400], width: 3),
                          borderRadius: BorderRadius.circular(8.0)),
                      hintText: "Tambah Catatan",
                      hintStyle: TextStyle(color: Colors.grey[400]),
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
                        int price;
                        if(menu.new_price == null){
                          price = menu.price;
                          print(price);
                        }
                        else{
                          price = menu.new_price;
                          print(price);
                        }
                        if(currentUser == null){
                          alertDialogMustLogin(context, "Belum Login", "Anda harus login terlebih dahulu");
                        }else{
                          showCircular(context);
                          futureApiAddToCart(currentUser.token, menu.id,
                              _counter, price, notes.text).then((value) async {
                            Navigator.of(context, rootNavigator: true).pop();
                            if(value.isSuccess()){
                              await alertDialog(context, "Keranjang", "Berhasil Memasukkan Menu Ke Keranjang");
                              Navigator.pop(context);
                            } else {
                              alertDialog(context, "Keranjang", value.message);
                            }
                          });
                        }

                      },
                      color: Colors.yellow[700],
                      textColor: Colors.black,
                      child: Text(
                          menu.new_price == null ?
                          "Tambah Ke Keranjang - " + 'Rp. '+ formatCurrency(menu.price)
                          :
                          "Tambah Ke Keranjang - " + 'Rp. '+ formatCurrency(menu.new_price),
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

widgetMustLogin(BuildContext context){
  return Container(
    margin: EdgeInsets.all(16),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Kamu Belum Login",
          style: TextStyle(
              color: Colors.brown[500],
              fontWeight: FontWeight.bold),
        ),
        Text(
          "untuk mengakses menu ini kamu harus login",
          style: TextStyle(
              color: Colors.black38),
        ),
        SizedBox(
          height: 16,
        ),SizedBox(
          width: double.infinity,
          child: FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                side: BorderSide(color: Colors.yellow[700])),
            color: Colors.yellow[700],
            textColor: Colors.black,
            onPressed: () {
              nextPage(context, Login());
            },
            child: Text(
              "Login Sekarang",
              style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
      ],
    ),
  );
}