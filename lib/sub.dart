import 'package:docker_app/main.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CmdLine extends StatefulWidget {
  String user;
  String pwd;
  String ip;
  CmdLine(this.user, this.pwd, this.ip);
  @override
  _CmdLineState createState() => _CmdLineState();
}

class _CmdLineState extends State<CmdLine> {
  TextEditingController cmdController = new TextEditingController();
  String cmd;
  var fsconnect = FirebaseFirestore.instance;
  Stream outstream;
  var resp;
  List<Map> lst = [];
  web(cmd) async {
    var url =
        "http://192.168.43.73/cgi-bin/docker_image.py?cmd=${cmd}&password=${widget.pwd}&username=${widget.user}&ip=${widget.ip}";
    var response = await http.get(url);
    cmdController.clear();
    setState(() {
      resp = response.body;
    });

    print(response.body);
    lst.add({'cmd': cmd, 'op': resp});
  }

  commandList() {
    return StreamBuilder(
      stream: outstream,
      builder:(context,snapshot) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: snapshot.data.docs.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Row(
              children: [
                Text(
                  '[root@localhost ~]',
                  style: TextStyle(
                    //   color: Colors.lightGreenAccent,
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  snapshot.data.docs[index].data()['cmd'] ?? '',
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
                snapshot.data.docs[index].data()['op'] ?? '',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        );
      },
    );});
  }
  @override
  void initState() {
    // TODO: implement initState
    getOutput();
    super.initState();
  }
  getOutput() async{
   await fsconnect.collections('linux').snapshots().then((snap){
     setState(() {
       outstream = snap;
     });
   });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Terminal'),
        backgroundColor: Colors.amber,
        leading: BackButton(
          onPressed: (){
             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Front()));
          }
        ),
      ),

      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      'https://mfiles.alphacoders.com/798/thumb-1920-798131.jpg'
                      //    'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRcrwzQ8-g6Tx2ECCbR28eudbQDwOXYlhvDsw&usqp=CAU'
                      //    'https://phoneky.co.uk/thumbs/wallpapers/p2/patterns/29/1acafb1712841711.jpg'
                      // 'https://desktopwallpaper.wiki/wp-content/uploads/data/2017/12/14/kali-linux-wallpaper-1920x1080-1080p-WTG200424441-1024x576.jpg'
                      // 'https://i.pinimg.com/564x/fd/d4/0f/fdd40f47eb87b36108f5ba58381db100.jpg'
                      // 'https://raw.githubusercontent.com/juzer-patan/asset/master/redimages.png'
                      )),
            ),
          ),
          SingleChildScrollView(
            dragStartBehavior: DragStartBehavior.down,
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
                          style: TextStyle(color: Colors.white, fontSize: 18),
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
}
