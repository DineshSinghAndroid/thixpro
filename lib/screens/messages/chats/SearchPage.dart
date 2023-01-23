import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';
import '../../videocall/call.dart';
import '../model/ChatRoomModel.dart';
import '../model/UserModel.dart';
import 'ChatRoomPage.dart';

class SearchPage extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;

  const SearchPage({
    Key? key,
    required this.userModel,
    required this.firebaseUser,
  }) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  Future<ChatRoomModel?> getChatroomModel(UserModel targetUser) async {
    ChatRoomModel? chatRoom;
    logger.i("USER UID IS " + widget.userModel.uid.toString());
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("chatrooms")
        .where("participants.${widget.userModel.uid}", isEqualTo: true)
        .where("participants.${targetUser.uid}", isEqualTo: true)
        .get();

    if (snapshot.docs.length > 0) {
      // Fetch the existing one
      var docData = snapshot.docs[0].data();
      ChatRoomModel existingChatroom =
          ChatRoomModel.fromMap(docData as Map<String, dynamic>);

      chatRoom = existingChatroom;
    } else {
      // Create a new one
      ChatRoomModel newChatroom = ChatRoomModel(
        chatroomid: uuid.v1(),
        lastMessage: "",
        participants: {
          widget.userModel.uid.toString(): true,
          targetUser.uid.toString(): true,
        },
      );

      await FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(newChatroom.chatroomid)
          .set(newChatroom.toMap());

      chatRoom = newChatroom;

      log("New Chatroom Created!");
    }

    return chatRoom;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Column(
            children: [
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  labelText: "Email Address",
                ),
              ),
              SizedBox(
                height: 20,
              ),
              CupertinoButton(
                onPressed: () {
                  setState(() {});
                },
                color: Theme.of(context).colorScheme.secondary,
                child: Text("Search"),
              ),
              SizedBox(
                height: 20,
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .where("email", isEqualTo: searchController.text)
                      .where("email", isNotEqualTo: widget.userModel.email)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.hasData) {
                        QuerySnapshot dataSnapshot =
                            snapshot.data as QuerySnapshot;

                        if (dataSnapshot.docs.length > 0) {
                          Map<String, dynamic> userMap = dataSnapshot.docs[0]
                              .data() as Map<String, dynamic>;
                          UserModel searchedUser = UserModel.fromMap(userMap);

                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            margin: EdgeInsets.only(bottom: 20),
                            // height: _w / 4,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(20),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 40,
                                  spreadRadius: 10,
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  backgroundImage:
                                      AssetImage('assets/images/adv.jpg'),
                                  // child: Image.asset('assets/images/adv.jpg'),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                        alignment:
                                            AlignmentDirectional.topStart,
                                        child: Text(
                                          searchedUser.fullname.toString(),
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700),
                                        )),
                                    Text("GST"),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 30,
                                          // width: 60,
                                          decoration: const BoxDecoration(
                                              color: Colors.amber,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(50))),
                                          child: FittedBox(
                                            child: MaterialButton(
                                              onPressed: () {},
                                              child: Row(
                                                children: [
                                                  const Icon(Icons.call),
                                                  const Text("Call")
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          height: 30,
                                          // width: 60,
                                          decoration: const BoxDecoration(
                                              color: Colors.amber,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(50))),
                                          child: FittedBox(
                                            child: MaterialButton(
                                              onPressed: () async {
                                                ChatRoomModel? chatroomModel =
                                                    await getChatroomModel(
                                                        searchedUser);

                                                if (chatroomModel != null) {
                                                  Navigator.pop(context);
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                          builder: (context) {
                                                    return ChatRoomPage(
                                                      targetUser: searchedUser,
                                                      userModel:
                                                          widget.userModel,
                                                      firebaseUser:
                                                          widget.firebaseUser,
                                                      chatroom: chatroomModel,
                                                    );
                                                  }));
                                                }
                                              },
                                              child: Row(
                                                children: [
                                                  const Icon(Icons.message),
                                                  const Text("Chat")
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          height: 30,
                                          // width: 60,
                                          decoration: const BoxDecoration(
                                              color: Colors.amber,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(50))),
                                          child: FittedBox(
                                            child: MaterialButton(
                                              onPressed: () async {
                                                ChatRoomModel? chatroomModel =
                                                    await getChatroomModel(
                                                        searchedUser);

                                                if (chatroomModel != null) {
                                                  Navigator.pop(context);
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                      return VCallScreen(
                                                          userModel:
                                                              widget.userModel,
                                                          firebaseUser: widget
                                                              .firebaseUser,
                                                          callID: widget
                                                              .userModel.uid
                                                              .toString());

                                                      // return ChatRoomPage(targetUser: searchedUser, userModel: widget.userModel,
                                                      //   firebaseUser: widget.firebaseUser, chatroom: chatroomModel,);
                                                    }),
                                                  );
                                                  logger.i(
                                                      "Searched user name is ${searchedUser.fullname} and uid is ${searchedUser.uid}");
                                                }
                                              },
                                              child: Row(
                                                children: [
                                                  const Icon(Icons.video_call),
                                                  const Text("Video Call")
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Text("No results found!");
                        }
                      } else if (snapshot.hasError) {
                        return Text("An error occured!");
                      } else {
                        return Text("No results found!");
                      }
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
