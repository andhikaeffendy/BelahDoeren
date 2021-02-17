import 'package:flutter/material.dart';

class CartAlamat extends StatefulWidget {
  @override
  _CartAlamatState createState() => _CartAlamatState();
}

class _CartAlamatState extends State<CartAlamat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.brown),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  "Pickup - 5 KM",
                  style: TextStyle(fontSize: 12, color: Colors.brown),
                ),
                Text(
                  "Bandung - PROGO",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown),
                ),
              ],
            ),
            Icon(
              Icons.arrow_downward_sharp,
              color: Colors.brown,
              size: 30,
            )
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Image.asset("assets/images/pickup.png",
                        width: MediaQuery.of(context).size.width / 2.2,
                        height: 100,
                        fit: BoxFit.cover),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Image.asset("assets/images/delivery.png",
                        width: MediaQuery.of(context).size.width / 2.2,
                        height: 100,
                        fit: BoxFit.cover),
                  )
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                "Bandung - PROGO",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown[700]),
              ),
              Column(
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 12,
                              ),
                              Container(
                                height: 1,
                                color: Colors.brown,
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      "https://i2.wp.com/belahdoeren.id/wp-content/uploads/2019/10/15.jpg?fit=886%2C886&ssl=1",
                                      width:
                                          MediaQuery.of(context).size.width / 5,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        width: 100,
                                        child: Text(
                                          "Pancake Durian Original",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: Colors.brown),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      Container(
                                        width: 100,
                                        child: Text(
                                          "Rp. 80.000",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: Colors.brown),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          IconButton(
                                              icon: Icon(
                                                Icons.remove,
                                                size: 30,
                                                color: Colors.brown,
                                              ),
                                              onPressed: () {}),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 4),
                                            color: Colors.grey[300],
                                            child: Text(
                                              '1',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          IconButton(
                                              icon: Icon(
                                                Icons.add,
                                                size: 30,
                                                color: Colors.brown,
                                              ),
                                              onPressed: () {}),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.sticky_note_2_outlined,
                                            size: 30,
                                            color: Colors.brown,
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            "Catatan",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.brown),
                                          )
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                ],
              ),
              SizedBox(
                height: 32,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(4),
                  padding: EdgeInsets.all(12), //Same as `blurRadius` i guess
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 4.0,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Payment Summary",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.brown,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Subtotal",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black26,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "155.000",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black26,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Delivery Fee",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black26,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "0",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black26,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Discount Member",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.green[900],
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "-25.000",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.green[900],
                                fontWeight: FontWeight.bold),
                          ),
                        ],
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.brown[700],
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "130.000",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.brown[700],
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
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
                  child: Text("Pilih Pembayaran",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
                ),
              ),SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
