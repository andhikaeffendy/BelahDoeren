import 'package:belah_duren/about.dart';
import 'package:belah_duren/api/branch.dart';
import 'package:belah_duren/api/member_level.dart';
import 'package:belah_duren/api/menu.dart';
import 'package:belah_duren/api/profile.dart';
import 'package:belah_duren/api/slider.dart';
import 'package:belah_duren/detail_slider.dart';
import 'package:belah_duren/global/location.dart';
import 'package:belah_duren/global/session.dart';
import 'package:belah_duren/global/variable.dart';
import 'package:belah_duren/list_promo.dart';
import 'package:belah_duren/login.dart';
import 'package:belah_duren/model/menu.dart';
import 'package:belah_duren/model/slider.dart';
import 'package:belah_duren/status_point.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'global/variable.dart';
import 'global/variable.dart';
import 'global/variable.dart';

class Home extends StatefulWidget {
  final Function gotoMenu;
  Home(this.gotoMenu);
  @override
  _HomeState createState() => _HomeState();

}

class _HomeState extends State<Home> {
  List<SliderMenu> listSlider = List<SliderMenu>.empty();
  List imageSlider = [];
  List<Menu> featuredMenus = [];
  final currency = new NumberFormat("###,###,###.#");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    determinePosition().then((value){
      setState(() {
        currentPosition = value;
      });
    });
    if(currentUser == null || selectedBranch == null){
      futureApiPromotionMenusNotLogin().then((value){
        if(value.isSuccess()){
          setState(() {
            featuredMenus = value.data;
          });
        }
      });
    }
    else{
      futureApiPromotionMenus(selectedBranch.id).then((value){
        if(value.isSuccess()){
          setState(() {
            featuredMenus = value.data;
          });
        }
        // else if(value.message == "Token not valid/authorized"){
        //   currentUser = null;
        //   destroySession();
        //   startNewPage(context, Login());
        // }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 100,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 16.0, right: 16.0),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(12))),
                          //margin: EdgeInsets.only(top: 30.0),
                          height: 200.0,
                          child: FutureBuilder(
                            future: futureApiSliders(),
                            builder: (context, snapshot){
                              if(snapshot.connectionState == ConnectionState.waiting){
                                return Center(
                                  child: new CircularProgressIndicator(),
                                );
                              } else if(snapshot.connectionState == ConnectionState.done){
                                print(snapshot.data);
                                ApiSlider apiSlider = snapshot.data;
                                if(apiSlider.isSuccess()){
                                  listSlider = apiSlider.data;
                                  imageSlider = [];
                                  listSlider.forEach((slider) {
                                    imageSlider.add(
                                        ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Image.network(slider.imageUrl, fit: BoxFit.fill,)));
                                  });
                                  return GestureDetector(
                                    child: Carousel(
                                      images: imageSlider,
                                      autoplay: true,
                                      animationCurve: Curves.fastOutSlowIn,
                                      animationDuration: Duration(milliseconds: 800),
                                      dotSize: 6.0,
                                      dotColor: Colors.grey[700],
                                      boxFit: BoxFit.cover,
                                      borderRadius: true,
                                      radius: Radius.circular(12),
                                      dotPosition: DotPosition.bottomLeft,
                                      dotBgColor: Colors.transparent,
                                      dotIncreasedColor: Colors.white,
                                      onImageTap: (index){
                                        nextPage(context, DetailSlider(sliderMenu: listSlider[index]));
                                      },
                                    ),
                                  );
                                }
//                        alertDialog(context, "List Slider", apiMercurisk.message);
                                return Container();
                              } else {
                                return Container();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    Image.asset("assets/images/header_home.png",
                      width: double.infinity,
                      fit: BoxFit.contain,
                      height: MediaQuery.of(context).size.height*.20,),
                    Positioned(
                        top: -20,
                        child: Image.asset("assets/images/logo_home.png",
                          width: 180, fit: BoxFit.cover,)),
                    Positioned(
                        right: 60,
                        top: 50,
                        child: GestureDetector(
                          onTap: (){},
                          child: Image.asset("assets/images/scanqr.png",
                            width: 25, fit: BoxFit.fill,),
                        )
                    ),

                  ],
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StatusPoint()),
                    );
                  },
                  child: Container(
                      margin: EdgeInsets.only(left: 16.0, right: 16.0),
                      padding: EdgeInsets.only(top: 16, bottom: 16, left: 12, right: 8),
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          image: DecorationImage(
                              image: AssetImage("assets/images/box_poin.png"),
                              fit: BoxFit.fill
                          ),
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
                          currentPoints == null && currentUser != null?
                          futureApiMemberLevel(currentUser.token).then((value){
                            if(value.isSuccess()){
                              currentPoints = value.data;
                            }
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }) :
                          Text(
                            currentUser == null && currentPoints != null ?
                            currentPoints.points.toString() : "0",
                            style: TextStyle(color: Colors.brown[500], fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width*.15,
                          ),
                        ],
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(left: 8.0, right: 16.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          selectedOrderType = "pickup";
                          widget.gotoMenu();
                        },
                        child: Image.asset("assets/images/pickup.png", width: MediaQuery.of(context).size.width/2.2, height: 110, fit: BoxFit.cover),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: (){
                          selectedOrderType = "delivery";
                          widget.gotoMenu();
                        },
                        child: Image.asset("assets/images/delivery.png", width: MediaQuery.of(context).size.width/2.4, height: 100, fit: BoxFit.fitWidth),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 16.0, right: 16.0),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/box_promotion.png"),
                          fit: BoxFit.fill
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
                      GestureDetector(
                          onTap: (){
                            nextPage(context, ListPromo());
                          },
                          child: Text("Promotion", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.brown[500]),)),
                      Spacer(),
                      Image.asset("assets/images/event_code.png", scale: 30,),
                      SizedBox(
                        width: 8,
                      ),
                      Text("Voucher Code",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.brown[500])),
                      SizedBox(
                        width: 24,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  margin: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Row(
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
                ),
                SizedBox(
                  height: 12,
                ),
                SizedBox(
                  height: 1,
                  child: Container(
                    margin: EdgeInsets.only(left: 16.0, right: 16.0),
                    color: Colors.black26,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Column(
                    children: [
                      GridView.builder(
                          itemCount: featuredMenus.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1.05,
                              mainAxisSpacing: 24,
                              crossAxisSpacing: 24),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: (){
                                cartBottomSheet(context, featuredMenus[index]);
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(7),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(1.0, 1.0), //(x,y)
                                      blurRadius: 8.0,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(7),
                                          topLeft: Radius.circular(7)
                                      ),
                                      child: Image.network(featuredMenus[index].imageUrl,
                                        fit: BoxFit.cover,width: double.infinity,),
                                    )),
                                    SizedBox(height: 8,),
                                    Container(
                                      padding: EdgeInsets.only(left: 8),
                                      child: Text(featuredMenus[index].name, style: TextStyle(fontSize: 12,
                                          color: Colors.brown[600], fontWeight: FontWeight.bold),),
                                    ),
                                    SizedBox(height: 4,),
                                    Container(
                                        padding: EdgeInsets.only(left: 8),
                                        child: Text(currency.format(featuredMenus[index].price), style: TextStyle(fontSize: 12,decoration: TextDecoration.lineThrough),)),
                                    featuredMenus[index].new_price == null ? Container() :
                                    Container(
                                        padding: EdgeInsets.only(left: 8),
                                        child: Text(currency.format(featuredMenus[index].new_price), style: TextStyle(fontSize: 12,),)),
                                    SizedBox(height: 8,),
                                  ],
                                ),
                              ),
                            );
                          })
                    ],
                  ),
                ),SizedBox(
                  height: 16,
                )
              ])
        ),
    );
  }

}
