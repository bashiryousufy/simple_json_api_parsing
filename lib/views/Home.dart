import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testing_api_app/models/data.dart';
import 'package:testing_api_app/views/detail_page.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future getAllData() async {
    String api = "https://jsonplaceholder.typicode.com/photos";
    var data = await http.get(Uri.parse(api));
    var jsonData = jsonDecode(data.body);
    List<Data> listOfData = [];
    for (var i in jsonData) {
      Data data = new Data(
          albumId: i['albumId'],
          id: i['id'],
          title: i['title'],
          url: i['url'],
          thumbnailUrl: i['thumbnailUrl']);
      listOfData.add(data);
    }

    return listOfData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Json parsing App"),
        backgroundColor: Colors.blue,
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
            ),
          ),
          IconButton(
            onPressed: () {
              getAllData();
            },
            icon: Icon(
              Icons.add,
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Bashiryousufy"),
              accountEmail: Text("Bashiryousufy@gmail.com"),
              decoration: BoxDecoration(color: Colors.blueAccent),
            ),
            ListTile(
              leading: Icon(
                Icons.search,
                color: Colors.blue,
              ),
              title: Text("Page 1"),
              onTap: () => Navigator.of(context).pop(),
            ),
            ListTile(
              leading: Icon(
                Icons.search,
                color: Colors.blue,
              ),
              title: Text("Page 2"),
              onTap: () => Navigator.of(context).pop(),
            ),
            ListTile(
              leading: Icon(
                Icons.search,
                color: Colors.blue,
              ),
              title: Text("Page 3"),
              onTap: () => Navigator.of(context).pop(),
            )
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10.0),
            height: 250.0,
            child: FutureBuilder(
              future: getAllData(),
              builder: (BuildContext buildContext, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Center(
                    child: CircularProgressIndicator(
                      semanticsLabel: "Loading",
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext buildcontext, int index) {
                      return Card(
                        elevation: 10.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Image.network(
                              snapshot.data[index].url,
                              height: 150.0,
                              width: 150.0,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(
                              height: 7.0,
                            ),
                            Container(
                              margin: EdgeInsets.all(6.0),
                              height: 50.0,
                              child: Row(
                                children: [
                                  Container(
                                    child: CircleAvatar(
                                      child: Text(
                                          snapshot.data[index].id.toString()),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 6.0,
                                  ),
                                  Container(
                                    width: 80.0,
                                    child: Text(
                                      snapshot.data[index].title,
                                      maxLines: 1,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          SizedBox(
            height: 7.0,
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            height: MediaQuery.of(context).size.height,
            child: FutureBuilder(
              future: getAllData(),
              builder: (BuildContext c, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext c, int index) {
                      return Card(
                        elevation: 7.0,
                        child: Container(
                          height: 80.0,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Image.network(
                                  snapshot.data[index].url,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                width: 6.0,
                              ),
                              Expanded(
                                flex: 2,
                                child: InkWell(
                                  child: Text(
                                    snapshot.data[index].title,
                                    maxLines: 2,
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                  onTap: () {
                                    Navigator.of(context).push(
                                        new MaterialPageRoute(
                                            builder: (BuildContext c) =>
                                                DetailPage(
                                                  data: snapshot.data[index],
                                                )));
                                  },
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: CircleAvatar(
                                    child: Text(
                                        snapshot.data[index].id.toString()),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
