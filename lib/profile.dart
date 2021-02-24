import 'package:belah_duren/about.dart';
import 'package:belah_duren/api/logout.dart';
import 'package:belah_duren/api/member_level.dart';
import 'package:belah_duren/api/profile.dart';
import 'package:belah_duren/daftar_hadiah.dart';
import 'package:belah_duren/edit_profile.dart';
import 'package:belah_duren/faq.dart';
import 'package:belah_duren/global/session.dart';
import 'package:belah_duren/global/variable.dart';
import 'package:belah_duren/history_penukaran_points.dart';
import 'package:belah_duren/kontak_cs.dart';
import 'package:belah_duren/login.dart';
import 'package:belah_duren/status_point.dart';
import 'package:flutter/material.dart';

import 'list_alamat.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 16, right: 16, top: 44, bottom: 16),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.yellow[600],
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12)),
                  border: Border.all(
                      width: 1,
                      color: Colors.yellow,
                      style: BorderStyle.solid)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  currentProfile == null ?
                      futureApiEditProfile(currentUser.token).then((value){
                        if(value.isSuccess()){
                          currentProfile = value.data;
                        }else{
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }
                      ):
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(currentProfile.photo),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hallo "+currentUser.name,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Image.asset("assets/images/icon_poin.png", scale: 20,),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Member " + currentPoints.member_level_name,
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StatusPoint()),
                );
              },
              child: Container(
                  padding: EdgeInsets.all(12),
                  margin: EdgeInsets.only(left: 16, right: 16),
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
                      Text(
                        currentPoints != null ? currentPoints.points.toString() : "Null",
                        style: TextStyle(color: Colors.brown[500], fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width*.10,
                      ),
                    ],
                  )),
            ),
            SizedBox(
              height: 24.0,
            ),
            Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditProfile()),
                  );
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.person_rounded,
                      color: Colors.brown,
                    ),
                    SizedBox(width: 16),
                    Text(
                      "Edit Profile",
                      style: TextStyle(color: Colors.brown, fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            SizedBox(
              child: Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                height: 1,
                color: Colors.brown,
              ),
            ),SizedBox(
              height: 12,
            ),Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HistoryPenukaranPoints()),
                  );
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.history,
                      color: Colors.brown,
                    ),
                    SizedBox(width: 16),
                    Text(
                      "Riwayat Pemesanan",
                      style: TextStyle(color: Colors.brown, fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            SizedBox(
              child: Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                height: 1,
                color: Colors.brown,
              ),
            ),SizedBox(
              height: 12,
            ),Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ListAlamat()),
                  );
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.brown,
                    ),
                    SizedBox(width: 16),
                    Text(
                      "Alamat Pengiriman",
                      style: TextStyle(color: Colors.brown, fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            SizedBox(
              child: Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                height: 1,
                color: Colors.brown,
              ),
            ),SizedBox(
              height: 12,
            ),Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => About()),
                  );
                },
                child:Row(
                  children: [
                    Icon(
                      Icons.help_outline,
                      color: Colors.brown,
                    ),
                    SizedBox(width: 16),
                    Text(
                      "Bantuan",
                      style: TextStyle(color: Colors.brown, fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            SizedBox(
              child: Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                height: 1,
                color: Colors.brown,
              ),
            ),SizedBox(
              height: 12,
            ),Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FAQ()),
                  );
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.help_center_outlined,
                      color: Colors.brown,
                    ),
                    SizedBox(width: 16),
                    Text(
                      "Ketentuan Layanan",
                      style: TextStyle(color: Colors.brown, fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            SizedBox(
              child: Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                height: 1,
                color: Colors.brown,
              ),
            ),SizedBox(
              height: 12,
            ),Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              child: GestureDetector(
                onTap: () {
                  showCircular(context);
                  futureApiLogout(currentUser.token).then((value){
                    Navigator.of(context, rootNavigator: true).pop();
                    currentUser = null;
                    destroySession();
                    startNewPage(context, Login());
                  });
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.exit_to_app,
                      color: Colors.brown,
                    ),
                    SizedBox(width: 16),
                    Text(
                      "Logout",
                      style: TextStyle(color: Colors.brown, fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            SizedBox(
              child: Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                height: 1,
                color: Colors.brown,
              ),
            ),SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }
}
