import 'package:belah_duren/api/slider.dart';
import 'package:belah_duren/detail_promo.dart';
import 'package:belah_duren/model/slider.dart';
import 'package:flutter/material.dart';

import 'global/variable.dart';

class ListPromo extends StatefulWidget {
  @override
  _ListPromoState createState() => _ListPromoState();
}

class _ListPromoState extends State<ListPromo> {

  List<SliderMenu> listPromotion = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.brown),
        title: Text(
          "Daftar Pesanan",
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
                  padding:
                  EdgeInsets.only(top: 16, bottom: 16, left: 12, right: 8),
                  margin: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      image: DecorationImage(
                          image: AssetImage("assets/images/box_poin.png"),
                          fit: BoxFit.fill),
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
                        style: TextStyle(
                            color: Colors.brown[500],
                            fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Image.asset(
                        "assets/images/icon_poin.png",
                        scale: 30,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        currentPoints.points.toString(),
                        style: TextStyle(
                            color: Colors.brown[500],
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .15,
                      ),
                    ],
                  )),
              FutureBuilder(
                  future: futureApiSliders(currentUser.token),
                  builder: (context, snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }else if(snapshot.connectionState == ConnectionState.done){
                      ApiSlider apiSlider = snapshot.data;
                      if(apiSlider.isSuccess()){
                        listPromotion = apiSlider.data;
                      }
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: listPromotion.length,
                          itemBuilder: (context, index){
                            return Container(
                              padding: EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  Container(
                                    child: Image.network(listPromotion[index].imageUrl,
                                      fit: BoxFit.fitHeight, width: 100,),
                                  ),SizedBox(
                                    width: 8,
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        width: 150,
                                        child: Text(
                                          listPromotion[index].name,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.brown[700]),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  FlatButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8.0),
                                        side: BorderSide(color: Colors.yellow[700])),
                                    color: Colors.yellow[700],
                                    textColor: Colors.black,
                                    onPressed: () {
                                      nextPage(context, DetailPromo(sliderMenu: listPromotion[index]));
                                    },
                                    child: Text(
                                      "Detail",
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    }
              })
            ],
          ),
        ),
      ),
    );
  }
}
