import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:message_app/chatting/data/firebase_send_retrive_data.dart';
import 'package:message_app/chatting/presentation/ReadChatPage.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
        // ignore: missing_return
        builder: (context, sizingInformation) {
      if (sizingInformation.isMobile) {
        return HomePage(
          sizingInformation: sizingInformation,
        );
      }
    });
  }
}

class HomePage extends StatefulWidget {
  final SizingInformation sizingInformation;
  const HomePage({Key key, this.sizingInformation}) : super(key: key);
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          dashboard(context),
        ],
      ),
    );
  }
}

final _controller = TextEditingController();
String text = "";

clearTextInput() {
  _controller.clear();
}

GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

Widget dashboard(context) {
  return Scaffold(
    key: _scaffoldkey,
    backgroundColor: Colors.orange[800],
    resizeToAvoidBottomPadding: false,
    resizeToAvoidBottomInset: true,
    body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(0),
            child: Container(
              height: 680,
              child: PageView(
                controller: PageController(viewportFraction: 0.89),
                scrollDirection: Axis.horizontal,
                pageSnapping: true,
                children: <Widget>[
                  Stack(
                    children: [
                      Flexible(
                        flex: 2,
                        child: Container(
                          height: 660,
                          child: Card(
                            margin:
                                EdgeInsets.only(right: 7, bottom: 0, top: 10),
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Image.asset(
                              "assets/send.gif",
                              fit: BoxFit.cover,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)),
                            elevation: 10,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 30,
                        left: 10,
                        width: 275,
                        height: 60,
                        child: TextField(
                          scrollPadding: EdgeInsets.only(),
                          decoration: InputDecoration(
                            fillColor: Colors.black,
                            filled: true,
                            hintText: "Send Message",
                            hintStyle: TextStyle(
                                color: Colors.white60,
                                fontFamily: "Montserrat"),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.cyan[700], width: 3.0),
                                borderRadius: BorderRadius.circular(50.0)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.cyan[700], width: 3.0),
                                borderRadius: BorderRadius.circular(50.0)),
                          ),
                          style: TextStyle(
                              color: Colors.white,
                              height: 1.5,
                              fontFamily: "Montserrat"),
                          autocorrect: true,
                          keyboardType: TextInputType.text,
                          autofocus: false,
                          controller: _controller,
                        ),
                      ),
                      Positioned(
                        width: 45,
                        height: 45,
                        right: 16,
                        bottom: 37,
                        child: RaisedButton(
                            padding: EdgeInsets.only(),
                            child: Icon(
                              Icons.near_me,
                              size: 30,
                            ),
                            //padding: EdgeInsets.only(),

                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                side: BorderSide(
                                    color: Colors.deepOrange, width: 2)),
                            color: Colors.cyan[900],
                            splashColor: Colors.black54,
                            onPressed: () async {
                              text = _controller.text;
                              await Firebase.initializeApp();

                              if (text != "") {
                                _scaffoldkey.currentState.showSnackBar(SnackBar(
                                  elevation: 0,
                                  content: Row(
                                    children: [
                                      Container(
                                          height: 15,
                                          width: 15,
                                          child: CircularProgressIndicator(
                                            valueColor: AlwaysStoppedAnimation<
                                                    Color>(
                                                Colors.lightGreenAccent[400]),
                                            strokeWidth: 1,
                                          )),
                                      SizedBox(
                                        width: 50,
                                      ),
                                      TypewriterAnimatedTextKit(
                                        text: ["Sending message . . . . . ."],
                                        textAlign: TextAlign.center,
                                        speed: Duration(milliseconds: 30),
                                        repeatForever: false,
                                        textStyle: TextStyle(
                                            color: Colors.white60,
                                            fontWeight: FontWeight.w900,
                                            fontFamily: "Montserrat",
                                            fontSize: 15),
                                      ),
                                      Icon(
                                        Icons.send,
                                        color: Colors.orangeAccent[400],
                                      )
                                    ],
                                  ),
                                  duration: Duration(seconds: 1),
                                  backgroundColor: Colors.black,
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      side: BorderSide(
                                          color: Colors.cyan[900], width: 5)),
                                ));
                                sendMessage(text);
                              } else {
                                _scaffoldkey.currentState.showSnackBar(SnackBar(
                                  content: Row(
                                    children: [
                                      SizedBox(width: 17),
                                      Icon(
                                        Icons.error_outline,
                                        color: Colors.red,
                                      ),
                                      SizedBox(width: 17),
                                      Text(
                                        "Empty message can't be send",
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontFamily: "Montserrat",
                                            fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  elevation: 0,
                                  duration: Duration(seconds: 1),
                                  backgroundColor: Colors.black,
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      side: BorderSide(
                                          color: Colors.cyan[900], width: 5)),
                                ));
                              }

                              clearTextInput();
                            }),
                      ),
                      Positioned(
                        top: 50,
                        left: 10,
                        child: Container(
                          width: 325,
                          child: Center(
                            child: Text(
                              "Send Message ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Pacifico"),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Container(
                        height: 660,
                        child: InkWell(
                          onTap: () async {
                            await Firebase.initializeApp();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ReadChatPage()),
                            );
                          },
                          splashColor: Colors.black12,
                          child: Card(
                            margin:
                                EdgeInsets.only(left: 7, bottom: 0, top: 10),
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Hero(
                                tag: 'dash',
                                child: Image.asset(
                                  "assets/read.gif",
                                  fit: BoxFit.cover,
                                )),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)),
                            elevation: 10,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 50,
                        left: 11,
                        child: Container(
                          width: 335,
                          child: Center(
                            child: Text(
                              "Read Message ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Pacifico"),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 30,
                        left: 40,
                        width: 280,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40))),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Center(
                            child: Text(
                              "Click Card to Retrive",
                              style: TextStyle(
                                  color: Colors.orange[700],
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Pacifico"),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
