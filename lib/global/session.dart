import 'package:belah_duren/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'variable.dart';
import 'dart:convert';

final String sessionUser = "belahDurenUserSession";

storeSession() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(sessionUser, json.encode(currentUser.toJson()));
}

destroySession() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
}

Future loadSession() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String userSession = _get_data(prefs, sessionUser);
  if(userSession != null){
    currentUser = User.fromJson(json.decode(userSession));
  }
}

_get_data(SharedPreferences prefs, key){
  return prefs.containsKey(key) ? prefs.getString(key) : null;
}