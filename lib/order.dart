import 'package:belah_duren/api/transactions.dart';
import 'package:belah_duren/global/variable.dart';
import 'package:belah_duren/list_alamat.dart';
import 'package:belah_duren/list_store.dart';
import 'package:belah_duren/model/transaction.dart';
import 'package:flutter/material.dart';

class Order extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {

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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding:
                    EdgeInsets.only(left: 16, right: 16),
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
              ),SizedBox(
                height: 24,
              ),
              FutureBuilder(
                future: futureApiTransaction(currentUser.token, currentUser.id),
                  builder: (context, snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      //print(snapshot.data);
                      return Center(
                        child: new CircularProgressIndicator(),
                      );
                    }
                    else if(snapshot.hasError){
                      print(snapshot.data);
                    }
                    else if(snapshot.connectionState == ConnectionState.done){
                      ApiTransaction apiTransaction = snapshot.data;
                      if (apiTransaction.isSuccess()){
                        transaction = apiTransaction.data;
                        print(transaction);
                        //transaction.addAll(apiTransaction.data);
                      }
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: transaction.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ListAlamat()),
                            );
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
                                        color: Colors.brown[300],
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10))),
                                    width: double.infinity,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        transaction[index].tax.toString(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.brown[800]),
                                      ),
                                    )),
                                SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Nomor Pesanan : " + transaction[index].transaction_number.toString(),
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 12,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: Colors.brown,
                                              ),
                                              height: 50,
                                              width: 50,
                                            ),
                                            SizedBox(
                                              width: 16,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Discount : " + transaction[index].discount.toString() + "%",
                                                  style: TextStyle(
                                                      color: Colors.brown[500]),
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                  transaction[index].voucher_code,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.brown[500]),
                                                ),SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                  transaction[index].total_price.toString(),
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.brown[500]),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    Text(
                                      transaction[index].grand_total.toString(),
                                      style: TextStyle(
                                        color: Colors.brown[800],
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}