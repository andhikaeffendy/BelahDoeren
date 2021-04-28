import 'package:belah_duren/api/order.dart';
import 'package:belah_duren/api/transactions.dart';
import 'package:belah_duren/detail_order.dart';
import 'package:belah_duren/global/variable.dart';
import 'package:belah_duren/model/transaction.dart';
import 'package:belah_duren/my_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class StatusPembayaran extends StatefulWidget {
  int paymentStatus;
  final int transactionId;
  final String deadline;
  String vaNumber = "";
  String vaBank = "";
  String billerCode = "";
  String billKey = "";
  String qrCode = "";
  String deeplink = "";
  bool launchDeeplink = false;

  StatusPembayaran(this.transactionId, this.paymentStatus, this.deadline,
      [this.vaBank = "", this.vaNumber = "", this.billerCode = "", this.billKey = "", this.qrCode = "",
        this.deeplink = "", this.launchDeeplink = false]);

  @override
  _StatusPembayaranState createState() => _StatusPembayaranState();
}

class _StatusPembayaranState extends State<StatusPembayaran> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.brown),
        title: Text(
          "Pembayaran",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.brown[700]),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              widget.paymentStatus == 3 ?
              _paymentSucces(context) :
              _pendingPayment(context),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    if(widget.paymentStatus != 3 && widget.deeplink != "" && widget.launchDeeplink)
      WidgetsBinding.instance
          .addPostFrameCallback((_) => launch(widget.deeplink));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(final AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if(widget.paymentStatus != 3)
        showCircular(context);
        futureDetailOrder(currentUser.token, widget.transactionId).then((value){
          Navigator.of(context, rootNavigator: true).pop();
          if(value.isSuccess()){
            if(value.data.transaction_status == 3)
              setState(() {
                widget.paymentStatus = 3;
              });
          }
        });
    }
  }

  Widget _pendingPayment(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.yellow[600],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.warning_amber_outlined,
                size: 30,),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Pesananmu akan diproses\nsejak pembayaran selesai",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown[700]
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            "Terima Kasih\ntelah berbelanja!",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.brown[700]),
          ),
          SizedBox(
            height: 16,
          ),
          Image.asset(
              "assets/images/payment_pending.jpg",
              fit: BoxFit.fill,
              width: double.infinity),
          SizedBox(
            height: 16,
          ),
          Container(
            width: MediaQuery.of(context).size.width*0.7,
            child: Text(
              "Silahkan selesaikan pembayaran sebelum tanggal "+ widget.deadline.toString() +" untuk menghindari pembatalan transaksi"
                  " secara otomatis",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.brown[700],
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            width: MediaQuery.of(context).size.width*0.7,
            child: Text(
              "Sudah menyelesaikan pembayaran?\nCek status nya di Daftar pesanan, ya.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.brown[700],
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 16, right: 16),
          //   child: SizedBox(
          //     width: double.infinity,
          //     child: RaisedButton(
          //       shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(10.0),
          //           side: BorderSide(color: Colors.yellow[700])),
          //       color: Colors.yellow[600],
          //       textColor: Colors.brown[700],
          //       onPressed: () {
          //       },
          //       child: Text("Pilih Metode Pembayaran Lain",
          //           style: TextStyle(
          //               fontSize: 16,
          //               color: Colors.brown[700],
          //               fontWeight: FontWeight.bold)),
          //     ),
          //   ),
          // ), SizedBox(
          //   height: 16,
          // ),
          Container(
            width: MediaQuery.of(context).size.width*0.7,
            child: Text(
              "Pembayaran via Transfer " + widget.vaBank.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.brown[700],
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          widget.qrCode == "" || widget.qrCode == null || widget.launchDeeplink ? Container() :
              Image.network(widget.qrCode, height: MediaQuery. of(context).size.width * 0.5, width: MediaQuery. of(context).size.width * 0.5,),
          widget.vaNumber == "" || widget.vaNumber == null ? Container() :
          Container(
            width: MediaQuery.of(context).size.width*0.7,
            child: Text(
              "Nomor Virtual Account "+widget.vaBank.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.brown[700],
                  fontWeight: FontWeight.bold),
            ),
          ),
          widget.vaNumber == "" || widget.vaNumber == null ? Container() :
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  widget.vaNumber.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.brown[700]),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              GestureDetector(
                onTap: () {
                  Clipboard.setData(new ClipboardData(text: widget.vaNumber));
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Berhasil salin Nomor Virtual Account '+widget.vaBank.toUpperCase())));
                  },
                child: Container(
                  child: Text(
                    "Salin",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.green[700],
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          widget.billerCode == "" || widget.billerCode == null ? Container() :
          Container(
            width: MediaQuery.of(context).size.width*0.7,
            child: Text(
              "Nomor Biller Code",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.brown[700],
                  fontWeight: FontWeight.bold),
            ),
          ),
          widget.billerCode == "" || widget.billerCode == null ? Container() :
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  widget.billerCode.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.brown[700]),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              GestureDetector(
                onTap: () {
                  Clipboard.setData(new ClipboardData(text: widget.billerCode));
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Berhasil salin Nomor Biller Code')));
                  },
                child: Container(
                  child: Text(
                    "Salin",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.green[700],
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          widget.billKey == "" || widget.billKey == null ? Container() :
          SizedBox(
            height: 16,
          ),
          widget.billKey == "" || widget.billKey == null ? Container() :
          Container(
            width: MediaQuery.of(context).size.width*0.7,
            child: Text(
              "Nomor Bill Key",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.brown[700],
                  fontWeight: FontWeight.bold),
            ),
          ),
          widget.billKey == "" || widget.billKey == null ? Container() :
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  widget.billKey.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.brown[700]),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              GestureDetector(
                onTap: () {
                  Clipboard.setData(new ClipboardData(text: widget.billKey));
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Berhasil salin Nomor Bill Key')));
                  },
                child: Container(
                  child: Text(
                    "Salin",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.green[700],
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: SizedBox(
              width: double.infinity,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: Colors.yellow[700])),
                color: Colors.yellow[600],
                textColor: Colors.brown[700],
                onPressed: () async {
                  await nextPage(context, DetailOrder(transactionMenu: Transaction(id: widget.transactionId)));
                  Navigator.of(context, rootNavigator: true).pop();
                },
                child: Text("Lihat Pesanan",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.brown[700],
                        fontWeight: FontWeight.bold)),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _paymentSucces (BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 16,
          ),
          Text(
            "Terima Kasih\ntelah berbelanja!",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.brown[700]),
          ),
          SizedBox(
            height: 16,
          ),
          Image.asset(
            // jika payment sukses nama image nya assets/images/payment_sukses.jpg
              "assets/images/payment_berhasil.jpg",
              fit: BoxFit.fill,
              width: double.infinity),
          SizedBox(
            height: 16,
          ),
          // jika sukses text nya diganti container()
          Container(
            width: MediaQuery.of(context).size.width*0.7,
            child: Text(
              "Pesananmu berhasil\ndan pesananmu akan segera diproses",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.brown[700],
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: SizedBox(
              width: double.infinity,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: Colors.yellow[700])),
                color: Colors.yellow[600],
                textColor: Colors.brown[700],
                onPressed: () async {
                  await nextPage(context, MyOrder());
                  Navigator.of(context, rootNavigator: true).pop();
                },
                child: Text("Lihat Pesanan",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.brown[700],
                        fontWeight: FontWeight.bold)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
