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
          child: Column(
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
              ),Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                child: Text("dajsdnakjsndlknbvhbdhvbdhbvjdfbkvdfkvndkfnv"
                    "\nsfsjsdjfnsjdnfsjkdfnsjdnfskjdnfksjdnfksjdnfksjdnfksjdn\n"
                    "fsdjfsjdfnskjdfnsjdfndasdasdnasdkansdkansdajsndakjsn"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
