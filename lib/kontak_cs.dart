import 'package:flutter/material.dart';

class KontakCS extends StatefulWidget {
  @override
  _KontakCSState createState() => _KontakCSState();
}

class _KontakCSState extends State<KontakCS> {
  String dropdownValue = 'Subjek';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.brown),
        title: Text(
          "Kontak CS",
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
            children: [
              Container(
                padding: EdgeInsets.only(left: 16, top: 8, right: 8, bottom: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200],
                  boxShadow: [
                    BoxShadow(color: Colors.grey[200], spreadRadius: 3),
                  ],
                ),
                child: DropdownButton<String>(
                  isDense: true,
                  isExpanded: true,
                  value: dropdownValue,
                  icon: Icon(Icons.keyboard_arrow_down_rounded),
                  iconSize: 30,
                  elevation: 16,
                  style: TextStyle(color: Colors.black54),
                  underline: Container(
                    height: 1,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
                  items: <String>['Subjek', 'Text']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),SizedBox(
                height: 24,
              ),Container(
                padding: EdgeInsets.only(left: 16, top: 8, right: 8, bottom: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200],
                  boxShadow: [
                    BoxShadow(color: Colors.grey[200], spreadRadius: 3),
                  ],
                ),
                child: DropdownButton<String>(
                  isDense: true,
                  isExpanded: true,
                  value: dropdownValue,
                  icon: Icon(Icons.keyboard_arrow_down_rounded),
                  iconSize: 30,
                  elevation: 16,
                  style: TextStyle(color: Colors.black54),
                  underline: Container(
                    height: 1,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
                  items: <String>['Subjek', 'Text']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),SizedBox(
                height: 24,
              ),Container(
                height: 1,
                color: Colors.grey[300],
              ),SizedBox(
                height: 24,
              ),Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Email",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black38),
                  textAlign: TextAlign.start,
                ),
              ),SizedBox(
                height: 16,
              ),TextFormField(
                style: TextStyle(fontSize: 14, color: Colors.brown[700]),
                decoration: InputDecoration(
                  fillColor: Colors.grey[200],
                  hoverColor: Colors.grey[200],
                  filled: true,
                  contentPadding: EdgeInsets.only(left: 16),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400], width: 3,style: BorderStyle.none),
                      borderRadius: BorderRadius.circular(8.0)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400], width: 3, style: BorderStyle.none),
                      borderRadius: BorderRadius.circular(8.0)),
                  hintText: "Alamat Email",
                  hintStyle: TextStyle(color: Colors.grey[400]),
                ),
              ),SizedBox(
                height: 16,
              ),TextFormField(
                maxLength: 200,
                maxLines: 8,
                textAlign: TextAlign.start,
                scrollPadding: EdgeInsets.all(8),
                style: TextStyle(fontSize: 14, color: Colors.brown[700]),
                decoration: InputDecoration(
                  fillColor: Colors.grey[200],
                  hoverColor: Colors.grey[200],
                  filled: true,
                  contentPadding: EdgeInsets.only(left: 16,top: 16, right: 16),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400], width: 3,style: BorderStyle.none),
                      borderRadius: BorderRadius.circular(8.0)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400], width: 3, style: BorderStyle.none),
                      borderRadius: BorderRadius.circular(8.0)),
                  hintText: "Pesan",
                  hintStyle: TextStyle(color: Colors.grey[400]),
                ),
              ),SizedBox(
                height: 16,
              ),Container(
                height: 1,
                color: Colors.grey[400],
              ),SizedBox(
                height: 24,
              ),Row(
                children: [
                  Icon(Icons.drive_folder_upload, size: 40, color: Colors.red[700],),
                  SizedBox(
                    width: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Upload file",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.red[700]),
                      ),Text(
                        "Maksimal 5mb (hanya file jpg, png, dan pdf)",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black26),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
