import 'package:belah_duren/api/settings.dart';
import 'package:belah_duren/global/variable.dart';
import 'package:flutter/material.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tentang Belah Doeren", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.brown[700]),),
        backgroundColor: Colors.yellow[700],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: futureApiGetAbout(),
            builder: (context, snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }else if(snapshot.connectionState == ConnectionState.done){
                ApiAbout apiAbout = snapshot.data;
                if(apiAbout.isSuccess()){
                  print(apiAbout);
                }
                return Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15)),
                          image: DecorationImage(
                              image: AssetImage("assets/images/slide_utama_home.png"),
                              fit: BoxFit.fill)),
                      height: 200,
                    ),SizedBox(
                      height: 16,
                    ),Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.only(left: 16, right: 16),
                        child: Text(
                          apiAbout.data.name.toString(),
                          style: TextStyle(fontSize: 14, color: Colors.brown[700]),
                        ),
                      ),
                    ),SizedBox(
                      height: 16,
                    ),Container(
                      margin: EdgeInsets.only(left: 16, right: 16),
                      child: Text(
                        apiAbout.data.body,
                        style: TextStyle(fontSize: 14, color: Colors.brown[700]),
                      ),
                    )
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
