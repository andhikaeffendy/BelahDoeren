import 'package:belah_duren/api/branch.dart';
import 'package:belah_duren/global/variable.dart';
import 'package:belah_duren/model/branch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListStore extends StatefulWidget {
  @override
  _ListStoreState createState() => _ListStoreState();
}

class _ListStoreState extends State<ListStore> with TickerProviderStateMixin {
  TabController _tabController;
  List<Branch> branches = [];

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(vsync: this, length: 4);
    super.initState();
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
        title: Text("Lokasi Outlet Belah Doeren",style: TextStyle(color: Colors.brown[700], fontWeight: FontWeight.bold),),
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    setState(() {
                      selectedOrderType = "pickup";
                    });
                  },
                  child: Image.asset("assets/images/pickup.png",
                      width: MediaQuery.of(context).size.width / 2.2,
                      height: 100,
                      fit: BoxFit.cover),
                ),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      selectedOrderType = "delivery";
                    });
                  },
                  child: Image.asset("assets/images/delivery.png",
                      width: MediaQuery.of(context).size.width / 2.2,
                      height: 100,
                      fit: BoxFit.cover),
                ),

              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: Colors.lightGreen[700],
                  size: 30,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Gunakan Lokasi Saat Ini",
                  style: TextStyle(color: Colors.lightGreen[700], fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              height: 1,
              color: Colors.brown[100],
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              padding: EdgeInsets.only(top: 8),
              child: SizedBox(
                height: 30,
                child: TabBar(
                  unselectedLabelColor: Colors.brown,
                  labelColor: Colors.red,
                  controller: _tabController,
                  indicator: BoxDecoration(
                      color: Colors.red[100],
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(15),
                          topLeft: Radius.circular(15))),
                  tabs: <Widget>[
                    Tab(text: "Bandung"),
                    Tab(text: "Cimahi"),
                    Tab(text: "Jakarta"),
                    Tab(text: "Bogor"),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              height: 1,
              color: Colors.brown[100],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: viewAddress(context),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> viewAddress(BuildContext context){
    List<Widget> addressViews = [];
    addressViews.add(
      FutureBuilder(
        future: futureApiBranches(currentUser.token),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            print(snapshot.data);
            ApiBranch apiData = snapshot.data;
            if(apiData.isSuccess()){
              branches = apiData.data;
            }
          }
          return _listViewAlamat(context, branches);
        },
      )
    );
    addressViews.add(_listViewAlamat(context, []));
    addressViews.add(_listViewAlamat(context, []));
    addressViews.add(_listViewAlamat(context, []));
    return addressViews;
  }
}

Widget _listViewAlamat(BuildContext context, List<Branch> branches){
  return ListView.builder(
    itemCount: branches.length,
    itemBuilder: (context, index){
      return GestureDetector(
          onTap: (){
            Navigator.pop(context, [branches[index], selectedOrderType]);
          },
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 16, right: 16, top: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    selectedBranch.id == branches[index].id ?
                        Icon(
                          Icons.check,
                          size: 30,
                          color: Colors.grey,
                        ) :
                        SizedBox(
                          width: 24,
                        )
                    ,SizedBox(
                      width: 12,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (selectedOrderType == "pickup" ? "Pickup - " : "Delivery - ") + branches[index].distanceFromHere(),
                          style: TextStyle(
                              color: Colors.brown[700]),
                        ),Text(
                          branches[index].name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.brown[700],
                              fontSize: 18),
                        ),Text(
                          branches[index].address,
                          style: TextStyle(
                              color: Colors.brown[700]),
                        ),Text(
                          "Kota Bandung",
                          style: TextStyle(
                              color: Colors.brown[700]),
                        )
                      ],
                    ),Spacer(),
                    Icon(Icons.help_outline, color: Colors.lightGreen[700])
                  ],
                ),
              ),SizedBox(
                height: 16,
              ),Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                height: 1,
                color: Colors.brown,
              )
            ],
          )
      );
    },
  );
}
