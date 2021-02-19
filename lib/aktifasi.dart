import 'package:belah_duren/aktifasi_berhasil.dart';
import 'package:belah_duren/api/activation.dart';
import 'package:belah_duren/api/send_activation_code.dart';
import 'package:belah_duren/global/variable.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class Aktifasi extends StatefulWidget {
  @override
  _AktifasiState createState() => _AktifasiState();
}

class _AktifasiState extends State<Aktifasi> {
  String inputPin="";

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
                        "Aktivasi",
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
                          "Masukkan Kode OTP yang telah dikirim ke email anda",
                          style: TextStyle(color: Colors.brown[300]),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 32.0,
                      ),
                      OTPTextField(
                        length: 6,
                        width: MediaQuery.of(context).size.width,
                        textFieldAlignment: MainAxisAlignment.spaceAround,
                        keyboardType: TextInputType.text,
                        fieldWidth: 50,
                        fieldStyle: FieldStyle.underline,
                        style: TextStyle(fontSize: 16),
                        onCompleted: (pin) {
                          inputPin = pin;
                          showCircular(context);
                          futureApiActivation(currentUser.email, inputPin)
                              .then((value){
                            Navigator.of(context, rootNavigator: true).pop();
                            if(value.isSuccess()) {
                              nextPage(context, AktifasiBerhasil());
                            } else {
                              alertDialog(context, "Aktivasi Gagal", value.message);
                            }
                          });
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
                            if(inputPin != "") {
                              showCircular(context);
                              futureApiActivation(currentUser.email, inputPin)
                                  .then((value) {
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                                if (value.isSuccess()) {
                                  nextPage(context, AktifasiBerhasil());
                                } else {
                                  alertDialog(
                                      context, "Aktivasi Gagal", value.message);
                                }
                              });
                            } else alertDialog(
                                context, "Pin error", "Pin tidak sesuai");
                          },
                          color: Colors.yellow[600],
                          textColor: Colors.black,
                          child: Text("Lanjut", style: TextStyle(fontSize: 16)),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: (){
                              showCircular(context);
                              futureApiSendActivationCode(currentUser.email)
                                  .then((value) {
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                                if (value.isSuccess()) {
                                  alertDialog(
                                      context, "Berhasil", "Kode Aktivasi baru telah dikirim ke email anda.");
                                } else {
                                  alertDialog(
                                      context, "Gagal", value.message);
                                }
                              });
                            },
                            child: Text("Kirim Ulang Kode Aktivasi", style: TextStyle(color: Colors.brown[200], fontWeight: FontWeight.bold)),
                          ),
                        ],
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
