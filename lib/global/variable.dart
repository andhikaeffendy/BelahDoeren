import 'package:belah_duren/model/user.dart';
import 'package:flutter/material.dart';

String domain = "http://belahdoeren.wiradipa.com/";
String api_url = domain+"/api/v1/";

User currentUser;

showCircular(context){
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return new Center(
          child: new CircularProgressIndicator(),
        );
      }
  );
}

alertDialog(context, title, message){
  showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text(title),
          content: Text(message),
        );
      }
  );
}

nextPage(context, page){
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}

startNewPage(context, page){
  Navigator.pushAndRemoveUntil(
      context,
      new MaterialPageRoute(
        builder: (context) => page,
      ), (route) => false);
}