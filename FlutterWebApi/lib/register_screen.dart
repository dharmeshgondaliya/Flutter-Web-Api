import 'dart:convert';

import 'package:FlutterWebApi/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

class register_screen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => Register();
}

class Register extends State<register_screen>{
  final formkey = GlobalKey<FormState>();
  var mobilecontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var namecontroller = TextEditingController();
  String nametext,mobiletext,passwordtext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [new Color(0xffFFA7A7),new Color(0xffBFA7FF)],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft
          )
        ),
        child: LoginBox(),
      ),
    );
  }

  Widget LoginBox(){
    return Center(
      child: Padding(
        padding: EdgeInsets.only(left: 35,right: 35,top: 75,bottom: 75),
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(left: 10,right: 10,top: 25),
            child: Form(key: formkey,
            child: Column(children: <Widget>[
              SizedBox(height: 10,),
              Text("Register",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),textAlign: TextAlign.center),
              SizedBox(height: 20,),
              TextFormField(
                controller: namecontroller,
                validator: (value){
                  if(value.trim().isEmpty){
                    Toast.show('Enter Name', context,duration: Toast.LENGTH_LONG,gravity: Toast.BOTTOM);
                    return 'Enter Your Name';
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Enter Name'
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: mobilecontroller,
                validator: (value){
                  if(value.trim().isEmpty){
                    Toast.show('Enter Email', context,duration: Toast.LENGTH_LONG,gravity: Toast.BOTTOM);
                    return 'Enter Email';
                  }
                  if(value.trim().toString().length != 10){
                    Toast.show('Enter Mobile Number', context,duration: Toast.LENGTH_LONG,gravity: Toast.BOTTOM);
                    return 'Enter Mobile Number';
                  }
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Enter Mobile Number'
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: passwordcontroller,
                validator: (value){
                  if(value.trim().isEmpty){
                    Toast.show('Enter Password', context,duration: Toast.LENGTH_LONG,gravity: Toast.BOTTOM);
                    return 'Enter Password';
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Enter Password'
                ),
              ),
              SizedBox(height: 15,),
              Row(children: <Widget>[Expanded(child: RaisedButton(
                child:Text('Register',style: TextStyle(fontSize: 18,),),
                onPressed: (){
                  if(formkey.currentState.validate()){
                    DataOperation();                   
                  }
                },
                color: Colors.blueAccent,
                textColor: Colors.white,
                ),)],),
                SizedBox(height: 10,),
                InkWell(child: Text("Login",style: TextStyle(color: Colors.blueAccent, fontSize: 18,fontStyle: FontStyle.italic),textAlign: TextAlign.center,),
                onTap: (){
                  Navigator.pop(context);
                },)
            ],),)
          )
        ),
      ),
    );
  }

  DataOperation() async {

    nametext = namecontroller.text.trim().toString();
    mobiletext = mobilecontroller.text.trim().toString();
    passwordtext = passwordcontroller.text.trim().toString();
    
    var url = "http://10.0.3.2/webexa/register.php";
    var response = await http.post(url,body:{
      'name': nametext,
      'mobile': mobiletext,
      'password': passwordtext
    });
    var result = json.decode(response.body);
    if(result[0]['register'] ==  "success"){
      namecontroller.text = "";
      mobilecontroller.text = "";
      passwordcontroller.text = "";
      Navigator.push(context, MaterialPageRoute(builder: (context)=>home_screen()));
    }else{
      Toast.show("Something is Wrong", context,duration: Toast.LENGTH_LONG);
    }
  }

}