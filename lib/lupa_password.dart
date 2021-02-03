import 'package:belah_duren/aktifasi.dart';
import 'package:flutter/material.dart';

class LupaPassword extends StatefulWidget {
  @override
  _LupaPasswordState createState() => _LupaPasswordState();
}

class _LupaPasswordState extends State<LupaPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
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
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Lupa Password?",
                        style: TextStyle(color: Colors.brown[700], fontSize: 30.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 32.0,
                      ),
                      TextFormField(
                        decoration: new InputDecoration(
                          labelText: "Enter Email",
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
                        keyboardType: TextInputType.emailAddress,
                        style: new TextStyle(
                          fontFamily: "Poppins",
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),Align(
                        alignment: Alignment.center,
                        child: Text("Kami akan mengirimkan password baru ke alamat email anda",
                          style: TextStyle(color: Colors.brown[300]),textAlign: TextAlign.center,),
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
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Aktifasi()),
                            );
                          },
                          color: Colors.yellow[600],
                          textColor: Colors.black,
                          child: Text("Kirim Aktifasi",
                              style: TextStyle(fontSize: 16)),
                        ),),SizedBox(
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
