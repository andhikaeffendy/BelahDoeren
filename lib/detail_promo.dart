import 'package:flutter/material.dart';

import 'model/slider.dart';

class DetailPromo extends StatefulWidget {
  final SliderMenu sliderMenu;

  @override
  _DetailPromoState createState() => _DetailPromoState(sliderMenu);

  const DetailPromo({Key key, @required this.sliderMenu}) : super(key: key);
}

class _DetailPromoState extends State<DetailPromo> {
  final SliderMenu sliderMenu;
  _DetailPromoState(this.sliderMenu);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.brown),
        title: Text(
          "Promosi",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.brown[700]),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                    image: DecorationImage(
                        image: NetworkImage(sliderMenu.imageUrl),
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
                        sliderMenu.name,
                        style: TextStyle(
                            color: Colors.brown[700],
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Container(
                        height: 1,
                        color: Colors.brown[200],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        sliderMenu.description,
                        style: TextStyle(color: Colors.brown[700]),
                      ),
                      SizedBox(
                        height: 12,
                      ),SizedBox(
                        width: double.infinity,
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: BorderSide(color: Colors.yellow[700])),
                          color: Colors.yellow[700],
                          textColor: Colors.black,
                          onPressed: () {
                          },
                          child: Text(
                            "Beli sekarang",
                            style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      )
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
