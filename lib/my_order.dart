import 'package:belah_duren/api/transactions.dart';
import 'package:belah_duren/global/variable.dart';
import 'package:belah_duren/model/transaction_list.dart';
import 'package:flutter/material.dart';

class MyOrder extends StatefulWidget {
  @override
  _MyOrderState createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> with TickerProviderStateMixin{

  TabController _tabController;
  List<TransactionList> activeTab = [];
  List<TransactionList> pastTab = [];
  List<TransactionList> canceledTab = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

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
          margin: EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              padding: EdgeInsets.only(top: 8),
              child: SizedBox(
                height: 30,
                child: Center(
                  child: TabBar(
                    unselectedLabelColor: Colors.brown,
                    isScrollable: true,
                    labelColor: Colors.white,
                    controller: _tabController,
                    indicator: BoxDecoration(
                        color: Color(0XFFfab4b4),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(5),
                            topLeft: Radius.circular(5))),
                    tabs: [
                      Tab(child: Text("Saat ini"),),
                      Tab(child: Text("Selesai"),),
                      Tab(child: Text("Dibatalkan"),),
                    ],
                  ),
                ),
              ),
            ),SizedBox(
              height: 16,
            ),
            Expanded(child: TabBarView(
              controller: _tabController,
              children: [
                activeTab.isNotEmpty ? _listEmpty() : _listActiveTransaction(),
                pastTab.isNotEmpty ? _listEmpty() : _listPastTransaction(),
                canceledTab.isNotEmpty ? _listEmpty() : _listCanceledTransaction(),
              ],
            ))
          ],
        ),
      ),
    );
  }

  Widget _listEmpty(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/images/empty_history.png",
          fit: BoxFit.fill,),
        SizedBox(
          height: 16,
        ),
        Text(
          "Belum ada pesanan",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.brown[700]),
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          "Belanja produk pilihanmu sekarang\natau lihat semua produk di halaman menu",
          style: TextStyle(
              fontSize: 14,
              color: Colors.black38),
          textAlign: TextAlign.center,
        )
      ],
    );
  }

  Widget _listActiveTransaction(){
    return FutureBuilder(
        future: futureApiGetActiveTransaction(currentUser.token),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }else if(snapshot.connectionState == ConnectionState.done){
            ApiListTransaction apiListTransaction = snapshot.data;
            if(apiListTransaction.isSuccess()){
              activeTab = apiListTransaction.data;
              if(activeTab.isEmpty){
                return _listEmpty();
              }
            }
            return ListView.builder(
              itemCount: activeTab.length,
              itemBuilder: (context, index) {
                return Container(
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
                              activeTab[index].tax.toString(),
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
                        mainAxisAlignment:
                        MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Nomor Pesanan : " +
                                    activeTab[index]
                                        .transaction_number
                                        .toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(5),
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
                                        "Discount : " +
                                            activeTab[index]
                                                .discount
                                                .toString() +
                                            "%",
                                        style: TextStyle(
                                            color: Colors.brown[500]),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        activeTab[index]
                                            .voucher_code ==
                                            null
                                            ? "0"
                                            : activeTab[index]
                                            .voucher_code,
                                        style: TextStyle(
                                            fontWeight:
                                            FontWeight.bold,
                                            color: Colors.brown[500]),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        activeTab[index]
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
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                activeTab[index].grand_total.toString(),
                                style: TextStyle(
                                  color: Colors.brown[800],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),SizedBox(
                                height: 8,
                              ),
                              Text(
                                activeTab[index].transaction_type.toString(),
                                style: TextStyle(
                                  color: Colors.brown[800],
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          }
        });
  }

  Widget _listPastTransaction(){
    return FutureBuilder(
        future: futureApiGetPastTransaction(currentUser.token),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }else if(snapshot.connectionState == ConnectionState.done){
            ApiListTransaction apiListTransaction = snapshot.data;
            if(apiListTransaction.isSuccess()){
              pastTab = apiListTransaction.data;
              if(pastTab.isEmpty){
                return _listEmpty();
              }
            }
            return ListView.builder(
              itemCount: pastTab.length,
              itemBuilder: (context, index) {
                return Container(
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
                              pastTab[index].tax.toString(),
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
                        mainAxisAlignment:
                        MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Nomor Pesanan : " +
                                    pastTab[index]
                                        .transaction_number
                                        .toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(5),
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
                                        "Discount : " +
                                            pastTab[index]
                                                .discount
                                                .toString() +
                                            "%",
                                        style: TextStyle(
                                            color: Colors.brown[500]),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        pastTab[index]
                                            .voucher_code ==
                                            null
                                            ? "0"
                                            : pastTab[index]
                                            .voucher_code,
                                        style: TextStyle(
                                            fontWeight:
                                            FontWeight.bold,
                                            color: Colors.brown[500]),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        pastTab[index]
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
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                pastTab[index].grand_total.toString(),
                                style: TextStyle(
                                  color: Colors.brown[800],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),SizedBox(
                                height: 8,
                              ),
                              Text(
                                pastTab[index].transaction_type.toString(),
                                style: TextStyle(
                                  color: Colors.brown[800],
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          }
        });
  }

  Widget _listCanceledTransaction(){
    return FutureBuilder(
        future: futureApiGetCanceledTransaction(currentUser.token),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }else if(snapshot.connectionState == ConnectionState.done){
            ApiListTransaction apiListTransaction = snapshot.data;
            if(apiListTransaction.isSuccess()){
              canceledTab = apiListTransaction.data;
              if(canceledTab.isEmpty){
                return _listEmpty();
              }
            }
            return ListView.builder(
              itemCount: canceledTab.length,
              itemBuilder: (context, index) {
                return Container(
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
                              canceledTab[index].tax.toString(),
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
                        mainAxisAlignment:
                        MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Nomor Pesanan : " +
                                    canceledTab[index]
                                        .transaction_number
                                        .toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(5),
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
                                        "Discount : " +
                                            canceledTab[index]
                                                .discount
                                                .toString() +
                                            "%",
                                        style: TextStyle(
                                            color: Colors.brown[500]),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        canceledTab[index]
                                            .voucher_code ==
                                            null
                                            ? "0"
                                            : canceledTab[index]
                                            .voucher_code,
                                        style: TextStyle(
                                            fontWeight:
                                            FontWeight.bold,
                                            color: Colors.brown[500]),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        canceledTab[index]
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
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                canceledTab[index].grand_total.toString(),
                                style: TextStyle(
                                  color: Colors.brown[800],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),SizedBox(
                                height: 8,
                              ),
                              Text(
                                canceledTab[index].transaction_type.toString(),
                                style: TextStyle(
                                  color: Colors.brown[800],
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          }
        });
  }

}
