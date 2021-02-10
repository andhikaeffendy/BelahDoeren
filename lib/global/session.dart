import 'package:belah_duren/model/user.dart';
import 'package:belah_duren/model/branch.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'variable.dart';
import 'dart:convert';

final String sessionUser = "belahDurenUserSession";
final String sessionBranch = "belahDurenBranchSession";

storeSession() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(sessionUser, json.encode(currentUser.toJson()));
}

storeBranchSession() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(sessionBranch, json.encode(selectedBranch.toJson()));
}

destroySession() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
}

Future loadSession() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String userSession = _get_data(prefs, sessionUser);
  String branchSession = _get_data(prefs, sessionBranch);
  if(userSession != null){
    currentUser = User.fromJson(json.decode(userSession));
  }
  if(branchSession != null){
    selectedBranch = Branch.fromJson(json.decode(branchSession));
  }
}

_get_data(SharedPreferences prefs, key){
  return prefs.containsKey(key) ? prefs.getString(key) : null;
}