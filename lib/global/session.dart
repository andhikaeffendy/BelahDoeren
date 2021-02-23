import 'package:belah_duren/model/address.dart';
import 'package:belah_duren/model/user.dart';
import 'package:belah_duren/model/branch.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'variable.dart';
import 'dart:convert';

final String sessionUser = "belahDurenUserSession";
final String sessionBranch = "belahDurenBranchSession";
final String sessionAddress = "belahDurenAddressSession";

storeSession() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(sessionUser, json.encode(currentUser.toJson()));
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
  if(userSession != null){
    currentUser = User.fromJson(json.decode(userSession));
  }
  if(branchSession != null){
    selectedBranch = Items.fromJson(json.decode(branchSession));
  }
  if(addressSession != null){
    selectedAddress = Address.fromJson(json.decode(addressSession));
  }
}

_get_data(SharedPreferences prefs, key){
  return prefs.containsKey(key) ? prefs.getString(key) : null;
}