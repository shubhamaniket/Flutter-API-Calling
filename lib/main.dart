import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map data;
  List userData;
  Future<String> getData() async{
    var response = await http.get(Uri.encodeFull('https://reqres.in/api/users?page=2'),
    headers: {
      "Accept" : "application/json"
    });
    data = json.decode(response.body);
    setState(() {
      userData = data["data"];
    });
  }
  @override
  void initState() {
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    if(userData == null){
      return Scaffold(
        body: Container(
          color: Colors.white,
          child: Center(
        child: CircularProgressIndicator(),
      ),
        ),
      );
    }
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (BuildContext context,int index){
          return ListTile(
            leading: CircleAvatar(backgroundImage: NetworkImage(userData[index]['avatar']),radius: 30.0,),
            title: Text(userData[index]["first_name"]+" "+userData[index]["last_name"]),
            subtitle: Text(userData[index]["email"]),
            trailing: Icon(Icons.edit),
          );
        },
        itemCount: userData == null ? 0 : userData.length,
      )
    );
  }
}