import 'package:belah_duren/api/address.dart';
import 'package:belah_duren/api/branch.dart';
import 'package:belah_duren/api/menu.dart';
import 'package:belah_duren/global/session.dart';
import 'package:belah_duren/global/variable.dart';
import 'package:belah_duren/list_store.dart';
import 'package:belah_duren/model/branch.dart';
import 'package:belah_duren/model/menu.dart';
import 'package:belah_duren/model/menu_category.dart';
import 'package:flutter/material.dart';

class ListMenu extends StatefulWidget {
  var addMenu = false;

  ListMenu([this.addMenu = false]);

  @override
  _ListMenuState createState() => _ListMenuState();
}

class _ListMenuState extends State<ListMenu>
    with TickerProviderStateMixin {
  TabController _tabController;
  List<MenuCategory> menuCategories = [new MenuCategory(0, "Promotion")];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, length: 1);
    if(currentUser != null) {
      if (selectedBranch == null && !widget.addMenu){
        futureApiBranches(currentUser.token).then((value){
          if(value.isSuccess()){
            setState(() {
              if(value.data.length > 0) {
                selectedBranch = value.data[0];
                value.data.forEach((branch) {
                  if(branch.distance() < selectedBranch.distance())
                    selectedBranch = branch;
                });
                storeBranchSession();
              }
            });
          } else isValidToken(context, value.message);
        });
      }
      if (selectedAddress == null && !widget.addMenu){
        futureApiAddress(currentUser.token, currentUser.id).then((value){
          if(value.isSuccess()){
            setState(() {
              if(value.data.length > 0) {
                selectedAddress = value.data[0];
                storeAddressSession();
              }
            });
          } else isValidToken(context, value.message);
        });
      }
    }else{
      widgetMustLogin(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    if(currentUser != null){
      if(widget.addMenu) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.brown),
            title: Text("Tambah Pesanan", style: TextStyle(color: Colors.brown)),
          ),
          body: Container(
            child: FutureBuilder(
              future: futureApiMenuCategories(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  print(snapshot.data);
                  ApiMenuCategory apiData = snapshot.data;
                  if (apiData.isSuccess()) {
                    menuCategories = [new MenuCategory(0, "Promotion")];
                    menuCategories.addAll(apiData.data);
                    _tabController =
                        TabController(vsync: this, length: menuCategories.length);
                  }
                }
                return addMenuViews();
              },
            ),
          ),
        );
      } else {
        return Container(
          child: FutureBuilder(
            future: futureApiMenuCategories(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                print(snapshot.data);
                ApiMenuCategory apiData = snapshot.data;
                if (apiData != null && apiData.isSuccess()) {
                  menuCategories = [new MenuCategory(0, "Promotion")];
                  menuCategories.addAll(apiData.data);
                  _tabController =
                      TabController(vsync: this, length: menuCategories.length);
                }
              }
              return menuViews();
            },
          ),
        );
      }
    }else{
      return widgetMustLogin(context);
    }
  }

  Widget menuViews(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding:
          EdgeInsets.only(left: 16, right: 16, top: 44, bottom: 24),
          decoration: BoxDecoration(
              color: Colors.yellow[600],
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 16,
              ),
              selectedBranch == null ?
              SizedBox(
                width: 50,
                height: 50,
              ) :
              Image.network(
                selectedBranch.imageUrl,
                height: 50,
                width: 50,
                fit: BoxFit.fill,
              ),
              SizedBox(
                width: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    selectedBranch == null ? "" : (isPickupOrder() ? "Pickup - " : "Delivery - ") + selectedBranch.distanceFromHere(),
                    style: TextStyle(fontSize: 16, color: Colors.brown),
                  ),
                  Text(
                    selectedBranch == null ? "belum dipilih" : selectedBranch.name,
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold,color: Colors.brown),
                  )
                ],
              ),
              SizedBox(
                width: 8,
              ),
              GestureDetector(
                onTap: () async {
                  var result = await
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return _alertDialog(context);
                      });
                  if(result != null) {
                    setState(() {
                      selectedBranch = result[0];
                      selectedOrderType = result[1];
                    });
                  }
                },
                child: Icon(
                  Icons.arrow_downward_sharp,
                  size: 40,
                  color: Colors.white,
                ),
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
              labelColor: Colors.white,
              controller: _tabController,
              isScrollable: false,
              indicator: BoxDecoration(
                  color: Color(0XFFfab4b4),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15))),
              tabs: tabCategories(),
            ),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Expanded(child: TabBarView(
          controller: _tabController,
          children: tabViewCategories(context),
        )
        ),
      ],
    );
  }

  Widget addMenuViews(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 16, right: 16),
          padding: EdgeInsets.only(top: 8),
          child: SizedBox(
            height: 30,
            child: TabBar(
              unselectedLabelColor: Colors.brown,
              labelColor: Colors.white,
              controller: _tabController,
              isScrollable: false,
              indicator: BoxDecoration(
                  color: Color(0XFFfab4b4),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15))),
              tabs: tabCategories(),
            ),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Expanded(child: TabBarView(
          controller: _tabController,
          children: tabViewCategories(context),
        )
        ),
      ],
    );
  }

  List<Widget> tabCategories(){
    List<Widget> tabs = [];
    menuCategories.forEach((menuCategory) {
      tabs.add(Tab(text: menuCategory.name));
    });
    return tabs;
  }

  List<Widget> tabViewCategories(BuildContext context){
    List<Widget> tabViews = [];
    menuCategories.forEach((menuCategory) {
      tabViews.add( menuCategory.id == 0 ?
        FutureBuilder(
          future:
          currentUser != null && selectedBranch != null ?
          futureApiPromotionMenus(selectedBranch.id)
          :
          futureApiPromotionMenusNotLogin(),
            builder: (context, snapshot){
              if(snapshot.connectionState == ConnectionState.done){
                print(snapshot.data);
                ApiMenu apiData = snapshot.data;
                if(apiData.isSuccess()){
                  menuCategory.menus = apiData.data;
                }
              }
              return _listViewMenu(context, menuCategory.menus);
            },
        ) : (
        selectedBranch == null ? Container() :
          FutureBuilder(
            future: futureApiMenus(currentUser.token, menuCategory.id, selectedBranch.id),
            builder: (context, snapshot){
              if(snapshot.connectionState == ConnectionState.done){
                print(snapshot.data);
                ApiMenu apiData = snapshot.data;
                if(apiData.isSuccess()){
                  menuCategory.menus = apiData.data;
                } else isValidToken(context, apiData.message);
              }
              return _listViewMenu(context, menuCategory.menus);
            },
          )
        )
      );
    });
    return tabViews;
  }

  Widget _alertDialog(BuildContext context) {
    String dialogType = selectedOrderType;
    Items dialogBranch = selectedBranch;
    return StatefulBuilder(
        builder: (context, setState){
      return AlertDialog(
        content: Container(
          height: MediaQuery.of(context).size.height*0.35,
          width: MediaQuery.of(context).size.width*0.8,
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
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        dialogType = "pickup";
                      });
                    },
                    child: Image.asset("assets/images/pickup.png",
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 3,
                        height: 100,
                        fit: BoxFit.cover),
                  ),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          dialogType = "delivery";
                        });
                      },
                      child: Image.asset("assets/images/delivery.png",
                          width: MediaQuery
                              .of(context)
                              .size
                              .width / 3.2,
                          height: 100,
                          fit: BoxFit.fitWidth)
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              GestureDetector(
                onTap: () async {
                  var result = await nextPage(context, ListStore());
                  if (result != null)
                    setState(() {
                      dialogBranch = result[0];
                      dialogType = result[1];
                    });
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Text(
                            (dialogType == "pickup"
                                ? "Ambil pesananmu, di"
                                : "Antar ke alamatmu, dari"),
                            style: TextStyle(
                                color: Colors.brown[500],
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16, bottom: 16),
                          child: Container(
                            height: MediaQuery.of(context).size.height*0.1,
                            width: MediaQuery.of(context).size.width/2.2,
                            child: SingleChildScrollView(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  dialogBranch.address,
                                  style: TextStyle(
                                      color: Colors.brown[500],
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Container(
                      width: 30,
                      child: Icon(
                        Icons.arrow_forward_outlined,
                        size: 30,
                        color: Colors.grey[400],
                      ),
                    )
                  ],
                ),
              )
              , Center(
                child: ButtonTheme(
                  padding: EdgeInsets.all(12),
                  minWidth: 100,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: Colors.yellow[600])),
                    onPressed: () {
                      Navigator.of(context).pop([dialogBranch, dialogType]);
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
    });
  }

  Widget _listViewMenu(BuildContext context, List<Menu> menus){
    return GridView.builder(
        itemCount: menus.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.05,
            mainAxisSpacing: 12,
            crossAxisSpacing: 8),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
                cartBottomSheet(context, menus[index],);
            },
            child: Container(
              padding: EdgeInsets.only(bottom: 8),
              margin: EdgeInsets.only(left: 16, right: 16, bottom: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(1.0, 1.0), //(x,y)
                    blurRadius: 8.0,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child:
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(7),
                      topLeft: Radius.circular(7)
                    ),
                    child: Image.network(
                      menus[index].imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                      menus[index].name,
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.brown[600],
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 8),
                    child:
                    menus[index].new_price == null ?
                    Text(
                      formatCurrency(menus[index].price),
                      style: TextStyle(fontSize: 12,
                      fontWeight: FontWeight.bold),
                    )
                    :
                    Column(
                      children: [
                        Text(
                          formatCurrency(menus[index].price),
                          style: TextStyle(fontSize: 12,
                              decoration: TextDecoration.lineThrough),
                        ),
                        Text(
                          formatCurrency(menus[index].new_price),
                          style: TextStyle(fontSize: 12,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
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

}