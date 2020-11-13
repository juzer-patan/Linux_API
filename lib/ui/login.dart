import 'dart:ui';
import 'package:docker_app/main.dart';
import 'package:docker_app/sub.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  String ip;
  LoginPage(this.ip);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
    TextEditingController usernameController = new TextEditingController();
    TextEditingController passwdController = new TextEditingController();
    bool isVisible = true;
    String resp;
    bool isLoading = false;
    web() async {
    if(usernameController.text.isNotEmpty && passwdController.text.isNotEmpty){
          setState(() {
            isLoading = true;
          });
          var pwd = passwdController.text;
          var user = usernameController.text;
          //var cmd='date';
         // var 
          var url = "http://192.168.43.73/cgi-bin/docker_image.py?cmd=date&password=${pwd}&username=${user}&ip=${widget.ip}";

          var response = await http.get(url);
      //    cmdController.clear();
          setState(() {
            
            resp = response.body;
          });
            print(widget.ip);
          print(response.body);
          if(resp.contains('Permission denied')){
            setState(() {
              isLoading = false;
            });
            Fluttertoast.showToast(
                      msg: "Invalid Credentials!",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.SNACKBAR,
                      timeInSecForIosWeb: 3,
                      backgroundColor: Colors.black45,
                      textColor: Colors.white,
                      fontSize: 18.0
                  );
          }
          else{
            setState(() {
              isLoading = false;
            });
            Navigator.push(context, MaterialPageRoute(builder: (context)=> CmdLine(user,pwd,widget.ip)));
          }
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
    //  appBar: AppBar(
        
     // ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: new BoxDecoration(
            //  color: Colors.grey,
              image: new DecorationImage(
                image: NetworkImage(
                  'https://raw.githubusercontent.com/juzer-patan/asset/master/linux.jpg'
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: new BackdropFilter(
              filter: new ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
              child: new Container(
                decoration: new BoxDecoration(color: Colors.grey.withOpacity(0.0)),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white70.withOpacity(0.5),
            ),
            child: SingleChildScrollView(
                          child: Container(
                            height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                      'https://pngimage.net/wp-content/uploads/2018/05/aa-logo-png-1.png'))),
                        ),
                    Text(
                      'AndrInux',
                      style: GoogleFonts.calligraffitti(
                        fontSize: 55,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87
                      ),

                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: TextField(
                        style: TextStyle(fontWeight: FontWeight.w600),
                        controller: usernameController,
                        decoration: InputDecoration(
                                            /*  prefixIcon: Icon(
                                                Icons.account_circle,
                                                size: 30,
                                                color: Colors.amber.shade300,
                                              ),*/
                                              filled: true,
                                              focusColor: Colors.brown,
                                              labelStyle: GoogleFonts.cairo(fontSize: 18),
                                              labelText: "Username",
                                              fillColor: Colors.white54,
                                              //fillColor: Colors.blue[50],
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.blue,
                                                      style: BorderStyle.solid),
                                                  borderRadius: BorderRadius.circular(30)),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.black),
                                                  borderRadius: BorderRadius.circular(30))),
                                        ),
                                        
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: TextField(
                          style: TextStyle(fontWeight: FontWeight.w600),
                          controller: passwdController,
                          obscureText: isVisible,
                          
                          decoration: InputDecoration(
                                              /*  prefixIcon: Icon(
                                                  Icons.account_circle,
                                                  size: 30,
                                                  color: Colors.amber.shade300,
                                                ),*/
                                                suffixIcon: IconButton(
                                                  icon: isVisible ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                                                  iconSize: 30,
                                                  onPressed: (){
                                                    setState(() {
                                                      isVisible = !isVisible;
                                                    });
                                                  },
                                                ),
                                                filled: true,
                                                focusColor: Colors.brown,
                                                labelStyle: GoogleFonts.cairo(fontSize: 18),
                                                labelText: "Password",
                                                fillColor: Colors.white54,
                                                //fillColor: Colors.blue[50],
                                                focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.amber,
                                                        style: BorderStyle.solid),
                                                    borderRadius: BorderRadius.circular(30)),
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(color: Colors.black),
                                                    borderRadius: BorderRadius.circular(30))),
                                          ),
                                          
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child:/* Container(
                                        padding: EdgeInsets.symmetric(vertical: 10),
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black87,
                                                  blurRadius: 3.0,
                                                  offset: Offset.fromDirection(150)
                                                  //  spreadRadius: 5.0
                                                  )
                                            ],
                                            borderRadius: BorderRadius.circular(30),
                                            color: Colors.amber.shade300
                                            ),
                                        width: MediaQuery.of(context).size.width * 0.4,
                                        child: Text(
                                          'SIGN UP',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),*/
                                    
                      isLoading ? 
                      Center(
                        child: CircularProgressIndicator(
                          
                        ),
                      ) : 
                      Material(
                          animationDuration: Duration(seconds: 2),
                          color: Colors.amber.shade300,
                         // color: const Color(0xff2A75BC),
                          type: MaterialType.button,
                          shadowColor: Colors.white,
                          elevation: 10,
                          borderRadius: BorderRadius.circular(15),
                          child: MaterialButton(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                "Login",
                                style: TextStyle(
                                 // color: Colors.black54,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            onPressed: () {
                              print("something");
                              web();
                            },
                          ),
                        ),
                    )
                    
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}