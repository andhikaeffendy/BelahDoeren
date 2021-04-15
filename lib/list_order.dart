import 'package:belah_duren/api/transactions.dart';
import 'package:belah_duren/detail_order.dart';
import 'package:belah_duren/global/session.dart';
import 'package:belah_duren/global/variable.dart';
import 'package:belah_duren/model/transaction.dart';
import 'package:flutter/material.dart';

class ListOrder extends StatefulWidget {
  @override
  _ListOrderState createState() => _ListOrderState();
}

class _ListOrderState extends State<ListOrder> {
  List<Transaction> transaction = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Order",
            style: TextStyle(
                color: Colors.brown[700], fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child:
        currentUser != null ?
        SingleChildScrollView(
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
              ),
              FutureBuilder(
                  future:
                      futureApiTransaction(currentUser.token, currentUser.id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      //print(snapshot.data);
                      return Center(
                        child: new CircularProgressIndicator(),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      ApiTransaction apiTransaction = snapshot.data;
                      if (apiTransaction.isSuccess()) {
                        transaction = apiTransaction.data;
                        //transaction.addAll(apiTransaction.data);
                      }else{
                        isValidToken(context, apiTransaction.message);
                        print("error "+apiTransaction.message);
                      }
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: transaction.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            nextPage(context, DetailOrder(transactionMenu: transaction[index]));
                            // _cartBottomSheet(context);
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 16),
                            padding: EdgeInsets.only(bottom: 24),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    padding: EdgeInsets.only(top: 8, bottom: 8),
                                    decoration: BoxDecoration(
                                        color: Colors.brown[100],
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10))),
                                    width: double.infinity,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            transaction[index].transaction_number,
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.brown[800]),
                                          ),
                                        ),Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            transaction[index].transaction_date_name,
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.brown[800]),
                                          ),
                                        )
                                      ],
                                    )
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(16),
                                      ),
                                      margin: EdgeInsets.only(left: 16, top: 8, bottom: 8),
                                      child: Image.network(
                                        transaction[index].image_url,
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(16),
                                            color: Color(int.parse(transaction[index].transaction_status_color))
                                          ),
                                          child: Text(transaction[index].transaction_status_name),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context).size.width/3,
                                          height: 50,
                                          child: SingleChildScrollView(
                                            child: Text(
                                              transaction[index].description,
                                              style: TextStyle(
                                                fontSize: 12,
                                                  color: Colors.brown[500]),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 16,
                                        ),
                                        Text(
                                          transaction[index]
                                              .total_price
                                              .toString(),
                                          style: TextStyle(
                                              fontWeight:
                                              FontWeight.bold,
                                              color: Colors.brown[500]),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  })
            ],
          ),
        )
        :
        widgetMustLogin(context)
        ,
      ),
    );
  }

}
