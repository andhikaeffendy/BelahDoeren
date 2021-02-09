import 'package:flutter/material.dart';

class ListMenu extends StatefulWidget {
  @override
  _ListMenuState createState() => _ListMenuState();
}

class _ListMenuState extends State<ListMenu>
    with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding:
                EdgeInsets.only(left: 16, right: 16, top: 30, bottom: 16),
            decoration: BoxDecoration(
                color: Colors.yellow[600],
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  "assets/images/pickup_icon.jpg",
                  color: Colors.white,
                  height: 70,
                  width: 70,
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  width: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Pickup - 5 KM",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      "Bandung - PROGO",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  width: 8,
                ),
                Icon(
                  Icons.arrow_downward_sharp,
                  size: 50,
                  color: Colors.white,
                )
              ],
            ),
          ),
          SizedBox(
            height: 16,
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
                isScrollable: false,
                indicator: BoxDecoration(
                    color: Colors.red[100],
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(15),
                        topLeft: Radius.circular(15))),
                tabs: <Widget>[
                  Tab(text: "Favorite"),
                  Tab(text: "Desert"),
                  Tab(text: "Pattiserie"),
                  Tab(text: "Promo"),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Expanded(child: TabBarView(
            controller: _tabController,
            children: [
              _listViewMenu(context),
              _listViewMenu(context),
              _listViewMenu(context),
              _listViewMenu(context),
            ],
            )
          ),
        ],
      ),
    );
  }
}

Widget _alertDialog(BuildContext context) {
  return AlertDialog(
    content: Container(
      height: 220.0,
      width: 400,
      // decoration: BoxDecoration(
      //     border: Border.all(),
      //     color: Colors.white,
      //     borderRadius: BorderRadius.circular(25)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset("assets/images/pickup.png",
                  width: MediaQuery.of(context).size.width / 3,
                  height: 100,
                  fit: BoxFit.cover),
              Image.asset("assets/images/delivery.png",
                  width: MediaQuery.of(context).size.width / 3,
                  height: 100,
                  fit: BoxFit.cover)
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Text(
                      "Ambil pesananmu - 5 KM",
                      style: TextStyle(
                          color: Colors.brown[500],
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, bottom: 16),
                    child: Text(
                      "JL. PROGO No.3, Bandung",
                      style: TextStyle(
                          color: Colors.brown[500],
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 16,
              ),
              Icon(
                Icons.arrow_forward_outlined,
                size: 30,
                color: Colors.grey[400],
              )
            ],
          ),Center(
            child: ButtonTheme(
              padding: EdgeInsets.all(12),
              minWidth: 100,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: Colors.yellow[600])),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                color: Colors.yellow[600],
                textColor: Colors.black,
                child: Text("Simpan".toUpperCase(),
                    style: TextStyle(fontSize: 16)),
              ),),
          )
        ],
      ),
    ),
  );
}

Widget _listViewMenu(BuildContext context){
  return GridView.builder(
      itemCount: 4,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.05,
          mainAxisSpacing: 12,
          crossAxisSpacing: 8),
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return _alertDialog(context);
                });
          },
          child: Container(
            padding: EdgeInsets.only(bottom: 8),
            margin: EdgeInsets.only(left: 16, right: 16, bottom: 8),
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  "https://awsimages.detik.net.id/community/media/visual/2017/10/06/d90ddfb6-c25b-4bd0-9893-0ac1738d3a5b.jpg?a=1",
                  fit: BoxFit.fill,
                  width: double.infinity,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Pancake Durian Original",
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.brown[600],
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  "200.000",
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(
                  height: 4,
                ),
              ],
            ),
          ),
        );
      });
}