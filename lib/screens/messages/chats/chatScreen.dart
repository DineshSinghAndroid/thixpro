// import 'package:Thixpro/screens/common/login.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
//
// import '../../profile.dart';
// import '../model/ChatRoomModel.dart';
// import '../model/FirebaseHelper.dart';
// import '../model/UserModel.dart';
// import 'ChatRoomPage.dart';
// import 'SearchPage.dart';
// import 'package:Thixpro/screens/user/VendorProfile.dart';
// import 'package:Thixpro/widgets/add_text.dart';
// import 'package:Thixpro/widgets/sementions.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
//
// class ChatScreen extends StatefulWidget {
//   final UserModel userModel;
//   final User firebaseUser;
//
//   const ChatScreen(
//       {Key? key, required this.userModel, required this.firebaseUser})
//       : super(key: key);
//
//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<ChatScreen> {
//   @override
//   Widget build(BuildContext context) {
//     double _w = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.amber,
//         title: Text("Messages"),
//         leading: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//           child: GestureDetector(
//             onTap: () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => ProfilePage(),
//                   ));
//             },
//             child: Container(
//               height: 20,
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.all(Radius.circular(50)),
//                   image: DecorationImage(
//                     image: AssetImage('assets/images/adv.jpg'),
//                   )),
//             ),
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(context, MaterialPageRoute(builder: (context) {
//             return SearchPage(
//                 userModel: widget.userModel, firebaseUser: widget.firebaseUser);
//           }));
//         },
//         child: Icon(Icons.search),
//       ),
//     );
//   }
// }
