import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nazarih_mobile/services/firebase_storage.dart';
import 'package:nazarih_mobile/screens/ViewProfileScreen.dart';

class ChatRoom extends StatefulWidget {
  final String chatRoomId, phoneNo;

  ChatRoom({@required this.chatRoomId, @required this.phoneNo});

  @override
  _ChatRoomState createState() =>
      _ChatRoomState(chatRoomId: chatRoomId, phoneNo: phoneNo);
}

addConversationMessages(String chatRoomId, messageMap) {
  FirebaseFirestore.instance
      .collection('ChatRoom')
      .doc(chatRoomId)
      .collection('chats')
      .add(messageMap);
}

getChatRoom(String chatRoomId) {
  return FirebaseFirestore.instance
      .collection('ChatRoom')
      .doc(chatRoomId)
      .snapshots();
}

getConversationMessages(String chatRoomId) {
  return FirebaseFirestore.instance
      .collection('ChatRoom')
      .doc(chatRoomId)
      .collection('chats')
      .orderBy('time')
      .snapshots();
}

class _ChatRoomState extends State<ChatRoom> {
  String chatRoomId, phoneNo;

  _ChatRoomState({@required this.chatRoomId, @required this.phoneNo});

  TextEditingController messageController = new TextEditingController();
  Stream chatMessagesStream;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<DocumentSnapshot> loadMyInfo(String phoneNumber) {
    return _firestore.collection('users').doc(phoneNumber).snapshots();
  }

  Widget chatMessagesList() {
    return StreamBuilder(
      stream: chatMessagesStream,
      builder: (context, snapshot) {
        return (snapshot.hasData)
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return MessageTile(
                      snapshot.data.docs[index]["message"],
                      snapshot.data.docs[index]["sendBy"] == phoneNo,
                      snapshot.data.docs[index]["name"]);
                },
              )
            : Container();
      },
    );
  }

  sendMessage() async {
    if (messageController.text.isNotEmpty) {
      String username;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(phoneNo)
          .get()
          .then((DocumentSnapshot documentSnapshot) => {
                username = documentSnapshot.data()['Name'],
              });
      Map<String, dynamic> messageMap = {
        "message": messageController.text,
        "sendBy": phoneNo,
        "time": DateTime.now().microsecondsSinceEpoch,
        'name': username
      };
      addConversationMessages(chatRoomId, messageMap);
      messageController.text = '';
      scolldown();
      String tempPhoneNumber =
          chatRoomId.toString().replaceAll("_", "").replaceAll(phoneNo, "");
      await FirebaseFirestore.instance
          .collection('users')
          .doc(tempPhoneNumber)
          .collection('Notifications')
          .doc()
          .set({
        "message": "لقد تلقيت رسالة جديده من" + " " + username,
        'date': DateTime.now().microsecondsSinceEpoch,
        'type': 'message',
        'docId': chatRoomId
      });
    }
  }

  final ScrollController _scrollController = ScrollController();

  void scolldown() {
    Timer(
        Duration(seconds: 1),
        () => _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn));
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    Timer(
        Duration(seconds: 1),
        () => _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xFF2980b9),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 75,
        title: Image.asset(
          "assets/images/logo/logo_text.png",
          height: 50,
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF2980b9),
        actions: [
          IconButton(
              icon: Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 10),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 10,
                  blurRadius: 20)
            ],
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(40.0),
              topLeft: Radius.circular(40.0),
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 30, left: 20, right: 20),
              child: Column(
                children: [
                  StreamBuilder<DocumentSnapshot>(
                    stream: getChatRoom(chatRoomId),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        String phoneNumber = snapshot.data
                            .data()['chatRoomId']
                            .toString()
                            .replaceAll("_", "")
                            .replaceAll(phoneNo, "");
                        return StreamBuilder<DocumentSnapshot>(
                          stream: loadMyInfo(phoneNumber),
                          builder: (context, snapshot) {
                            String name = snapshot.data.data()['Name'];
                            String chatPhoneNumber =
                                snapshot.data.data()['Phone Number'];
                            String photoUrl = snapshot.data.data()['photo_url'];
                            return Container(
                              width: MediaQuery.of(context).size.width / 1.5,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ViewProfileScreen(
                                                    phoneNo: chatPhoneNumber,
                                                    myPhone: phoneNo)),
                                      );
                                    },
                                    child: StreamBuilder<String>(
                                      stream: downloadUrl(photoUrl).asStream(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting)
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        return Container(
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 4,
                                                  color: Colors.white),
                                              boxShadow: [
                                                BoxShadow(
                                                    spreadRadius: 2,
                                                    blurRadius: 10,
                                                    color: Colors.black
                                                        .withOpacity(0.1),
                                                    offset: Offset(0, 10))
                                              ],
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(snapshot
                                                      .data
                                                      .toString()))),
                                        );
                                      },
                                    ),
                                  ),
                                  Text("محادثة مع" + " " + name,
                                      style: TextStyle(
                                          fontFamily: 'Bahij',
                                          fontSize: 20,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            );
                          },
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 2,
                    decoration: BoxDecoration(
                        color: Color(0xFF2980b9),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.blue[100],
                              spreadRadius: 10,
                              blurRadius: 20)
                        ]),
                    child: Stack(
                      children: [
                        StreamBuilder<QuerySnapshot>(
                          stream: getConversationMessages(chatRoomId),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData ||
                                snapshot.data.docs.length == 0) {
                              return Center(
                                child: Text(
                                  "لاتوجد رسائل فالوقت الحالي",
                                  style: TextStyle(
                                      fontFamily: 'Bahij',
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              );
                            } else {
                              return ListView.builder(
                                controller: _scrollController,
                                itemCount: snapshot.data.docs.length,
                                itemBuilder: (context, index) {
                                  return MessageTile(
                                      snapshot.data.docs[index]["message"],
                                      snapshot.data.docs[index]["sendBy"] ==
                                          phoneNo,
                                      snapshot.data.docs[index]["name"]);
                                },
                              );
                            }
                          },
                        ),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              color: Color(0x54FFFFFF),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 16),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: TextField(
                                    controller: messageController,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontFamily: 'Bahij',
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                    decoration: InputDecoration(
                                        hintText: "الرسالة....",
                                        hintStyle: TextStyle(
                                            fontFamily: 'Bahij',
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                        border: InputBorder.none),
                                  )),
                                  GestureDetector(
                                    onTap: () {
                                      sendMessage();
                                    },
                                    child: Icon(
                                      Icons.send,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool isSendByME;
  final String sendBy;
  MessageTile(this.message, this.isSendByME, this.sendBy);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      width: MediaQuery.of(context).size.width,
      alignment: (isSendByME) ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: (isSendByME)
                    ? [const Color(0xffe84118), const Color(0xffc23616)]
                    : [const Color(0xff2f3640), const Color(0xff353b48)]),
            borderRadius: (isSendByME)
                ? BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomLeft: Radius.circular(23))
                : BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomRight: Radius.circular(23))),
        child: (isSendByME)
            ? Text(
                message,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(message,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "مرسله من" + " " + sendBy,
                    style: TextStyle(
                        color: Colors.amberAccent,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
      ),
    );
  }
}
