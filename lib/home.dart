import 'package:belah_duren/about.dart';
import 'package:belah_duren/detail_slider.dart';
import 'package:belah_duren/list_store.dart';
import 'package:belah_duren/login.dart';
import 'package:belah_duren/status_point.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: [
                    Image.asset("assets/images/header_home.png",width: double.infinity,fit: BoxFit.fill,height: 100,),Positioned(
                        top: -20,
                        child: Image.asset("assets/images/logo_home.png",
                          width: 130, fit: BoxFit.fill,)),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  //margin: EdgeInsets.only(top: 30.0),
                  height: 200.0,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DetailSlider()),
                      );
                    },
                    child: Carousel(
                      images: [
                        Image.network(
                            "https://media-cdn.tripadvisor.com/media/photo-s/18/63/79/02/patisserie-product-series.jpg"),
                        Image.network(
                            "https://i2.wp.com/belahdoeren.id/wp-content/uploads/2019/10/15.jpg?fit=886%2C886&ssl=1"),
                        Image.network(
                            "https://b.zmtcdn.com/data/reviews_photos/0c4/faa61eded7ce69f39d0ee7656efaa0c4_1505908094.jpg"),
                      ],
                      autoplay: true,
                      animationCurve: Curves.fastOutSlowIn,
                      animationDuration: Duration(milliseconds: 800),
                      dotSize: 6.0,
                      dotColor: Colors.grey[700],
                      boxFit: BoxFit.cover,
                      dotPosition: DotPosition.bottomLeft,
                      dotBgColor: Colors.transparent,
                      dotIncreasedColor: Colors.white,
                    ),
                  ),
                ),
                Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        image: DecorationImage(
                          image: AssetImage("assets/images/box_poin.png"),
                          fit: BoxFit.cover
                        ),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15)),
                        border: Border.all(
                            width: 1,
                            color: Colors.white60,
                            style: BorderStyle.solid)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Point Reward",
                          style: TextStyle(color: Colors.brown[500], fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Image.asset("assets/images/icon_poin.png", scale: 30,),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "1,015",
                          style: TextStyle(color: Colors.brown[500], fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 16.0,
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => StatusPoint()),
                            );
                          },
                          child: Icon(Icons.arrow_forward, color: Colors.white, size: 25,),
                        )
                      ],
                    )),
                Row(
                  children: [
                    Image.asset("assets/images/pickup.png", width: MediaQuery.of(context).size.width/2.2, height: 100, fit: BoxFit.cover),
                    Spacer(),
                    Image.asset("assets/images/delivery.png", width: MediaQuery.of(context).size.width/2.2, height: 100, fit: BoxFit.cover)
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      image: DecorationImage(
                          image: AssetImage("assets/images/box_promotion.png"),
                          fit: BoxFit.cover
                      ),
                      border: Border.all(
                          width: 1,
                          color: Colors.white60,
                          style: BorderStyle.solid)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 24,
                      ),
                      Image.asset("assets/images/promotion.png", scale: 30,),
                      SizedBox(
                        width: 8,
                      ),
                      Text("Promotion", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.brown[500]),),
                      Spacer(),
                      Image.asset("assets/images/event_code.png", scale: 30,),
                      SizedBox(
                        width: 8,
                      ),
                      Text("Event Code",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.brown[500])),
                      SizedBox(
                        width: 24,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Text(
                      "Promo",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Text(
                      "Lihat Semua",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                SizedBox(
                  height: 1,
                  child: Container(
                    color: Colors.black26,
                  ),
                ),
                Column(
                  children: [
                    GridView.builder(
                        itemCount: 4,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.98,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 8),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: (){
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0.0, 1.0), //(x,y)
                                    blurRadius: 6.0,
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.network("https://awsimages.detik.net.id/community/media/visual/2017/10/06/d90ddfb6-c25b-4bd0-9893-0ac1738d3a5b.jpg?a=1",
                                    fit: BoxFit.fill,width: double.infinity,),
                                  SizedBox(height: 8,),
                                  Text("Pancake Durian Original", style: TextStyle(fontSize: 12,
                                      color: Colors.brown[600], fontWeight: FontWeight.bold),),
                                  SizedBox(height: 4,),
                                  Text("200.000", style: TextStyle(fontSize: 12),),
                                  SizedBox(height: 8,),
                                ],
                              ),
                            ),
                          );
                        })
                  ],
                )
              ]),
        ),
    );
  }
}
