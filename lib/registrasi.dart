import 'package:flutter/material.dart';

class Registrasi extends StatefulWidget {
  @override
  _RegistrasiState createState() => _RegistrasiState();
}

class _RegistrasiState extends State<Registrasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: true,
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
                  reverse: true,
                  scrollDirection: Axis.vertical,
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 32,),
                      Text(
                        "Form Registrasi",
                        style: TextStyle(color: Colors.brown[700], fontSize: 36.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Membership Belah Doeren",
                        style: TextStyle(color: Colors.brown[600], fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      TextFormField(
                        decoration: new InputDecoration(
                          labelText: "Masukkan Nama",
                          fillColor: Colors.grey,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                            borderSide: new BorderSide(),
                          ),
                          //fillColor: Colors.green
                        ),
                        validator: (val) {
                          if (val.length == 0) {
                            return "Email cannot be empty";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.text,
                        style: new TextStyle(
                          fontFamily: "Poppins",
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        decoration: new InputDecoration(
                          labelText: "Masukkan Email",
                          fillColor: Colors.grey,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                            borderSide: new BorderSide(),
                          ),
                          //fillColor: Colors.green
                        ),
                        validator: (val) {
                          if (val.length == 0) {
                            return "password cannot be empty";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        style: new TextStyle(
                          fontFamily: "Poppins",
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),TextFormField(
                        decoration: new InputDecoration(
                          labelText: "Enter Password",
                          fillColor: Colors.grey,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                            borderSide: new BorderSide(),
                          ),
                          //fillColor: Colors.green
                        ),
                        validator: (val) {
                          if (val.length == 0) {
                            return "password cannot be empty";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.visiblePassword,
                        style: new TextStyle(
                          fontFamily: "Poppins",
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        decoration: new InputDecoration(
                          labelText: "konfirmasi Password",
                          fillColor: Colors.grey,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                            borderSide: new BorderSide(),
                          ),
                          //fillColor: Colors.green
                        ),
                        validator: (val) {
                          if (val.length == 0) {
                            return "password cannot be empty";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.visiblePassword,
                        style: new TextStyle(
                          fontFamily: "Poppins",
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      ButtonTheme(
                        padding: EdgeInsets.all(12),
                        minWidth: double.infinity,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: Colors.yellow[600])),
                          onPressed: () {},
                          color: Colors.yellow[600],
                          textColor: Colors.black,
                          child: Text("Daftar".toUpperCase(),
                              style: TextStyle(fontSize: 16)),
                        ),)
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
