import 'package:belah_duren/model/address.dart';
import 'package:belah_duren/model/member_poins.dart';
import 'package:belah_duren/model/user.dart';
import 'package:belah_duren/model/branch.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'variable.dart';
import 'dart:convert';

final String sessionUser = "belahDurenUserSession";
final String sessionBranch = "belahDurenBranchSession";
final String sessionAddress = "belahDurenAddressSession";
final String sessionPoints = "belahDurenPointsSession";

storeSession() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(sessionUser, json.encode(currentUser.toJson()));
}

pointsSession() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(sessionPoints, json.encode(currentPoints.toJson()));
}

storeBranchSession() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(sessionBranch, json.encode(selectedBranch.toJson()));
}

storeAddressSession() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(sessionAddress, json.encode(selectedAddress.toJson()));
}

destroySession() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
}

Future loadSession() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String userSession = _get_data(prefs, sessionUser);
  String branchSession = _get_data(prefs, sessionBranch);
  String addressSession = _get_data(prefs, sessionAddress);
  String pointsSession = _get_data(prefs, sessionPoints);
  if(userSession != null){
    currentUser = User.fromJson(json.decode(userSession));
  }
  if(branchSession != null){
    selectedBranch = Items.fromJson(json.decode(branchSession));
  }
  if(addressSession != null){
    selectedAddress = Address.fromJson(json.decode(addressSession));
  }
  if(pointsSession != null){
    currentPoints = MemberPoints.fromJson(json.decode(pointsSession));
  }
}

_get_data(SharedPreferences prefs, key){
  return prefs.containsKey(key) ? prefs.getString(key) : null;
}