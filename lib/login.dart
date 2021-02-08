import 'package:belah_duren/api/login.dart';
import 'package:belah_duren/global/session.dart';
import 'package:belah_duren/global/variable.dart';
import 'package:belah_duren/lupa_password.dart';
import 'package:belah_duren/main.dart';
import 'package:belah_duren/registrasi.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailEditTextController = TextEditingController();
  final passwordEditTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        //padding: EdgeInsets.only(left: 16, right: 16.0),
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
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Selamat Datang",
                        style: TextStyle(color: Colors.brown[700], fontSize: 30.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "di Aplikasi Belah Doeren",
                        style: TextStyle(color: Colors.brown[600], fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 32.0,
                      ),
                      TextFormField(
                        controller: emailEditTextController,
                        autofocus: false,
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
                      ),
                      TextFormField(
                        obscureText: true,
                        controller: passwordEditTextController,
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
                      ButtonTheme(
                        padding: EdgeInsets.all(12),
                        minWidth: double.infinity,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: Colors.yellow[600])),
                          onPressed: () {
                            showCircular(context);
                            futureApiLogin(emailEditTextController.text, passwordEditTextController.text).then((value) {
                              Navigator.of(context, rootNavigator: true).pop();
                              if(value.isSuccess()){
                                currentUser = value.user;
                                storeSession();
                                startNewPage(context, MyHomePage(title: 'Flutter Demo Home Page'));
                              } else {
                                alertDialog(context, "Sign In Gagal", value.message);
                              }
                            });
                          },
                          color: Colors.yellow[600],
                          textColor: Colors.black,
                          child: Text("login".toUpperCase(),
                              style: TextStyle(fontSize: 16)),
                        ),),SizedBox(
                        height: 16,
                      ),Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: (){
                              nextPage(context, Registrasi());
                            },child: Text("Belum punya akun?",style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold)),
                          ),
                          GestureDetector(
                            onTap: (){
                              nextPage(context, LupaPassword());
                            },
                            child: Text("Lupa password?", style: TextStyle(color: Colors.brown[200], fontWeight: FontWeight.bold)),
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
