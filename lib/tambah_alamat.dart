import 'package:flutter/material.dart';

class TambahAlamat extends StatefulWidget {
  @override
  _TambahAlamatState createState() => _TambahAlamatState();
}

class _TambahAlamatState extends State<TambahAlamat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.brown),
        title: Text(
          "Tambah Alamat",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.brown[700]),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 200,
                color: Colors.brown,
              ),
              SizedBox(
                height: 16,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: Text(
                    "Kota Atau Kecamatan",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown[700]),
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: TextFormField(
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
                    hintText: "Kota/Kecamatan Anda",
                    hintStyle: TextStyle(color: Colors.grey[400]),
                  ),
                ),
              ),SizedBox(
                height: 16,
              ),Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: Text(
                    "Kode Pos",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown[700]),
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: TextFormField(
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
                    hintText: "Kode Pos Anda",
                    hintStyle: TextStyle(color: Colors.grey[400]),
                  ),
                ),
              ),SizedBox(
                height: 16,
              ),Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: Text(
                    "Alamat",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown[700]),
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: TextFormField(
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
              ),SizedBox(
                height: 16,
              ),Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: Text(
                    "Label Alamat",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown[700]),
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: TextFormField(
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
                    hintText: "Label Alamat Anda",
                    hintStyle: TextStyle(color: Colors.grey[400]),
                  ),
                ),
              ),SizedBox(
                height: 16,
              ),Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: Text(
                    "Nama Penerima",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown[700]),
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: TextFormField(
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
                    hintText: "Nama Penerima Anda",
                    hintStyle: TextStyle(color: Colors.grey[400]),
                  ),
                ),
              ),SizedBox(
                height: 16,
              ),Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: Text(
                    "Nomor Hp",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown[700]),
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: TextFormField(
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
                    hintText: "Nomor Hp Anda",
                    hintStyle: TextStyle(color: Colors.grey[400]),
                  ),
                ),
              ),SizedBox(
                height: 16,
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: Colors.yellow[600])),
                    onPressed: () {
                    },
                    color: Colors.yellow[600],
                    textColor: Colors.black,
                    child: Text("Simpan",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
