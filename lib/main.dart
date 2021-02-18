import 'package:belah_duren/global/session.dart';
import 'package:belah_duren/global/variable.dart';
import 'package:belah_duren/home.dart';
import 'package:belah_duren/login.dart';
import 'package:belah_duren/order.dart';
import 'package:belah_duren/list_menu.dart';
import 'package:belah_duren/profile.dart';
import 'package:flutter/material.dart';
import '';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadSession();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _getStartupScreen(),
    );
  }

  Widget _getStartupScreen() {
    return currentUser != null ? MyHomePage(title: 'Flutter Demo Home Page') : Login();
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void gotoMenu(){
    globalKey.currentState.changePage(1);
  }

  int _selectedItem = 0;
  List pages ;
  GlobalKey<_CustomBottomNavigationBarState> globalKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pages = [
      Home(gotoMenu),
      ListMenu(),
      Order(),
      Profile()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: FloatingActionButton(
          child: Icon(Icons.shopping_cart_outlined, color: Colors.brown[700], size: 30,),
          backgroundColor: Colors.white,
          onPressed: (){

          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNavigationBar(key: globalKey,
        iconList: [
          Icons.home_rounded,
          Icons.store,
          Icons.mail,
          Icons.perm_identity
        ],
          onChange: (val){
            setState(() {
              _selectedItem = val;
            });
          },
          defaultSelectedIndex: 0),
      body: pages[_selectedItem],
    );
  }
}

class CustomBottomNavigationBar extends StatefulWidget {
  final int defaultSelectedIndex;
  final Function(int) onChange;
  final List<IconData> iconList;

  CustomBottomNavigationBar({Key key, this.defaultSelectedIndex, this.onChange, this.iconList}) : super(key: key);

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndexItem = 0;
  List<IconData> _iconList=[];

  void changePage(int index){
    widget.onChange(index);
    setState(() {
      _selectedIndexItem = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedIndexItem = widget.defaultSelectedIndex;
    _iconList = widget.iconList;
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> _navBarItem = [];

    for(var i = 0; i < _iconList.length; i++){
      _navBarItem.add(buildNavBar(_iconList[i], i));
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 5.0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _navBarItem,
      ),
    );
  }

  Widget buildNavBar(IconData iconData, int index) {
    return GestureDetector(
      onTap: () {
        changePage(index);
      },
      child: Container(
        height: 55,
        child: Row(
          children: [
            Row(
              children: [
                MaterialButton(
                    minWidth: 40,
                    onPressed: (){
                      setState(() {
                        changePage(index);
                      });
                    },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(iconData, color: _selectedIndexItem == index ? Colors.brown[700] : Colors.black26,size: 40,),
                    ],
                  ),
                    ),
              ],
            )
          ],
        ),
      ),
    );
  }

}

