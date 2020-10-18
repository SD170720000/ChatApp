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

    resizeToAvoidBottomPadding:false,
    resizeToAvoidBottomInset: true,
    body:StreamBuilder(
      stream: retriveMessage(),
      builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
   if(!snapshot.hasData){
     return Center(
       child: CircularProgressIndicator()
       );
   }
   return ListView(
     // ignore: deprecated_member_use
     children:snapshot.data.documents.map((document){
       return Center(
         child:Container(
           width:MediaQuery.of(context).size.width / 1.2,
           height:MediaQuery.of(context).size.height / 6,
           child: Text(
             document['message']
           ),
         )
       );
     }).toList(),
   );
  }
   )
  );
}