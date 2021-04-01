import 'dart:async';

import 'package:belah_duren/api/fcm.dart';
import 'package:belah_duren/cart_pickup.dart';
import 'package:belah_duren/global/session.dart';
import 'package:belah_duren/global/variable.dart';
import 'package:belah_duren/home.dart';
import 'package:belah_duren/list_order.dart';
import 'package:belah_duren/list_menu.dart';
import 'package:belah_duren/profile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '';
import 'api/cart.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

// Belah Doeren Notification
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'belah_doeren_channel', // id
  'Belah Doeren', // title
  'This channel is used for important notifications.', // description
  importance: Importance.max,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await loadSession();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

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
    return //currentUser != null ?
    MyHomePage(title: 'Flutter Demo Home Page')
        //: Login()
    ;
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
    setState(() {
      _selectedItem = 1;
    });
  }

  int _selectedItem = 0;
  List pages ;

  saveToken(token){
//    print(token);
    if(currentUser == null ){
      print("not login");
    } else if (userRegistrationToken != token) {
      futureApiSendRegistrationToken(currentUser.token, token).then((value){
        if(value.isSuccess()) {
          userRegistrationToken = token;
          storeRegistrationTokenSession();
        }
      });
    } else {
      print("already sent token. not yet refreshed.");
      //do nothing
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    new Timer.periodic(Duration(milliseconds: 500), (Timer t) => setState((){
      Future.delayed(Duration.zero, (){
        futureApiCartList(currentUser.token).then((value) {
          if(value.isSuccess()){
            carts = value.data;
            countCart = carts.length;
          }
        });
      });
    }));
    pages = [
      Home(gotoMenu),
      ListMenu(),
      ListOrder(),
      Profile()
    ];

    if(currentUser == null){
      destroySession();
    }

    FirebaseMessaging.instance.requestPermission(
        sound: true, badge: true, alert: true, provisional: false)
        .then((value){
          debugPrint('Settings registered: ${value.authorizationStatus}');
    });

    if(userRegistrationToken == null)
      FirebaseMessaging.instance.getToken().then((token) => saveToken(token));
    FirebaseMessaging.instance.onTokenRefresh.listen(saveToken);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                icon: 'launch_background',
              ),
            ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: FloatingActionButton(
          child: Stack(
            children: [
              Icon(Icons.shopping_cart_outlined, color: Colors.brown[700], size: 35,),
              Positioned(
                top: -2,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(4),
                      decoration: new BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(countCart.toString(),
                        style: TextStyle(color: Colors.brown, fontSize: 12),
                      )
                  )
              ),
            ],
          ),
          backgroundColor: Colors.white,
          onPressed: (){
            setState(() {
              if(currentUser != null){
                nextPage(context, CartPickup());
                countCart.toString();
              }else{
                alertDialogMustLogin(context, "Belum Login", "Anda harus login terlebih dahulu");
              }
            });
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 3,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: MediaQuery.of(context).size.width/5,
                    onPressed: (){
                      setState(() {
                        _selectedItem = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          Image.asset(_selectedItem == 0 ? "assets/images/home_on.png" : "assets/images/home_off.png", width: 35,)
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: MediaQuery.of(context).size.width/5,
                    onPressed: (){
                      setState(() {
                        _selectedItem = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(_selectedItem == 1 ? "assets/images/shop_on.png" : "assets/images/shop_off.png", width: 35,)
                      ],
                    ),
                  ),
                ],
              ),Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: MediaQuery.of(context).size.width/5,
                    onPressed: (){
                      setState(() {
                        _selectedItem = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(_selectedItem == 2 ? "assets/images/inbox_on.png" : "assets/images/inbox_off.png", width: 35,)
                      ],
                    ),
                  ),MaterialButton(
                    minWidth: MediaQuery.of(context).size.width/5,
                    onPressed: (){
                      setState(() {
                        _selectedItem = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(_selectedItem == 3 ? "assets/images/profile_on.png" : "assets/images/profile_off.png", width: 35,)
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: pages[_selectedItem],
    );
  }

  updateCountCart(BuildContext context){
    showCircular(context);
    futureApiCartList(currentUser.token).then((value){
      Navigator.of(context, rootNavigator: true).pop();
      if(value.isSuccess()){
        carts = value.data;
        countCart = carts.length;
      }
    });
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

