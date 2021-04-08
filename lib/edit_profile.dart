import 'dart:io';

import 'package:belah_duren/api/branch.dart';
import 'package:belah_duren/api/profile.dart';
import 'package:belah_duren/model/district_branch.dart';
import 'package:belah_duren/model/user.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'api/profile.dart';
import 'global/variable.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final format = DateFormat("yyyy-MM-dd");
  List<DistrictBranch> districts = [];
  String districtName;
  int selectedIndex = 0;

  final ImagePicker _picker = ImagePicker();


  Future getImage() async {
    final image = await ImagePicker.pickImage(source: ImageSource.camera);

  }

  final phoneNumberController = TextEditingController();
  final genderController = TextEditingController();
  final birthDateController = TextEditingController();
  final addressController = TextEditingController();
  final districtIdController = TextEditingController();
  final districtNameController = TextEditingController();

  String dropdownValue = 'Laki-laki';
  DateTime _dateTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureApiEditProfile(currentUser.token).then((value) {
      if(value.isSuccess()){
        phoneNumberController.text = value.data.phone_number.toString();
        birthDateController.text = value.data.birth_date;
        addressController.text = value.data.address.toString();
        districtIdController.text = value.data.district_id.toString();
        print(value.data.address);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.brown),
        title: Text(
          "Edit Profile",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.brown[700]),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   "Nama",
              //   style: TextStyle(
              //       color: Colors.brown[700],
              //       fontSize: 14,
              //       fontWeight: FontWeight.bold),
              // ),
              // SizedBox(
              //   height: 12,
              // ),
              // TextFormField(
              //   style: TextStyle(fontSize: 14, color: Colors.brown[700]),
              //   decoration: InputDecoration(
              //     fillColor: Colors.white,
              //     hoverColor: Colors.white,
              //     filled: true,
              //     contentPadding: EdgeInsets.only(left: 16),
              //     enabledBorder: OutlineInputBorder(
              //         borderSide: BorderSide(color: Colors.grey[400], width: 3),
              //         borderRadius: BorderRadius.circular(8.0)),
              //     focusedBorder: OutlineInputBorder(
              //         borderSide: BorderSide(color: Colors.grey[400], width: 3),
              //         borderRadius: BorderRadius.circular(8.0)),
              //     hintText: "Nama Anda",
              //     hintStyle: TextStyle(color: Colors.grey[400]),
              //   ),
              // ),
              // SizedBox(
              //   height: 16,
              // ),
              // Text(
              //   "Email",
              //   style: TextStyle(
              //       color: Colors.brown[700],
              //       fontSize: 14,
              //       fontWeight: FontWeight.bold),
              // ),
              // SizedBox(
              //   height: 12,
              // ),
              // TextFormField(
              //   keyboardType: TextInputType.emailAddress,
              //   style: TextStyle(fontSize: 14, color: Colors.brown[700]),
              //   decoration: InputDecoration(
              //     fillColor: Colors.white,
              //     hoverColor: Colors.white,
              //     filled: true,
              //     contentPadding: EdgeInsets.only(left: 16),
              //     enabledBorder: OutlineInputBorder(
              //         borderSide: BorderSide(color: Colors.grey[400], width: 3),
              //         borderRadius: BorderRadius.circular(8.0)),
              //     focusedBorder: OutlineInputBorder(
              //         borderSide: BorderSide(color: Colors.grey[400], width: 3),
              //         borderRadius: BorderRadius.circular(8.0)),
              //     hintText: "Email Anda",
              //     hintStyle: TextStyle(color: Colors.grey[400]),
              //   ),
              // ),
              // SizedBox(
              //   height: 16,
              // ),

              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50.0,
                      backgroundImage:
                      currentImage == null && currentProfile.photo == "" ?
                      AssetImage(
                          "assets/images/smile.png",):
                      FileImage(File(currentImage.path)),
                    ),
                    Positioned(
                      bottom: 15.0,
                      right: 10,
                      child: InkWell(
                        onTap: (){
                          showModalBottomSheet(context: context, builder: ((builder) => _bottomSheetImage(context)));
                        },
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.brown[700],
                          size: 30,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Text(
                "Nomor HP",
                style: TextStyle(
                    color: Colors.brown[700],
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: phoneNumberController,
                keyboardType: TextInputType.number,
                style: TextStyle(fontSize: 14, color: Colors.brown[700]),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  hoverColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.only(left: 16),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400], width: 3),
                      borderRadius: BorderRadius.circular(8.0)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400], width: 3),
                      borderRadius: BorderRadius.circular(8.0)),
                  hintText: "No. HP Anda",
                  hintStyle: TextStyle(color: Colors.grey[400]),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                height: 1,
                color: Colors.brown[100],
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "Jenis Kelamin",
                style: TextStyle(
                    color: Colors.brown[700],
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 12,
              ),
              DropdownButton<String>(
                isDense: true,
                isExpanded: true,
                value: dropdownValue,
                icon: Icon(Icons.keyboard_arrow_down_rounded),
                iconSize: 30,
                elevation: 16,
                style: TextStyle(color: Colors.brown[700]),
                underline: Container(
                  height: 1,
                  color: Colors.grey[500],
                ),
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue = newValue;
                  });
                },
                items: <String>['Laki-laki', 'Perempuan']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "Tanggal Lahir",
                style: TextStyle(
                    color: Colors.brown[700],
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 12,
              ),
              Column(children: <Widget>[
                //Text('Pilih Tanggal lahir (${format.pattern})'),
                DateTimeField(
                  controller: birthDateController,
                  style: TextStyle(color: Colors.brown[700]),
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    hoverColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.only(left: 16),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey[400], width: 3),
                        borderRadius: BorderRadius.circular(8.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey[400], width: 3),
                        borderRadius: BorderRadius.circular(8.0)),
                    hintText: "Tanggal Lahir Anda",
                    hintStyle: TextStyle(color: Colors.grey[400]),
                  ),
                  format: format,
                  onShowPicker: (context, currentValue) {
                    return showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                  },
                ),
              ]),
              SizedBox(
                height: 16,
              ),Text(
                "Kota",
                style: TextStyle(
                    color: Colors.brown[700],
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 16,
              ),
              FutureBuilder(
                  future: futureApiListBranches(currentUser.token),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      ApiListBranch branch = snapshot.data;
                      if (branch.isSuccess()) {
                        districts = branch.data;
                      }
                    }
                    return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200],
                          boxShadow: [
                            BoxShadow(color: Colors.grey[200], spreadRadius: 3),
                          ],
                        ),
                      padding: EdgeInsets.only(left: 16, top: 8, right: 8, bottom: 8),
                      child: DropdownButton(
                          isDense: true,
                          isExpanded: true,
                          value: districtName,
                          hint: Text("Pilih Kota"),
                          onChanged: (newValue){
                            setState(() {
                              districtName = newValue;
                            });
                          },
                          items: districts.map((e) {
                        return DropdownMenuItem(
                            value: e.name,
                            onTap: (){
                              setState(() {
                                selectedIndex = e.id;
                              });
                            },
                            child: Text(e.name.toString()));
                      }).toList()),
                    );
                  }),
              SizedBox(
                height: 16,
              ),
              Text(
                "Alamat",
                style: TextStyle(
                    color: Colors.brown[700],
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: addressController,
                style: TextStyle(fontSize: 14, color: Colors.brown[700]),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  hoverColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.only(left: 16),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400], width: 3),
                      borderRadius: BorderRadius.circular(8.0)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400], width: 3),
                      borderRadius: BorderRadius.circular(8.0)),
                  hintText: "Alamat Anda",
                  hintStyle: TextStyle(color: Colors.grey[400]),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                height: 1,
                color: Colors.brown[100],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Icon(
                    Icons.lock_outlined,
                    color: Colors.red[800],
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Ganti PIN",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.red[800]),
                  )
                ],
              ),
              SizedBox(
                height: 16,
              ),
              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.yellow[600])),
                  onPressed: () {
                    if(currentImage == null){
                      alertDialog(context, "Photo", "Photo belum dipilih");
                    }
                    else{
                      showCircular(context);
                      //currentUser = User(null, email, name, token)
                      int jk;
                      if (dropdownValue == "Laki-laki") {
                        jk = 1;
                      } else {
                        jk = 2;
                      }
                      futureApiUpdateProfile(
                          currentUser.token,
                          phoneNumberController.text,
                          jk,
                          birthDateController.text,
                          addressController.text,
                          selectedIndex,
                          districtName,
                          currentImage.path)
                          .then((value) {
                        print(value.message);
                        if (value.isSuccess()) {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        } else {
                          print(value.message);
                          print("gagal");
                        }
                      });
                    }
                  },
                  color: Colors.yellow[600],
                  textColor: Colors.black,
                  child: Text("Simpan",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottomSheetImage(BuildContext context){
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Text("Pilih Foto Profil",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
            ),),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FlatButton.icon(
                onPressed: (){
                  takePhoto(ImageSource.camera);
                },
                icon: Icon(Icons.camera),
                label: Text("Camera"),),
              FlatButton.icon(
                onPressed: (){
                  takePhoto(ImageSource.gallery);
                },
                icon: Icon(Icons.image),
                label: Text("Gallery"),),
            ],
          )
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);
    setState(() {
      currentImage = pickedFile;
    });
  }

}
