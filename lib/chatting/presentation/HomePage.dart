import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:message_app/chatting/data/firebase_send_retrive_data.dart';
import 'package:message_app/chatting/presentation/ReadChatPage.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      // ignore: missing_return
      builder: (context,sizingInformation){
        if(sizingInformation.isMobile){
          return HomePage(sizingInformation : sizingInformation,);
        }
      }
    );
  }
}


class HomePage extends StatefulWidget {
  final SizingInformation sizingInformation;
  const HomePage({Key key, this.sizingInformation}) : super(key: key);
  @override
   HomePageState createState() =>  HomePageState();
}

class  HomePageState extends State <HomePage> {
 


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

clearTextInput(){
  _controller.clear();
}

Widget dashboard(context){
  return Scaffold(

    resizeToAvoidBottomPadding:false,
    resizeToAvoidBottomInset: true,
    body: SingleChildScrollView(

      child: Column(
        children: <Widget>[
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.all(0),
            child: Container(
              height: 730,
              child: PageView(
                controller: PageController(viewportFraction: 0.89),
                scrollDirection: Axis.horizontal,
                pageSnapping: true,
                children: <Widget>[
                  Stack(
                    children: [
                      Container(
                        height: 710,
                        child: Card(
                          margin: EdgeInsets.only(right:7,bottom:0,top: 10),
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Image.network("https://mir-s3-cdn-cf.behance.net/project_modules/disp/9c7a2773609829.5c0f6e269e920.gif",fit: BoxFit.cover,),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40)
                            ),
                            elevation: 10,
                        ),
                      ),
                      
                 Positioned(
                   bottom:30,
                   left: 10,
                   width: 270,
                   height: 60,
                        child: TextField(
                          
                          scrollPadding: EdgeInsets.only(),
                       decoration: InputDecoration(
                         fillColor: Colors.black,
                         filled: true,
                         hintText: "Send Message",
                         hintStyle: TextStyle(
                             color: Colors.white60,
                             fontFamily: "Montserrat"
                         ),
                         enabledBorder: OutlineInputBorder(
                             borderSide:  BorderSide(color:Colors.lightGreenAccent[400],width: 3.0),
                             borderRadius: BorderRadius.circular(50.0)
                         ),
                         focusedBorder: OutlineInputBorder(
                             borderSide: BorderSide(color: Colors.green,width: 3.0),
                             borderRadius: BorderRadius.circular(50.0)
                         ),
                       ),
                       
                       style: TextStyle(
                           color: Colors.white,
                           height: 1.5,
                           fontFamily: "Montserrat"
                       ),
                       autocorrect: true,
                       keyboardType: TextInputType.text,
                      
                       controller: _controller,
                      
                     ),
                 ),
              
                 Positioned(
                   width: 45,
                   height: 45,
                   right: 16,
                  bottom:37,
                  
                    child: RaisedButton(
                      padding: EdgeInsets.only(),
                     child:Icon(Icons.near_me,size: 30,),
                     //padding: EdgeInsets.only(),
                     
                     shape: RoundedRectangleBorder(

                          borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                      
                    color: Colors.lightGreenAccent[400],
                     splashColor: Colors.black54,
                     onPressed: () async {
                       text = _controller.text;
                       await Firebase.initializeApp();
                       sendMessage(text);
                       clearTextInput();
                     }
                     ),
                 ),
                 Positioned(
                   top: 50,
                   left: 45,
                            child: Text("Send Message ",
                            style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.w500,
                            fontFamily:"Pacifico"
                            ),
                           ),
                 ),
                    ],
                  ),
                  Stack(
                    children: [
                      Container(
                        height: 710,
                        child: InkWell(
                          onTap: () async {
                            print("$text");
                            await Firebase.initializeApp();
                            Navigator.push(context,
                                    MaterialPageRoute(builder: (context)=>ReadChatPage()),
                                  );
                          },
                          splashColor: Colors.black12,
                            child: Card(
                            margin: EdgeInsets.only(left:7,bottom:0,top: 10),
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Image.network("https://i.pinimg.com/originals/9d/23/6d/9d236dc22e9f8e83235b170b51f0080c.gif",fit: BoxFit.cover,),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)
                              ),
                              elevation: 10,
                          ),
                        ),
                      ),
                      
                
                 Positioned(
                   top: 50,
                   left: 50,
                            child: Text("Read Message ",
                            style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.w500,
                            fontFamily:"Pacifico"
                            ),
                           ),
                 ),
                 Positioned(
                   top: 150,
                   left: 20,
                            child: Column(
                              children: [
                                Text(
                                  "Textfield text Output  :",
                                  style: TextStyle(
                                      color: Colors.orange[700],
                                      fontWeight: FontWeight.w500,
                                      fontFamily:"Montserrat"
                                      ),
                                ),
                                Container(
                                  width: 315,
                                  child: Card(
                                    elevation: 0,
                                    color: Colors.black45,
                                     //margin: EdgeInsets.only(left:20,bottom:0,top: 10),
                                    shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)
                                  ),
                                   child: Padding(
                                     padding: EdgeInsets.symmetric(horizontal:29.0,vertical:10),
                                     child: Text(text,
                                      style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500,
                                      fontFamily:"Montserrat"
                                      ),
                           ),
                                   ),
                                  ),
                                ),
                              ],
                            ),
                 ),
                 Positioned(
                   bottom: 30,
                   left: 16,
                            child: Card(
                              elevation: 0,
                              color: Colors.black45,
                               //margin: EdgeInsets.only(left:20,bottom:0,top: 10),
                              shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)
                            ),
                             child: Padding(
                               padding: const EdgeInsets.symmetric(horizontal:40.0),
                               child: Center(
                                 child: Text("Click Card to Retrive",
                                  style: TextStyle(
                                  color: Colors.orange[700],
                                  fontSize: 26,
                                  fontWeight: FontWeight.w500,
                                  fontFamily:"Pacifico"
                                  ),
                           ),
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