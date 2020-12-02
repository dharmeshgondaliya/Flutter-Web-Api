import 'dart:collection';
import 'dart:convert';

import 'package:FlutterWebApi/home_screen.dart';
import 'package:FlutterWebApi/register_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

class login_screen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => Login();
}

class Login extends State<login_screen>{
  final formkey = GlobalKey<FormState>();
  var mobilecontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  String mobiletext,passwordtext;

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
        padding: EdgeInsets.only(left: 35,right: 35,top: 100,bottom: 100),
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(left: 10,right: 10,top: 25),
            child: Form(key: formkey,
            child: Column(children: <Widget>[
              SizedBox(height: 15,),
              Text("Login",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),textAlign: TextAlign.center),
              SizedBox(height: 25,),
              TextFormField(
                controller: mobilecontroller,
                validator: (value){
                  if(value.trim().isEmpty){
                    Toast.show('Enter Mobile Number', context,duration: Toast.LENGTH_LONG,gravity: Toast.BOTTOM);
                    return 'Enter Mobile Number';
                  }
                  if(value.trim().toString().length != 10){
                    Toast.show('Enter Mobile Number 10 digit', context,duration: Toast.LENGTH_LONG,gravity: Toast.BOTTOM);
                    return 'Enter Mobile Number 10 digit';
                  }
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Enter Mobile Number',
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
                child:Text('Login',style: TextStyle(fontSize: 18,),),
                onPressed: (){
                  if(formkey.currentState.validate()){
                    DataOperation();                   
                  }                  
               },
                color: Colors.blueAccent,
                textColor: Colors.white,
                ),)],),
                SizedBox(height: 10,),
                InkWell(child: Text("Signup",style: TextStyle(color: Colors.blueAccent, fontSize: 18,fontStyle: FontStyle.italic),textAlign: TextAlign.center,),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => register_screen()));
                },)
            ],),)
          )
        ),
      ),
    );
  }

  DataOperation() async {
    
    mobiletext = mobilecontroller.text.trim().toString();
    passwordtext = passwordcontroller.text.trim().toString();
    
      var url = "http://10.0.3.2/webexa/login.php";
      var response = await http.post(url,body:{
        'mobile': mobiletext,
        'password': passwordtext
      });
      var result = json.decode(response.body);
      
      if(result[0]['login'] == "success"){
        mobilecontroller.text = "";
        passwordcontroller.text = "";
        Navigator.push(context, MaterialPageRoute(builder: (context) => home_screen()));
      } 
      else{
        Toast.show("Something is Wrong", context,duration: Toast.LENGTH_LONG);
      }           

    

  }

}