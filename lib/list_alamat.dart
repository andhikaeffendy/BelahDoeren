import 'package:belah_duren/api/address.dart';
import 'package:belah_duren/global/variable.dart';
import 'package:belah_duren/model/address.dart';
import 'package:belah_duren/form_alamat.dart';
import 'package:flutter/material.dart';

class ListAlamat extends StatefulWidget {
  bool pickAddress = false;

  ListAlamat([this.pickAddress]);

  @override
  _ListAlamatState createState() => _ListAlamatState();
}

class _ListAlamatState extends State<ListAlamat> {

  List<Address> listAddress = List<Address>.empty();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      updateAlamat();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.brown
        ),
        title: Center(
          child: Text(
            "Daftar Alamat",
            style: TextStyle(
                color: Colors.brown[700], fontWeight: FontWeight.bold),
          ),
        ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add), iconSize: 30, color: Colors.brown,
              onPressed: () async{
                await nextPage(context, FormAlamat(false, null));
                updateAlamat();
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => FormAlamat(false, null)),
                // );
              })
        ],
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
                              hintText: "Cari Alamat",
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
                  future: futureApiAddress(currentUser.token, currentUser.id),
                  builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator(),
                  );
                }else if(snapshot.connectionState == ConnectionState.done){
                  print(snapshot.data);
                  ApiAddress apiAddress = snapshot.data;
                  if(apiAddress.isSuccess()){
                    listAddress = apiAddress.data;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: listAddress.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: ()async{
                            if(widget.pickAddress){
                              Navigator.of(context, rootNavigator: true).pop(listAddress[index]);
                            } else {
                              await nextPage(context,
                                  FormAlamat(true, listAddress[index]));
                              updateAlamat();
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //     builder: (context) => FormAlamat(true, listAddress[index]),
                              // ));
                            }
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
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Alamat Pengiriman Utama - Kantor",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.brown[800]),
                                            ),
                                            SizedBox(
                                              width: 16,
                                            ),
                                            Icon(Icons.more_horiz_outlined)
                                          ],
                                        )
                                    )),
                                SizedBox(
                                  height: 12,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(listAddress[index].name,
                                            style: TextStyle(color: Colors.brown, fontSize: 16, fontWeight: FontWeight.bold),
                                          ),Text(listAddress[index].address,
                                            style: TextStyle(color: Colors.brown, fontSize: 12),
                                          ),Text(listAddress[index].lat,
                                            style: TextStyle(color: Colors.brown, fontSize: 12),
                                          ),Text(listAddress[index].long,
                                            style: TextStyle(color: Colors.brown, fontSize: 12),
                                          ),
                                        ],
                                      ),
                                      Icon(Icons.assignment, color: Colors.brown, size: 35,)
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                }
              })
            ],
          ),
        ),
      ),
    );
  }

  updateAlamat(){
    showCircular(context);
    futureApiAddress(currentUser.token, currentUser.id).then((value) async {
      Navigator.of(context, rootNavigator: true).pop();
      if(value.isSuccess()){
        setState(() {
          listAddress = value.data;
        });
      }
    });
  }
}
