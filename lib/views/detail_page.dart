import 'package:flutter/material.dart';
import 'package:testing_api_app/models/data.dart';

class DetailPage extends StatefulWidget {
  late Data data;
  DetailPage({Key? key, required this.data, detailPage}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Page"),
        backgroundColor: Colors.greenAccent,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Image.network(
                  widget.data.url,
                  height: 250.0,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: CircleAvatar(
                          child: Text(widget.data.id.toString()),
                        ),
                      ),
                      SizedBox(
                        width: 7.0,
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(widget.data.title),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
