import 'package:belah_duren/api/member_level.dart';
import 'package:belah_duren/global/variable.dart';
import 'package:belah_duren/model/member_level.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatusPoint extends StatefulWidget {
  @override
  _StatusPointState createState() => _StatusPointState();
}

class _StatusPointState extends State<StatusPoint> {
  SharedPreferences prefs;
  List<MemberLevel> memberLevel = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              FutureBuilder(
                  future: futureApiMemberLevel(currentUser.token),
                  builder: (context, snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(
                        child: new CircularProgressIndicator(),
                      );
                      //print("Member "+apiMemberLevel.toStringJson());
                    }else if(snapshot.connectionState == ConnectionState.done){
                      ApiMemberLevel apiMemberLevel = snapshot.data;
                      if(apiMemberLevel.isSuccess()){
                        print(apiMemberLevel);
                      }
                      return Column(
                        children: [
                          Container(
                            height: 180,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/images/banner.png"),
                                  fit: BoxFit.cover),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 16.0, left: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "Status Member",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.brown[700]),
                                  ),
                                  SizedBox(
                                    height: 4.0,
                                  ),
                                  Row(
                                    children: [
                                      Image.network(
                                        apiMemberLevel.data.image_url,
                                        fit: BoxFit.cover,
                                        width: 30,
                                      ),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      Text(
                                        apiMemberLevel.data.member_level_name,
                                        style: TextStyle(
                                            fontSize: 30,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Spacer(),
                                      Container(
                                        width: 120,
                                        padding: EdgeInsets.only(
                                            left: 16, top: 8, bottom: 8),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            bottomLeft: Radius.circular(15),
                                          ),
                                          color: Colors.white,
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/images/icon_poin.png",
                                              fit: BoxFit.cover,
                                              width: 20,
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Text(

                                              apiMemberLevel.data.points.toString(),
                                              style: TextStyle(
                                                  color: Colors.brown[700],
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            "Tahapan level dan benefit",
                            style: TextStyle(
                                color: Colors.brown[700],
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          //ini tahapan
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                apiMemberLevel.items[0].image_url,
                                fit: BoxFit.cover,
                                width: 50,
                                height: 50,
                              ),
                              Container(
                                height: 1,
                                color: Colors.brown,
                                width: 55,
                              ),
                              Image.network(
                                apiMemberLevel.items[1].image_url,
                                fit: BoxFit.cover,
                                width: 50,
                                height: 50,
                              ),
                              Container(
                                height: 1,
                                color: Colors.brown,
                                width: 55,
                              ),
                              Image.network(
                                apiMemberLevel.items[2].image_url,
                                fit: BoxFit.cover,
                                width: 50,
                                height: 50,
                              ),
                              Container(
                                height: 1,
                                color: Colors.brown,
                                width: 55,
                              ),
                              Image.network(
                                apiMemberLevel.items[3].image_url,
                                fit: BoxFit.cover,
                                width: 50,
                                height: 50,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      apiMemberLevel.items[0].name,
                                      style: TextStyle(
                                          color: Colors.brown,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      "Min point \n" + apiMemberLevel.items[0].min_point.toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.brown,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Container(
                                      width: 80,
                                      child: Text(
                                        apiMemberLevel.items[0].description,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.brown,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Container(
                                width: 1,
                                height: MediaQuery.of(context).size.height/3,
                                color: Colors.brown,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Column(
                                children: [
                                  Text(
                                    apiMemberLevel.items[1].name,
                                    style: TextStyle(
                                        color: Colors.brown,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                    "Min point \n" + apiMemberLevel.items[1].min_point.toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.brown,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Container(
                                    width: 80,
                                    child: Text(
                                      apiMemberLevel.items[1].description,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.brown,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Container(
                                width: 1,
                                height: MediaQuery.of(context).size.height/3,
                                color: Colors.brown,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Column(
                                children: [
                                  Text(
                                    apiMemberLevel.items[2].name,
                                    style: TextStyle(
                                        color: Colors.brown,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                    "Min point \n" + apiMemberLevel.items[2].min_point.toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.brown,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Container(
                                    width: 80,
                                    child: Text(
                                      apiMemberLevel.items[2].description,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.brown,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Container(
                                width: 1,
                                height: MediaQuery.of(context).size.height/3,
                                color: Colors.brown,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Column(
                                children: [
                                  Text(
                                    apiMemberLevel.items[3].name,
                                    style: TextStyle(
                                        color: Colors.brown,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                    "Min point \n" + apiMemberLevel.items[3].min_point.toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.brown,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Container(
                                    width: 80,
                                    child: Text(
                                      apiMemberLevel.items[3].description,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.brown,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 12,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Text(
                            "Cara gampang dapeting point reward",
                            style: TextStyle(
                                color: Colors.brown[700],
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Image.asset(
                                    "assets/images/scan_qr.png",
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Text(
                                    "Scan QR\ndi Outlet",
                                    style: TextStyle(
                                        color: Colors.brown,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),SizedBox(
                                    height: 8,
                                  ),ButtonTheme(
                                    minWidth: 70,
                                    child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                          side: BorderSide(color: Colors.yellow[600])),
                                      onPressed: () {
                                        //Navigator.of(context).pop();
                                      },
                                      color: Colors.yellow[600],
                                      textColor: Colors.black,
                                      child: Text("Pesan",
                                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                    ),)
                                ],
                              ),
                              SizedBox(
                                width: 24,
                              ),
                              Column(
                                children: [
                                  Image.asset(
                                    "assets/images/keranjang.png",
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Text(
                                    "Pesan Menu\napapun",
                                    style: TextStyle(
                                        color: Colors.brown,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),SizedBox(
                                    height: 8,
                                  ),ButtonTheme(
                                    minWidth: 70,
                                    child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                          side: BorderSide(color: Colors.yellow[600])),
                                      onPressed: () {
                                        //Navigator.of(context).pop();
                                      },
                                      color: Colors.yellow[600],
                                      textColor: Colors.black,
                                      child: Text("Pesan",
                                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                    ),)
                                ],
                              ),
                              SizedBox(
                                width: 24,
                              ),
                              Column(
                                children: [
                                  Image.asset(
                                    "assets/images/combo.png",
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Text(
                                    "Beli kombo\napapun",
                                    style: TextStyle(
                                        color: Colors.brown,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),SizedBox(
                                    height: 8,
                                  ),ButtonTheme(
                                    minWidth: 70,
                                    child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                          side: BorderSide(color: Colors.yellow[600])),
                                      onPressed: () {
                                        //Navigator.of(context).pop();
                                      },
                                      color: Colors.yellow[600],
                                      textColor: Colors.black,
                                      child: Text("Pesan",
                                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                    ),)
                                ],
                              ),
                              SizedBox(
                                width: 24,
                              ),
                              Column(
                                children: [
                                  Image.asset(
                                    "assets/images/user.png",
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Text(
                                    "Lengkapi\nProfilmu",
                                    style: TextStyle(
                                        color: Colors.brown,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),SizedBox(
                                    height: 8,
                                  ),ButtonTheme(
                                    minWidth: 70,
                                    child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                          side: BorderSide(color: Colors.yellow[600])),
                                      onPressed: () {
                                        //Navigator.of(context).pop();
                                      },
                                      color: Colors.yellow[600],
                                      textColor: Colors.black,
                                      child: Text("Pesan",
                                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                    ),)
                                ],
                              ),
                              SizedBox(
                                width: 8,
                              ),
                            ],
                          )
                        ],
                      );
                    }
                  }
                ),
              Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  Image.asset(
                    "assets/images/header_home.png",
                    width: double.infinity,
                    fit: BoxFit.fill,
                    height: 100,
                  ),
                  Positioned(
                      top: -20,
                      child: Image.asset(
                        "assets/images/logo_home.png",
                        width: 130,
                        fit: BoxFit.fill,
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
