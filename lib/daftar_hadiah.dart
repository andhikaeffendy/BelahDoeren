import 'package:belah_duren/api/point_transaction.dart';
import 'package:belah_duren/global/variable.dart';
import 'package:flutter/material.dart';

import 'model/present_list.dart';

class DaftarHadiah extends StatefulWidget {
  @override
  _DaftarHadiahState createState() => _DaftarHadiahState();
}

class _DaftarHadiahState extends State<DaftarHadiah> {

  List<PresentList> presents = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.brown),
        centerTitle: true,
        title: Text(
          "Daftar Hadiah",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.brown[700]),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  padding:
                      EdgeInsets.only(top: 16, bottom: 16, left: 12, right: 8),
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
              SizedBox(
                height: 16,
              ),
              FutureBuilder(
                  future: futureApiPresentList(currentUser.token),
                  builder: (context, snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }else if(snapshot.connectionState == ConnectionState.done){
                      ApiPresentList apiPresent = snapshot.data;
                      if(apiPresent.isSuccess()){
                        presents = apiPresent.data;
                      }
                    } return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: presents.length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  child: Image.network(presents[index].image_url,
                                    fit: BoxFit.fill, height: 150,),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            presents[index].name,
                                            style: TextStyle(
                                                color: Colors.brown, fontSize: 14, fontWeight: FontWeight.bold
                                            ),
                                          ),Text(
                                            presents[index].point.toString(),
                                            style: TextStyle(
                                                color: Colors.green[900], fontSize: 12
                                            ),
                                          ),
                                        ],
                                      ), FlatButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8.0),
                                            side: BorderSide(color: Colors.yellow[700])),
                                        color: Colors.yellow[700],
                                        textColor: Colors.black,
                                        onPressed: () {
                                          showModalBottomSheet(
                                              isScrollControlled: true,
                                              context: context,
                                              builder: (builder){
                                                return new Container(
                                                  height: MediaQuery.of(context).size.height*.55,
                                                  padding: EdgeInsets.all(16),
                                                  color: Colors.transparent, //could change this to Color(0xFF737373),
                                                  //so you don't have to change MaterialApp canvasColor
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          width: 50,
                                                          color: Colors.brown,
                                                          height: 1,
                                                        ),
                                                        SizedBox(
                                                          height: 16,
                                                        ),
                                                        Container(
                                                          decoration:
                                                          BoxDecoration(borderRadius: BorderRadius.circular(40)),
                                                          child: Image.network(
                                                            presents[index].image_url,
                                                            fit: BoxFit.cover,
                                                            height: 200,
                                                            width: double.infinity,
                                                          ),
                                                        ),SizedBox(
                                                          height: 16,
                                                        ),Container(
                                                          child: Text(
                                                            presents[index].description,
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight: FontWeight.bold,
                                                                color: Colors.brown[700]
                                                            ),
                                                            textAlign: TextAlign.center,
                                                          ),
                                                        ),SizedBox(
                                                          height: 8,
                                                        ),Text(
                                                          "Apakah anda yakin ingin menukar point?",
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color: Colors.black38
                                                          ),
                                                        ),SizedBox(
                                                          height: 8,
                                                        ),Text(
                                                          presents[index].point.toString(),
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.green[900]
                                                          ),
                                                        ),SizedBox(
                                                          height: 16,
                                                        ),ButtonTheme(
                                                            padding: EdgeInsets.symmetric(vertical: 8),
                                                            minWidth: double.infinity,
                                                            child: RaisedButton(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(8.0),
                                                                  side: BorderSide(color: Colors.yellow[600])),
                                                              onPressed: (){
                                                                showCircular(context);
                                                                futureApiSubmitPointsTransaction(currentUser.token, presents[index].id).then((value){
                                                                  Navigator.of(context, rootNavigator: true).pop();
                                                                  if(value.isSuccess()){
                                                                    alertDialog(context, "Tukar Point", "Tukar Point Berhasil");
                                                                  }else{
                                                                    alertDialog(context, "Tukar Point", value.message);
                                                                  }
                                                                });
                                                              },
                                                              color: Colors.yellow[600],
                                                              textColor: Colors.black,
                                                              child: Text("Tukar Sekarang",
                                                                  style: TextStyle(
                                                                    fontSize: 16,
                                                                    fontWeight: FontWeight.bold,

                                                                  )
                                                              ),
                                                            )),SizedBox(
                                                          height: 8,
                                                        ),ButtonTheme(
                                                            padding: EdgeInsets.symmetric(vertical: 8),
                                                            minWidth: double.infinity,
                                                            child: RaisedButton(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(8.0),
                                                                  side: BorderSide(color: Colors.black45)),
                                                              onPressed: (){
                                                                Navigator.of(context).pop();
                                                              },
                                                              color: Colors.white,
                                                              textColor: Colors.brown[800],
                                                              child: Text("Batal",
                                                                  style: TextStyle(
                                                                    fontSize: 16,
                                                                    fontWeight: FontWeight.bold,

                                                                  )
                                                              ),
                                                            ))
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }
                                          );
                                        },
                                        child: Text(
                                          "Tukar",
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        });
                  }
                  )

            ],
          ),
        ),
      ),
    );
  }

}


