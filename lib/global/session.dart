import 'package:belah_duren/login.dart';
import 'package:belah_duren/model/address.dart';
import 'package:belah_duren/model/member_poins.dart';
import 'package:belah_duren/model/profile.dart';
import 'package:belah_duren/model/user.dart';
import 'package:belah_duren/model/branch.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'variable.dart';
import 'dart:convert';

final String sessionUser = "belahDurenUserSession";
final String sessionBranch = "belahDurenBranchSession";
final String sessionAddress = "belahDurenAddressSession";
final String sessionPoints = "belahDurenPointsSession";
final String sessionProfile = "belahDurenProfileSession";
final String sessionRegistrationToken = "belahDurenRegistrationTokenSession";

storeSession() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(sessionUser, json.encode(currentUser.toJson()));
}

pointsSession() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(sessionPoints, json.encode(currentPoints.toJson()));
}

profileSession() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(sessionProfile, json.encode(currentProfile.toJson()));
}

storeBranchSession() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(sessionBranch, json.encode(selectedBranch.toJson()));
}

storeAddressSession() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(sessionAddress, json.encode(selectedAddress.toJson()));
}

storeRegistrationTokenSession() async {
  if(userRegistrationToken == null) return;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(sessionRegistrationToken, userRegistrationToken);
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
  String profileSession = _get_data(prefs, sessionProfile);
  userRegistrationToken = _get_data(prefs, sessionRegistrationToken);
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
  if(profileSession != null){
    currentProfile = Profile.fromJson(json.decode(profileSession));
  }
}

_get_data(SharedPreferences prefs, key){
  return prefs.containsKey(key) ? prefs.getString(key) : null;
}

isValidToken(context, message){
  if (message.toLowerCase() == "token not valid/authorized") {
    currentUser = null;
    destroySession();
    // alertDialog(context, "Session", "Session Expired");
    // startNewPage(context, Login());
  }
}