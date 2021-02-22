import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String dropdownValue = 'Laki-laki';
  DateTime _dateTime;

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
              Text(
                "Nama",
                style: TextStyle(
                    color: Colors.brown[700],
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 12,
              ),
              TextFormField(
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
                  hintText: "Nama Anda",
                  hintStyle: TextStyle(color: Colors.grey[400]),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "Email",
                style: TextStyle(
                    color: Colors.brown[700],
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 12,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
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
                  hintText: "Email Anda",
                  hintStyle: TextStyle(color: Colors.grey[400]),
                ),
              ),
              SizedBox(
                height: 16,
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
              BasicDateField(),
              SizedBox(
                height: 16,
              ),
              Text(
                "Kota",
                style: TextStyle(
                    color: Colors.brown[700],
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 12,
              ),
              TextFormField(
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
                  hintText: "Kota Tempat Tinggal Anda",
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
                  onPressed: () {},
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
}

class BasicDateField extends StatelessWidget {
  final format = DateFormat("yyyy-MM-dd");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      //Text('Pilih Tanggal lahir (${format.pattern})'),
      DateTimeField(
        style: TextStyle(color: Colors.brown[700]),
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
    ]);
  }
}
