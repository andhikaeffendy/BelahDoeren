import 'package:belah_duren/api/point_transaction.dart';
import 'package:belah_duren/global/variable.dart';
import 'package:belah_duren/model/point_transaction_list.dart';
import 'package:flutter/material.dart';

class HistoryPenukaranPoints extends StatefulWidget {
  @override
  _HistoryPenukaranPointsState createState() => _HistoryPenukaranPointsState();
}

class _HistoryPenukaranPointsState extends State<HistoryPenukaranPoints> {

  List<PointTransactionList> listTransaksiPoints = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.brown),
        title: Text(
          "History Penukaran Points",
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
                padding: EdgeInsets.only(left: 16, right: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200]),
                child: Row(
                  children: [
                    Icon(
                      Icons.search_outlined,
                      color: Colors.grey[700],
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: "Search",
                              hintStyle: TextStyle(
                                color: Colors.grey[700],
                              ),
                              border: InputBorder.none),
                          style: TextStyle(color: Colors.black),
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: 24,
              ),FutureBuilder(
                future: futureApiPointTransaction(currentUser.token),
                  builder: (context, snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }else if(snapshot.connectionState == ConnectionState.done){
                    ApiPointTransaction dataTransaction = snapshot.data;
                    if(dataTransaction.isSuccess()){
                      listTransaksiPoints = dataTransaction.data;
                    }
                  }
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: listTransaksiPoints.length,
                      itemBuilder: (context, index){
                        return Container(
                          margin: EdgeInsets.only(bottom: 12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.network(listTransaksiPoints[index].image_url,
                                fit: BoxFit.contain,
                                width: 100,
                              height: 100,),
                              SizedBox(
                                width: 8,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(listTransaksiPoints[index].present_name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, color: Colors.brown,
                                        fontSize: 14
                                    ),),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text("Points Redeem : "+listTransaksiPoints[index].point_redeemed.toString(),
                                    style: TextStyle( color: Colors.brown,
                                        fontSize: 12
                                    ),),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text("Remaining Points : " +listTransaksiPoints[index].remaining_point.toString(),
                                    style: TextStyle( color: Colors.brown,
                                        fontSize: 12
                                    ),),
                                ],
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
