import 'package:belah_duren/api/settings.dart';
import 'package:belah_duren/global/variable.dart';
import 'package:belah_duren/model/faq_list.dart';
import 'package:flutter/material.dart';


class FAQ extends StatefulWidget {
  @override
  _FAQState createState() => _FAQState();
}

class _FAQState extends State<FAQ> {

  List<FaqList> listFaq = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.brown),
        title: Center(
          child: Text(
            "FAQ",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.brown[700]),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 16, right: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200]),
                child: Row(
                  children: [
                    Icon(
                      Icons.search_outlined,
                      color: Colors.grey[700],
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: "Search",
                              hintStyle: TextStyle(
                                color: Colors.grey[700],
                              ),
                              border: InputBorder.none),
                          style: TextStyle(color: Colors.black),
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: 24,
              ),
              FutureBuilder(
                  future: futureApiListFaq(""),
                  builder: (context, snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }else if(snapshot.connectionState == ConnectionState.done){
                      ApiFaq apiFaq = snapshot.data;
                      if(apiFaq.isSuccess()){
                        listFaq = apiFaq.data;
                        print(apiFaq);
                      }
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: listFaq.length,
                          itemBuilder: (context, index){
                            return ExpansionTile(
                              title: Text(
                                listFaq[index].question,
                                style: TextStyle(
                                    color: Colors.brown
                                ),
                              ),children: [
                              InkWell(
                                onTap: (){},
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    padding: EdgeInsets.all(16),
                                    child: Text(
                                      listFaq[index].answer,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                              )
                            ],);
                          });
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
