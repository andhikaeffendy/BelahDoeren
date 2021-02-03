import 'package:belah_duren/login.dart';
import 'package:flutter/material.dart';

class AktifasiBerhasil extends StatefulWidget {
  @override
  _AktifasiBerhasilState createState() => _AktifasiBerhasilState();
}

class _AktifasiBerhasilState extends State<AktifasiBerhasil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Image.asset("assets/images/background.png",width: double.infinity,fit: BoxFit.fill,),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Align(
                alignment: Alignment.topCenter,
                child: Image.asset("assets/images/logo.png", height: 130,),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Selamat",
                        style: TextStyle(
                            color: Colors.brown[700],
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Anda telah berhasil registrasi, silahkan Login",
                          style: TextStyle(color: Colors.brown[700], fontSize: 16, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 32.0,
                      ),
                      ButtonTheme(
                        padding: EdgeInsets.all(12),
                        minWidth: double.infinity,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: Colors.yellow[600])),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                            );
                          },
                          color: Colors.yellow[600],
                          textColor: Colors.black,
                          child: Text("Kembali ke halaman login", style: TextStyle(fontSize: 16)),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
