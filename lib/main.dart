import 'package:belah_duren/global/session.dart';
import 'package:belah_duren/global/variable.dart';
import 'package:belah_duren/home.dart';
import 'package:belah_duren/login.dart';
import 'package:belah_duren/order.dart';
import 'package:belah_duren/list_menu.dart';
import 'package:belah_duren/profile.dart';
import 'package:flutter/material.dart';

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
  int _selectedItem = 0;
  final List pages = [
    Home(),
    ListMenu(),
    Order(),
    Profile()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(
        iconList: [
          Icons.home_rounded,
          Icons.shopping_bag_outlined,
          Icons.mail_outline,
          Icons.perm_identity
        ],
          onChange: (val){
            setState(() {
              _selectedItem = val;
            });
          },
          defaultSelectedIndex: 0),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: (){

        },
        backgroundColor: Colors.white,
        child: ImageIcon(AssetImage("assets/images/scan_qr.png",), color: Colors.brown,),
      ),
      body: pages[_selectedItem],
    );
  }
}

class CustomBottomNavigationBar extends StatefulWidget {
  final int defaultSelectedIndex;
  final Function(int) onChange;
  final List<IconData> iconList;

  CustomBottomNavigationBar(
      {this.defaultSelectedIndex = 0,
        @required this.iconList,
        @required this.onChange});

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndexItem = 0;
  List<IconData> _iconList=[];


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

    return Row(
      children: _navBarItem,
    );
  }

  Widget buildNavBar(IconData iconData, int index) {
    return GestureDetector(
      onTap: () {
        widget.onChange(index);
        setState(() {
          _selectedIndexItem = index;
        });
      },
      child: Container(
        height: 50.0,
        width: MediaQuery.of(context).size.width / _iconList.length,
        decoration: index == _selectedIndexItem
            ? BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 4, color: Colors.yellow[700])),
                gradient: LinearGradient(colors: [
                  Colors.yellow[700].withOpacity(0.3),
                  Colors.yellow[700].withOpacity(0.18),
                  Colors.yellow[700].withOpacity(0.50),
                ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
                // color: index == _selectedIndexItem ? Colors.yellow : Colors.white
                )
            : BoxDecoration(),
        child: Icon(
          iconData,
          color: index == _selectedIndexItem ? Colors.brown[700] : Colors.grey,
        ),
      ),
    );
  }
}
