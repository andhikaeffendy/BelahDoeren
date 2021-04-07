import 'package:belah_duren/global/variable.dart';
import 'package:belah_duren/my_order.dart';
import 'package:flutter/material.dart';

class StatusPembayaran extends StatefulWidget {
  @override
  _StatusPembayaranState createState() => _StatusPembayaranState();
}

class _StatusPembayaranState extends State<StatusPembayaran> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.brown),
        title: Text(
          "Status Pembayaran",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.brown[700]),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            _pendingPayment(context),
          ],
        ),
      ),
    );
  }

  Widget _pendingPayment(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 16,
          ),
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
              "Silahkan selesaikan pembayaran sebelum tanggal 06 Apr 2021 19.45 WIB untuk menghindari pembatalan transaksi"
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
                onPressed: () {
                  nextPage(context, MyOrder());
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
                onPressed: () {
                  nextPage(context, MyOrder());
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
