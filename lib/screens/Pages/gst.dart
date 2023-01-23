import 'package:Thixpro/screens/user/VendorProfile.dart';
import 'package:Thixpro/widgets/add_text.dart';
import 'package:Thixpro/widgets/sementions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../messages/chats/SearchPage.dart';
import '../messages/model/UserModel.dart';

class GstScreen extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;
  GstScreen({Key? key, required this.userModel, required this.firebaseUser})
      : super(key: key);

  @override
  State<GstScreen> createState() => _GstScreenState();
}

class _GstScreenState extends State<GstScreen> {
  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(AddSize.padding10),
        child: AnimationLimiter(
          child: ListView.builder(
            padding: EdgeInsets.all(_w / 30),
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            itemCount: 20,
            itemBuilder: (BuildContext c, int i) {
              return AnimationConfiguration.staggeredList(
                position: i,
                delay: const Duration(milliseconds: 100),
                child: SlideAnimation(
                  duration: const Duration(milliseconds: 2500),
                  curve: Curves.fastLinearToSlowEaseIn,
                  horizontalOffset: 30,
                  verticalOffset: 300.0,
                  child: FlipAnimation(
                    duration: const Duration(milliseconds: 3000),
                    curve: Curves.fastLinearToSlowEaseIn,
                    flipAxis: FlipAxis.y,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VendorProfilePage()));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        margin: EdgeInsets.only(bottom: _w / 20),
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
                                    alignment: AlignmentDirectional.topStart,
                                    child: Text(
                                      widget.userModel.fullname.toString(),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                          onPressed: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return SearchPage(
                                                  userModel: widget.userModel,
                                                  firebaseUser:
                                                      widget.firebaseUser);
                                            }));
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
                                          onPressed: () {},
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
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
