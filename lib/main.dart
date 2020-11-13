//import 'package:docker_app/ui/home.dart';
import 'dart:ui';

import 'package:docker_app/ui/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'sub.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Front(),
  ));
}

class Front extends StatefulWidget {
  @override
  _FrontState createState() => _FrontState();
}

class _FrontState extends State<Front> {
  TextEditingController ipController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // resizeToAvoidBottomInset: ,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: new BoxDecoration(
              //  color: Colors.grey,
              image: new DecorationImage(
                image: NetworkImage(
                    'https://raw.githubusercontent.com/juzer-patan/asset/master/linux.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: new BackdropFilter(
              filter: new ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
              child: new Container(
                decoration:
                    new BoxDecoration(color: Colors.grey.withOpacity(0.0)),
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
                          color: Colors.black87),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: TextField(
                        style: TextStyle(fontWeight: FontWeight.w600),
                        controller: ipController,
                        decoration: InputDecoration(
                            /*  prefixIcon: Icon(
                                                Icons.account_circle,
                                                size: 30,
                                                color: Colors.amber.shade300,
                                              ),*/
                                              
                            filled: true,
                            hintStyle: TextStyle(color: Colors.amber),
                            focusColor: Colors.brown,
                            labelStyle: GoogleFonts.cairo(fontSize: 18),
                            labelText: "Enter IP Address",
                            fillColor: Colors.white54,
                            //fillColor: Colors.blue[50],
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue, style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(30)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(30))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child:
                          /* Container(
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
                              "Submit",
                              style: TextStyle(
                                // color: Colors.black54,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          onPressed: () {
                            if(ipController.text.isNotEmpty){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage(ipController.text)));}
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
/*
class Front extends StatefulWidget {
  @override
  _FrontState createState() => _FrontState();
}

class _FrontState extends State<Front> {
  TextEditingController cmdController = new TextEditingController();
  String cmd;
  var resp;
  List<Map> lst = [];
  web(cmd) async {
    var url = "http://192.168.43.73/cgi-bin/docker_image.py?cmd=${cmd}";
    var response = await http.get(url);
    cmdController.clear();
    setState(() {
      resp = response.body;
    });

    print(response.body);
    lst.add(
      {
        'cmd' : cmd,
        'op' : resp
      }
    );
  }

  commandList() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: lst.length,
      itemBuilder: (context,index){
        return Column(
          children: [
            Row(
                      children: [
                        Text(
                          '[root@localhost ~]',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          lst[index]['cmd'] ?? '',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        )
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 7),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        lst[index]['op'] ?? "Output loading....",
                        style: TextStyle(color: Colors.white,fontSize: 18),
                      ),
                    ),
          ],
      
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Colors.black,
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text('Test_draw'), backgroundColor: Colors.amber),
      drawer: Drawer(
        child: ListView(
          // padding: EdgeInsets.all(10),
          children: <Widget>[
            DrawerHeader(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.amber,
                //borderRadius: BorderRadius.circular(10)
              ),
              child: Text(
                'Drawer',
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
            ListTile(
              leading: Icon(Icons.file_download),
              title: Text('Pull Image'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyApp(),
                    ));
              },
            ),
            ListTile(
              leading: Icon(Icons.directions_run),
              title: Text('Run Container'),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                        'https://raw.githubusercontent.com/juzer-patan/asset/master/redimages.png')),
                              ),
          ),
          SingleChildScrollView(
                          child: Container(
                                        
                            color: Colors.transparent,
                            child: Column(
                  
               //   mainAxisSize: MainAxisSize.max,
                  children: [
                   commandList(),
                    
                        Row(
                            children: [
                              Text(
                                '[root@localhost ~]',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: TextField(
                                  controller: cmdController,
                                  style: TextStyle(color: Colors.white,fontSize: 18),
                                  onSubmitted: (val) {
                                    setState(() {
                                      //     list.add(Text(val));
                                      //     print(list);
                                      cmd = val;
                                      web(cmd);
                                    });
                                  },
                                  decoration: InputDecoration(
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white))),
                                ),
                              )
                            ],
                        ),
                    //    Text(
                    //      resp ?? "Output loading....",
                    //      style: TextStyle(color: Colors.white),
                    //    ),
                     
                  ],
                ),
                          ),
              ),
        ],
      ),
        
      
    );
  }
}*/
