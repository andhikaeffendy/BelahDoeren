import 'package:flutter/material.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tentang Belah Doeren", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.brown[700]),),
        backgroundColor: Colors.yellow[700],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                    image: DecorationImage(
                        image: AssetImage("assets/images/slide_utama_home.png"),
                        fit: BoxFit.fill)),
                height: 200,
              ),SizedBox(
                height: 16,
              ),Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: 14, color: Colors.brown[700]),
                    children: <TextSpan>[
                      TextSpan(text: "Belah Doeren", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.brown[700])),
                      TextSpan(text: " adalah durian specialist dari Bandung yang menghadirkan"
                          " berbagai macam menu olahan durian terbaik. Kami terus berinovasi untuk memenuhi "
                          "keinginan para pecinta durian terhadap olahan durian berkualitas.\n\n",
                          style: TextStyle(color: Colors.brown[700])
                          ),
                      TextSpan(text: "Berdiri di Bandung sejak Maret 2013, kami mengawali usaha dengan berbagai"
                          " macam menu dessert durian seperti Pancake Durian, durio ice cream, durian sauce vanilla, "
                          "durian sauce matcha, durian madness, durian goreng, durian bakar, durian crumble, dan menu lainnya.\n\n",
                          style: TextStyle(color: Colors.brown[700])),
                      TextSpan(text: "Hingga akhirnya di tahun 2015, atas permintaan para pelanggan setia dan kecintaan kami"
                          " terhadap durian, kami mulai membuat berbagai macam menu patisseries. Selain classic soes yang sudah "
                          "ada sejak pertama kali berdiri, kami berinovasi membuat chewy soes, brownies durian (bakar),"
                          " buttercake durian, mille crepe durian, dan nastar durian.  Produk patisseries kami banyak dijadikan"
                          " oleh-oleh durian baru dari Bandung.\n\n",
                          style: TextStyle(color: Colors.brown[700], fontFamily: "Latto")),
                      TextSpan(text: "Belah Doeren", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.brown[700])),
                      TextSpan(text: " merupakan Dessert & Patisserie yang menyajikan berbagai macam olahan "
                          "Durian dengan kualitas Grade A. Di sini kamu bisa menemukan produk-produk patisserie khas Belah "
                          "Doeren seperti Durian Chewy Soes, Durian Pancake, Durian Brownies, sampai Durian Buttercake. "
                          "Tersedia juga berbagai macam dessert berbahan Durian seperti Durian Sauce Vanilla, Durian Sauce Matcha,"
                          " sampai Durio Ice Cream, es krim Durian original dari Belah Doeren.\n\n",
                          style: TextStyle(color: Colors.brown[700], fontFamily: "Latto")),
                      TextSpan(text: "Produk Belah Doeren telah tersertifikasi halal dan terbukti telah memiliki rating dan review yang baik dari customer.",
                          style: TextStyle(color: Colors.brown[700]))
                    ]
                  ),
                ),
              ),SizedBox(
                height: 16,
              )
            ],
          ),
        ),
      ),
    );
  }
}
