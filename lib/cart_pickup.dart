import 'package:belah_duren/api/cart.dart';
import 'package:belah_duren/api/voucher.dart';
import 'package:belah_duren/global/variable.dart';
import 'package:belah_duren/list_menu.dart';
import 'package:belah_duren/model/cart.dart';
import 'package:flutter/material.dart';

class CartPickup extends StatefulWidget {
  @override
  _CartPickupState createState() => _CartPickupState();
}

class _CartPickupState extends State<CartPickup> {
  List<Cart> carts = [];
  int discount = 0;
  String voucherCode = "";
  //List<TextEditingController> itemNotes = new List();
  TextEditingController itemNotes = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      updateCart();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.brown),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  selectedBranch == null ? "" : (isPickupOrder() ? "Pickup - " : "Delivery - ") + selectedBranch.distanceFromHere(),
                  style: TextStyle(fontSize: 12, color: Colors.brown),
                ),
                Text(
                  selectedBranch == null ? "belum dipilih" : selectedBranch.name,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown),
                ),
              ],
            ),
            Icon(
              Icons.arrow_downward_sharp,
              color: Colors.brown,
              size: 30,
            )
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(bottom: 16, top: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 8, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedOrderType = "pickup";
                        });
                        },
                      child: Image.asset("assets/images/pickup.png",
                          width: MediaQuery.of(context).size.width / 2.2,
                          height: 100,
                          fit: BoxFit.cover),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedOrderType = "delivery";
                        });
                      },
                      child: Image.asset("assets/images/delivery.png",
                          width: MediaQuery.of(context).size.width / 2.4,
                          height: 100,
                          fit: BoxFit.contain),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 16),
                    child: Text(
                      "Pesanan Anda",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown[700]),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await nextPage(context, ListMenu(true));
                      updateCart();
                    },
                    child: Container(
                      padding: EdgeInsets.only(right: 16),
                      child: Row(
                        children: [
                          Icon(Icons.add, color: Colors.green[900], size: 20),
                          Text("Tambah Pesanan", style: TextStyle(color: Colors.green[900], fontSize: 12),)
                        ],
                      ),
                    ),
                  )
                ],
              ),
              _cart_lists(),
              SizedBox(
                height: 32,
              ),
              isPickupOrder() ? Container() :
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 16,),
                    child: Text(
                      "Alamat Pengiriman",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown[700]),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(right: 16),
                          child: Text(
                            "Ubah",
                            style:
                            TextStyle(color: Colors.green[900], fontSize: 12),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              isPickupOrder() ? Container() :
              SizedBox(
                height: 8,
              ),
              isPickupOrder() ? Container() :
              Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                height: 1,
                color: Colors.brown[100],
              ),
              isPickupOrder() ? Container() :
              SizedBox(
                height: 16,
              ),
              isPickupOrder() ? Container() :
              Container(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      Icon(
                        Icons.monetization_on_outlined,
                        size: 20,
                        color: Colors.brown[700],
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            selectedAddress == null ? "Belum Punya Alamat" : selectedAddress.name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.brown[700],
                                fontSize: 14),
                          ),
                          Text(
                            selectedAddress == null ? "Silahkan Tambah Alamat" : selectedAddress.address,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black26,
                                fontSize: 12),
                          ),
                        ],
                      ),Spacer(),
                      Icon(
                        Icons.keyboard_arrow_right_rounded,
                        color: Colors.brown[700],
                        size: 30,
                      )
                    ],
                  ),
                ),
              ),
              isPickupOrder() ? Container() :
              SizedBox(
                height: 24,
              ),
              Container(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Pembayaran",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown[700]),
                    ),
                    GestureDetector(
                      onTap: (){},
                      child: Row(
                        children: [
                          Text("Lihat Semua", style: TextStyle(color: Colors.green[900], fontSize: 12),)
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                height: 1,
                color: Colors.brown[100],
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: GestureDetector(
                  onTap: (){

                  },
                  child: Row(
                    children: [
                      Icon(Icons.monetization_on_outlined, size: 20, color: Colors.brown[700],),
                      SizedBox(
                        width: 8,
                      ),Text("Cash", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.brown[700], fontSize: 14),),
                      Spacer(),
                      Icon(Icons.keyboard_arrow_right_rounded, color: Colors.brown[700], size: 30,)
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        width: 1,
                        color: Colors.white60,
                        style: BorderStyle.solid),
                color: Colors.yellow[400]),
                child: GestureDetector(
                  onTap: () => _showVoucherDialog(totalCart(carts)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/event_code.png", scale: 30,),
                      SizedBox(
                        width: 8,
                      ),
                      Text("Voucher Code",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.brown[700])),
                      SizedBox(
                        width: 24,
                      ),
                    ],
                  ),
                ),
              ),SizedBox(
                height: 16,
              ),
              Container(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: ClipRRect(
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
                              formatCurrency(totalCart(carts)),
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
                              "Delivery Fee",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black26,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "0",
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
                              "0",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.green[900],
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        discount == 0 && voucherCode == "" ? Container() :
                        SizedBox(
                          height: 12,
                        ),
                        discount == 0 && voucherCode == "" ? Container() :
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Discount Voucher ($voucherCode)",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.green[900],
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "-"+formatCurrency(discount),
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
                              formatCurrency(totalCart(carts) - discount),
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
                    onPressed: () {
                      showCircular(context);
                      if(isPickupOrder()) {
                        futureApiSubmitCart(
                            currentUser.token, selectedBranch.id, orderTypeId(),
                            carts, discount, voucherCode).then((value) {
                          Navigator.of(context, rootNavigator: true).pop();
                          if (value.isSuccess()) {
                            Navigator.of(context, rootNavigator: true).pop();
                          } else
                            alertDialog(
                                context, "Kirim Pesanan Gagal", value.message);
                        });
                      } else {
                        futureApiSubmitCart(
                            currentUser.token, selectedBranch.id, orderTypeId(),
                            carts, discount, voucherCode, selectedAddress.id)
                            .then((value) async {
                          Navigator.of(context, rootNavigator: true).pop();
                          if (value.isSuccess()) {
                            await alertDialog(
                                context, "Kirim Pesanan Berhasil", "Pesanan Berhasil Dibuat");
                            Navigator.of(context, rootNavigator: true).pop();
                          } else
                            alertDialog(
                                context, "Kirim Pesanan Gagal", value.message);
                        });
                      }
                    },
                    color: Colors.yellow[600],
                    textColor: Colors.black,
                    child: Text("Kirim Pesanan",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
                  ),
                ),
              ),SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _cart_lists(){
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Column(
        children: [
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: carts.length,
              itemBuilder: (context, index) {
                return Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 12,
                      ),
                      Container(
                        height: 1,
                        color: Colors.brown,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              carts[index].imageUrl,
                              width:
                              MediaQuery.of(context).size.width / 5,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Column(
                            children: [
                              Container(
                                width: 100,
                                child: Text(
                                  carts[index].menuName,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.brown),
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Container(
                                width: 100,
                                child: Text(
                                  formatCurrency(carts[index].price),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.brown),
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            children: [
                              Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [
                                  IconButton(
                                      icon: Icon(
                                        Icons.remove,
                                        size: 30,
                                        color: Colors.brown,
                                      ),
                                      onPressed: () => substractQuantity(carts[index]),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 4),
                                    color: Colors.grey[300],
                                    child: Text(
                                      carts[index].quantity.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  IconButton(
                                      icon: Icon(
                                        Icons.add,
                                        size: 30,
                                        color: Colors.brown,
                                      ),
                                      onPressed: () => addQuantity(carts[index]),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: (){

                                },
                                child: Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.sticky_note_2_outlined,
                                      size: 30,
                                      color: Colors.brown,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "Catatan",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.brown),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            carts[index].note != "" ? carts[index].note : "Tambah Catatan untuk pesanan ini",
                            style: TextStyle(
                              fontSize: 14, color: Colors.brown,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ],
      ),
    );
  }

  addQuantity(Cart cart){
    showCircular(context);
    futureApiChangeQuantityCart(currentUser.token, cart.id, cart.quantity+1).then((value) async {
      Navigator.of(context, rootNavigator: true).pop();
      if(value.isSuccess())
        await alertDialog(context, "Keranjang", "Berhasil Menambah Jumlah Menu");
      updateCart();
    });
  }

  substractQuantity(Cart cart){
    showCircular(context);
    if(cart.quantity == 1){
      futureApiRemoveCart(currentUser.token, cart.id).then((value) async {
        Navigator.of(context, rootNavigator: true).pop();
        if(value.isSuccess())
          await alertDialog(context, "Keranjang", "Berhasil Menghapus Menu");
        updateCart();
      });
    } else
      futureApiChangeQuantityCart(currentUser.token, cart.id, cart.quantity-1).then((value) async {
        Navigator.of(context, rootNavigator: true).pop();
        if(value.isSuccess())
          await alertDialog(context, "Keranjang", "Berhasil Mengurangi Jumlah Menu");
        updateCart();
      });
  }

  updateCart(){
    showCircular(context);
    futureApiCartList(currentUser.token).then((value){
      Navigator.of(context, rootNavigator: true).pop();
      if(value.isSuccess()){
        setState(() {
          carts = value.data;
          countCart = carts.length;
        });
      }
    });
  }


  _showChangeNotes(index) async {
    showModalBottomSheet(
        context: context,
        builder: (context){
          return Container(
            child: Column(
              children: [
                TextFormField(
                  controller: itemNotes,
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
                    height: 16
                ),
                SizedBox(
                  height: 60,
                  width: 100,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: Colors.yellow[700])),
                    onPressed: () {
                      showCircular(context);
                      futureApiChangeNotesCart(currentUser.token, carts[index].id,itemNotes.text).then((value) async {
                        Navigator.of(context, rootNavigator: true).pop();
                        if(value.isSuccess()){
                          await alertDialog(context, "Keranjang", "Berhasil Update Catatan");
                        }
                        updateCart();
                      });
                    },
                    color: Colors.yellow[700],
                    textColor: Colors.black,
                    child: Text("Redeem".toUpperCase(),
                        style: TextStyle(fontSize: 14)),
                  ),
                )
              ],
            ),
          );
        });
  }

  _showVoucherDialog(total) async {
    final voucherController = TextEditingController();
    var errorMessage = "";
    int getDiscount = 0;
    String getVoucher = "";
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) {
          return StatefulBuilder(builder: (context, setState){
            return Container(
              margin: EdgeInsets.all(16),
              height: MediaQuery.of(context).size.height * .50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 140,
                        child:
                          TextFormField(
                            controller: voucherController,
                            autofocus: false,
                            decoration: new InputDecoration(
                              labelText: "Enter Voucher",
                              fillColor: Colors.grey,
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(10.0),
                                borderSide: new BorderSide(),
                              ),
                            ),
                            style: new TextStyle(
                              fontFamily: "Poppins",
                            ),
                          ),
                      ),
                      SizedBox(
                        height: 60,
                        width: 100,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: Colors.yellow[700])),
                          onPressed: () {
                            showCircular(context);
                            futureApiRedeemVoucher(currentUser.token,
                                voucherController.text, total).then((value){
                              Navigator.of(context, rootNavigator: true).pop();
                              if(value.isSuccess()){
                                setState(() {
                                  getVoucher = value.name;
                                  getDiscount = value.discount;
                                  errorMessage = "voucher berhasil ditambahkan";
                                });
                              } else {
                                setState(() {
                                  getVoucher = "";
                                  getDiscount = 0;
                                  errorMessage = value.message;
                                });
                              }
                            });
                          },
                          color: Colors.yellow[700],
                          textColor: Colors.black,
                          child: Text("Redeem".toUpperCase(),
                              style: TextStyle(fontSize: 14)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    errorMessage,
                    style: TextStyle(
                        color: getDiscount == 0 ? Colors.red : Colors.black ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: Colors.yellow[700])),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: Colors.yellow[700],
                      textColor: Colors.black,
                      child: Text("Lanjut".toUpperCase(),
                          style: TextStyle(fontSize: 14)),
                    ),
                  )
                ],
              ),
            );
          });
        });
    setState(() {
      voucherCode = getVoucher;
      discount = getDiscount;
    });
  }
}

int totalCart(List<Cart> carts){
  var total = 0;
  carts.forEach((cart) {
    total += cart.subTotal ;
  });
  return total;
}
