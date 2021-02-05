import 'package:belah_duren/about.dart';
import 'package:belah_duren/api/logout.dart';
import 'package:belah_duren/global/session.dart';
import 'package:belah_duren/global/variable.dart';
import 'package:belah_duren/login.dart';
import 'package:flutter/material.dart';

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
              padding: EdgeInsets.only(left: 16, right: 16, top: 30, bottom: 8),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.yellow[600],
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
                  border: Border.all(
                      width: 1,
                      color: Colors.yellow,
                      style: BorderStyle.solid)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                      "assets/images/smile.png",
                      width: 80,
                      height: 80,
                      fit: BoxFit.fill),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hallo John",
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
                            "Member Gold",
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
            Container(
                padding: EdgeInsets.all(12),
                margin: EdgeInsets.only(left: 16, right: 16),
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
                    Icon(Icons.arrow_forward, color: Colors.white, size: 25,)
                  ],
                )),
            SizedBox(
              height: 24.0,
            ),
            Container(
              margin: EdgeInsets.only(left: 16, right: 16),
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
