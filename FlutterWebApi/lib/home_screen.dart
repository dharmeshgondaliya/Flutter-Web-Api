import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class home_screen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => Home();
}

class Home extends State<home_screen>{
  List users = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getUserList();
  }

  getUserList() async {
    var url = "http://10.0.3.2/webexa/list.php";
    var response = await http.post(url,body: {
      'get_user': 'true',
      'query': "select * from users"
    });
    var items = json.decode(response.body);
    setState(() {
      users = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User List'),),
      body: ListView.builder(itemCount: users.length ,itemBuilder: (context,index){
        return getlist(users[index]);
      },),
    );
  }

  Widget getlist(user){
    var name = user['name'];
    var mobile = user['mobile'];
    var image = "http://10.0.3.2/webexa/image/"+user['image'];
    return Card(
      child: ListTile(
        title: Text(name),
        subtitle: Text(mobile),
        leading: Container(width: 50,height: 50,decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(image),fit: BoxFit.cover)),
      ),
    ));
  }

}