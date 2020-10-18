import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:message_app/chatting/data/firebase_send_retrive_data.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ReadScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      // ignore: missing_return
      builder: (context,sizingInformation){
        if(sizingInformation.isMobile){
          return ReadChatPage(sizingInformation : sizingInformation,);
        }
      }
    );
  }
}


class ReadChatPage extends StatefulWidget {
  final SizingInformation sizingInformation;
  const ReadChatPage({Key key, this.sizingInformation}) : super(key: key);
  @override
   ReadChatPageState createState() =>  ReadChatPageState();
}

class  ReadChatPageState extends State <ReadChatPage> {
 


  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          readtext(context),
        ],
      ),
    );
  }
}



Widget readtext(context){
  return Scaffold(
    backgroundColor: const Color(0xff002033),
    resizeToAvoidBottomPadding:false,
    resizeToAvoidBottomInset: true,
    body:StreamBuilder(
      stream: retriveMessage(),
      builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
   if(!snapshot.hasData){
     return Center(
       child: CircularProgressIndicator( )
       );
   }
   return CustomScrollView(
     slivers: [
       SliverAppBar(
         expandedHeight: 200,
         centerTitle: true,
         backgroundColor: Colors.transparent,
         flexibleSpace: FlexibleSpaceBar(
           title: Text(
             "   Read Messages",
             style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          fontFamily:"Pacifico"
                          ),
             ),
             background:Hero(tag: 'dash',child: Image.asset("assets/read.gif",fit: BoxFit.cover,)),
            
         ),
       ),
       SliverFillRemaining(
         child: Padding(
    padding: const EdgeInsets.symmetric(horizontal:10.0),
    child: Container(
     height: 700,
     child: Stack(
            children: [
              Container(
             decoration: BoxDecoration(
             color: Colors.black,
             border: Border.all(color: Colors.deepOrange[400],width: 2),
              borderRadius: BorderRadius.only(
                topLeft:Radius.circular(40),
                topRight:Radius.circular(40)
                ),
              ),
              child: ListWheelScrollView(
                renderChildrenOutsideViewport:false,
                itemExtent: 220, 
                diameterRatio: 4,
                squeeze: 0.85,
                // ignore: deprecated_member_use
             children:snapshot.data.documents.map((document){
               return Padding(
                 padding: const EdgeInsets.all(15.0),
                 child: Container(
                  decoration: BoxDecoration(
                    gradient:LinearGradient(
                      begin: AlignmentDirectional.topStart,
                      end: AlignmentDirectional.bottomEnd,
                     // stops: [0.09,0.6,5],
                      colors: [
                        Colors.blueGrey[900],Colors.cyan[900],Colors.blueGrey[900]
                      ]
                      ),
                      border: Border.all(),
                      borderRadius: BorderRadius.all(Radius.circular(30))
                  ),
                    child: Center(
                     child:Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: AutoSizeText(
                           document['message'],
                           textAlign: TextAlign.center,
                       style: TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                              fontWeight: FontWeight.w500,
                              fontFamily:"Montserrat"
                              ),
                         ),
                     )
                   ),
                 ),
               );
             }).toList(),
                )
       ),
       Positioned(
         bottom: 0,
         left: 20,
          child: Container(
           width: 350,
           height:2,
           color: Colors.black,
           ),
       )
            ],
     ),
   ),
         ),
       )
     ],
   );
  }
   )
  );
}