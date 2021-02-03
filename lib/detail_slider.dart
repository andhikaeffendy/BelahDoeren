import 'package:flutter/material.dart';

class DetailSlider extends StatefulWidget {
  @override
  _DetailSliderState createState() => _DetailSliderState();
}

class _DetailSliderState extends State<DetailSlider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                    image: DecorationImage(
                        image: AssetImage("assets/images/slide_utama_home.png"),
                        fit: BoxFit.fill)),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Syarat & Kententuan :",
                      style: TextStyle(
                          color: Colors.brown[700],
                          fontWeight: FontWeight.bold),
                    ),SizedBox(height: 12,),
                    Container(
                      height: 1,
                      color: Colors.brown[200],
                    ),SizedBox(
                      height: 12,
                    ),Text(
                      "1. syarat pertama",
                      style: TextStyle(
                          color: Colors.brown[700]),
                    ),SizedBox(
                      height: 12,
                    ),Text(
                      "2. syarat pertama",
                      style: TextStyle(
                          color: Colors.brown[700]),
                    ),SizedBox(
                      height: 12,
                    ),Text(
                      "3. syarat pertama",
                      style: TextStyle(
                          color: Colors.brown[700]),
                    ),SizedBox(
                      height: 12,
                    ),Text(
                      "4. syarat pertama",
                      style: TextStyle(
                          color: Colors.brown[700]),
                    ),SizedBox(
                      height: 12,
                    ),Text(
                      "Minyak kayu putih, air, madu, susu beruang, roti, mentega, nasi, bayam, dan lain-lain",
                      style: TextStyle(
                          color: Colors.brown[700]),
                    ),SizedBox(
                      height: 16,
                    ),ButtonTheme(
                      padding: EdgeInsets.all(12),
                      minWidth: double.infinity,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.yellow[600])),
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => MyApp()),
                          // );
                        },
                        color: Colors.yellow[600],
                        textColor: Colors.black,
                        child: Text("Beli sekarang".toUpperCase(),
                            style: TextStyle(fontSize: 16)),
                      ),)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
