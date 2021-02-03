import 'package:belah_duren/aktifasi_berhasil.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class Aktifasi extends StatefulWidget {
  @override
  _AktifasiState createState() => _AktifasiState();
}

class _AktifasiState extends State<Aktifasi> {
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
                        "Aktifasi",
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
                          "Masukkan kode OTP",
                          style: TextStyle(color: Colors.brown[300]),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 32.0,
                      ),
                      OTPTextField(
                        length: 4,
                        width: MediaQuery.of(context).size.width,
                        textFieldAlignment: MainAxisAlignment.spaceAround,
                        fieldWidth: 50,
                        fieldStyle: FieldStyle.underline,
                        style: TextStyle(fontSize: 16),
                        onCompleted: (pin) {
                          print("Completed: " + pin);
                        },
                      ),
                      SizedBox(
                        height: 32,
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
                              MaterialPageRoute(builder: (context) => AktifasiBerhasil()),
                            );
                          },
                          color: Colors.yellow[600],
                          textColor: Colors.black,
                          child: Text("Lanjut", style: TextStyle(fontSize: 16)),
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
