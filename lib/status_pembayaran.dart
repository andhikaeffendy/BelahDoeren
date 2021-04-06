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
            SizedBox(
              height: 16,
            ),
            Text("Terima Kasih!",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.brown[700]
            ),),
            SizedBox(
              height: 16,
            ),
            Image.asset(
                // jika payment sukses nama image nya assets/images/payment_sukses.jpg
                "assets/images/payment_pending.jpg",
              fit: BoxFit.fill,
              width: double.infinity),
            SizedBox(
              height: 16,
            ),
            // jika sukses text nya diganti container()
            Text("Pembayaran anda\nSementara masih tertunda",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.brown[700],
                fontWeight: FontWeight.bold
              ),),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: SizedBox(
                width: double.infinity,
                child:
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.yellow[700])),
                  color: Colors.yellow,
                  textColor: Colors.brown[700],
                  onPressed: (){},
                  child: Text(
                      "Lihat Pesanan",
                      style: TextStyle(fontSize: 14, color: Colors.brown[700], fontWeight: FontWeight.bold)),
                )
                ,
              ),
            )
          ],
        ),
      ),
    );
  }
}
