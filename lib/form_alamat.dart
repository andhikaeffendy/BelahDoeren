import 'dart:async';
import 'package:belah_duren/api/address.dart';
import 'package:belah_duren/global/variable.dart';
import 'package:belah_duren/model/address.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FormAlamat extends StatefulWidget {
  final bool editForm;
  final Address currentAddress;
  FormAlamat(this.editForm, this.currentAddress);

  @override
  _FormAlamatState createState() => _FormAlamatState();
}

class _FormAlamatState extends State<FormAlamat> {
  TextEditingController tecName = TextEditingController();
  TextEditingController tecAddress = TextEditingController();
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};
  double mLat;
  double mLong;

  _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  void initState() {

    setState(() {
      if (ConnectionState.waiting == true) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (widget.editForm) {
        mLat = double.parse(widget.currentAddress.lat);
        mLong = double.parse(widget.currentAddress.long);
        tecName.text = widget.currentAddress.name;
        tecAddress.text = widget.currentAddress.address;
      } else {
        mLong = currentPosition.longitude;
        mLat = currentPosition.latitude;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(mLat);
    print(mLong);
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
                height: 300,
                child: Stack(
                  children: [
                    GoogleMap(
                      onMapCreated: _onMapCreated,
                      myLocationButtonEnabled: true,
                      myLocationEnabled: true,
                      markers: widget.editForm == false
                          ? _markers
                          : [
                              Marker(
                                  markerId: MarkerId('1'),
                                  position: LatLng(mLat, mLong),
                                  infoWindow: InfoWindow(
                                      title: 'Drag and hold this to location!'),
                                  icon: BitmapDescriptor.defaultMarkerWithHue(
                                    BitmapDescriptor.hueRed,
                                  ),
                                  draggable: true,
                                  onDragEnd: ((newPosition) {
                                    print(newPosition.latitude);
                                    print(newPosition.longitude);
                                    mLat = newPosition.latitude;
                                    mLong = newPosition.longitude;
                                  })),
                            ].toSet(),
                      gestureRecognizers:
                          <Factory<OneSequenceGestureRecognizer>>[
                        new Factory<OneSequenceGestureRecognizer>(
                          () => new EagerGestureRecognizer(),
                        ),
                      ].toSet(),
                      mapType: MapType.terrain,
                      initialCameraPosition:
                          CameraPosition(target: LatLng(mLat, mLong), zoom: 18),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    // mLat = currentPosition.latitude;
                    // mLong = currentPosition.longitude;

                    mLat = currentPosition.latitude;
                    mLong = currentPosition.longitude;
                    _markers.add(Marker(
                        markerId: MarkerId('1'),
                        position: LatLng(mLat, mLong),
                        infoWindow:
                            InfoWindow(title: 'Tahan dan geser untuk mengubah'),
                        icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueRed,
                        ),
                        draggable: true,
                        onDragEnd: ((newPosition) {
                          print(newPosition.latitude);
                          print(newPosition.longitude);
                          mLat = newPosition.latitude;
                          mLong = newPosition.longitude;
                        })));
                  });
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: Colors.lightGreen[700],
                      size: 30,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Gunakan Lokasi Saat Ini",
                      style: TextStyle(
                          color: Colors.lightGreen[700], fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Align(
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
                  controller: tecAddress,
                  style: TextStyle(fontSize: 14, color: Colors.brown[700]),
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
                    hintText: "Alamat Anda",
                    hintStyle: TextStyle(color: Colors.grey[400]),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Align(
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
                  controller: tecName,
                  style: TextStyle(fontSize: 14, color: Colors.brown[700]),
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
                    hintText: "Nama Penerima Anda",
                    hintStyle: TextStyle(color: Colors.grey[400]),
                  ),
                ),
              ),
              SizedBox(
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
                      showCircular(context);
                      if (widget.editForm) {
                        futureApiUpdateAlamat(
                                currentUser.token,
                                widget.currentAddress.id,
                                tecName.text,
                                tecAddress.text,
                                mLat.toString(),
                                mLong.toString())
                            .then((value) async {
                          Navigator.of(context, rootNavigator: true).pop();
                          if (value.isSuccess()) {
                            await alertDialog(
                                context, "Alamat", "Berhasil Update Alamat");
                            Navigator.pop(context);
                          } else {
                            await alertDialog(context, "Alamat", value.message);
                          }
                        });
                      } else {
                        futureApiTambahAlamat(
                                currentUser.token,
                                tecName.text,
                                tecAddress.text,
                                mLat.toString(),
                                mLong.toString())
                            .then((value) async {
                          Navigator.of(context, rootNavigator: true).pop();
                          if (value.isSuccess()) {
                            await alertDialog(
                                context, "Alamat", "Berhasil Menambah Alamat");
                            Navigator.pop(context);
                          } else {
                            await alertDialog(context, "Alamat", value.message);
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
