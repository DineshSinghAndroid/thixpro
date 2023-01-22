import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:image_picker/image_picker.dart';
import '../../main.dart';
import '../../resources/app_theme.dart';
import '../../resources/new_helper.dart';
import '../../widgets/add_text.dart';
import '../../widgets/common_button.dart';
import '../../widgets/sementions.dart';
import '../../widgets/toast.dart';
import '../messages/model/UIHelper.dart';
import '../messages/model/UserModel.dart';
import 'CompleteProfile.dart';
import 'login.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();
  RxList<DropDownValues> dropDownValues = <DropDownValues>[
    DropDownValues(title: "Gst", slug: "gst"),
    DropDownValues(title: "Corporate", slug: "corporate"),
    DropDownValues(title: "Tax", slug: "tax"),
    DropDownValues(title: "ITR", slug: "itr"),
  ].obs;
  void checkValues() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email == "" || password == "") {
      Fluttertoast.showToast(
        msg: "Please fill all details",
        backgroundColor: Colors.red,
      );
    } else {
      signUp(email, password);
      Fluttertoast.showToast(
        msg: "Registration Successful",
        backgroundColor: Colors.green,
      );
    }
  }

  void signUp(String email, String password) async {
    UserCredential? credential;

    UIHelper.showLoadingDialog(context, "Creating new account..");

    try {
      credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (ex) {
      Navigator.pop(context);

      UIHelper.showAlertDialog(
          context, "An error occured", ex.message.toString());
    }

    if (credential != null) {
      String uid = credential.user!.uid;
      UserModel newUser =
          UserModel(uid: uid, email: email, fullname: "", profilepic: "");
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .set(newUser.toMap())
          .then((value) {
        print("New User Created!");
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) {
            return CompleteProfile(
                userModel: newUser, firebaseUser: credential!.user!);
          }),
        );
      });
    }
  }

  RxString currentSelectedDocument = "".obs;

  final Rx<File> _image = File("").obs;

  showPickImageSheet() {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text(
          'Select Image',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: AppTheme.primaryColor),
        ),
        // message: const Text('Message'),
        cancelButton: CupertinoActionSheetAction(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop("Cancel");
          },
        ),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            child: const Text('Gallery'),
            onPressed: () async {
              Get.back();
              final item = await NewHelper().addFilePicker();
              if (item != null) {
                _image.value = item;
              }
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Camera'),
            onPressed: () async {
              Get.back();
              final item = await NewHelper().addImagePicker(
                  imageSource: ImageSource.camera, imageQuality: 50);
              if (item != null) {
                _image.value = item;
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 400,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/login.jpg'),
                        fit: BoxFit.cover)),
              ),
              // Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    // Container(
                    //   padding: EdgeInsets.symmetric(horizontal: 20),
                    //   width: MediaQuery.of(context).size.width,
                    //   height: 55,
                    //   decoration: BoxDecoration(
                    //       color: Colors.purple.withOpacity(0.1),
                    //       borderRadius: BorderRadius.all(Radius.circular(30))),
                    //   child: TextFormField(
                    //     decoration: InputDecoration(
                    //         hintText: "Full Name",
                    //         hintStyle: TextStyle(color: Colors.black),
                    //         border: InputBorder.none,
                    //         prefixIcon: Icon(
                    //           Icons.person,
                    //           color: Colors.purple,
                    //         )),
                    //   ),
                    //   alignment: Alignment.center,
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      width: MediaQuery.of(context).size.width,
                      height: 55,
                      decoration: BoxDecoration(
                          color: Colors.purple.withOpacity(0.1),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: "Mobile Number",
                            hintStyle: TextStyle(color: Colors.black),
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.mobile_friendly,
                              color: Colors.purple,
                            )),
                      ),
                      alignment: Alignment.center,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      width: MediaQuery.of(context).size.width,
                      height: 55,
                      decoration: BoxDecoration(
                          color: Colors.purple.withOpacity(0.1),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                            hintText: "Your emails",
                            hintStyle: TextStyle(color: Colors.black),
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.purple,
                            )),
                      ),
                      alignment: Alignment.center,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    DropdownButtonFormField<dynamic>(
                      alignment: Alignment.centerLeft,
                      decoration: InputDecoration(
                        hintText: 'Select Option',
                        prefixIcon: Icon(
                          Icons.flag_circle_rounded,
                          color: Colors.purple,
                        ),
                        focusColor: Colors.black,
                        hintStyle: TextStyle(color: Colors.black),
                        filled: true,
                        fillColor: Colors.purple.withOpacity(0.1),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: AddSize.size18),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppTheme.boardercolor.withOpacity(0.5)),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppTheme.boardercolor.withOpacity(0.5)),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30.0))),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.purple.withOpacity(0.1),
                                width: 3.0),
                            borderRadius: BorderRadius.circular(15.0)),
                      ),
                      isDense: false,
                      validator: (value) {
                        if (value == null) {
                          return "Select ID Type";
                        } else {
                          return null;
                        }
                      },
                      value: currentSelectedDocument.value == ""
                          ? null
                          : currentSelectedDocument.value,
                      isExpanded: true,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: List.generate(
                          dropDownValues.length,
                          (index) => DropdownMenuItem(
                              value: dropDownValues[index].slug.toString(),
                              child: Text(
                                  dropDownValues[index].title.toString()))),
                      onChanged: (val) {
                        currentSelectedDocument.value = val;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      width: MediaQuery.of(context).size.width,
                      height: 55,
                      decoration: BoxDecoration(
                          color: Colors.purple.withOpacity(0.1),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: "Notice Information",
                            hintStyle: TextStyle(color: Colors.black),
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.home,
                              color: Colors.purple,
                            )),
                      ),
                      alignment: Alignment.center,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      width: MediaQuery.of(context).size.width,
                      height: 55,
                      decoration: BoxDecoration(
                          color: Colors.purple.withOpacity(0.1),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                            hintText: "Your Password",
                            hintStyle: TextStyle(color: Colors.black),
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.purple,
                            )),
                      ),
                      alignment: Alignment.center,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _image.value.path == ""
                            ? Padding(
                                padding:
                                    EdgeInsets.only(right: AddSize.size125),
                                child: AddButton(
                                    titleText: " Attach File",
                                    expended: false,
                                    isIcon: true,
                                    onPresses: () {
                                      showPickImageSheet();
                                    },
                                    outSideMargin: 10),
                              )
                            : Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: const Color(0xfff4f4f4),
                                        image: DecorationImage(
                                            image: FileImage(
                                              File(_image.value.path),
                                            ),
                                            fit: BoxFit.contain),
                                        border: Border.all(
                                            width: 2, color: Colors.black)),
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 15),
                                    width: double.maxFinite,
                                    height: 180,
                                    alignment: Alignment.center,
                                    child: _image.value.path
                                                    .toString()
                                                    .split(".")
                                                    .last ==
                                                "pdf" ||
                                            _image.value.path
                                                    .toString()
                                                    .split(".")
                                                    .last ==
                                                "doc" ||
                                            _image.value.path
                                                    .toString()
                                                    .split(".")
                                                    .last ==
                                                "docx" ||
                                            _image.value.path
                                                    .toString()
                                                    .split(".")
                                                    .last ==
                                                "wps"
                                        ? Text(
                                            _image.value.path
                                                .toString()
                                                .split("/")
                                                .last,
                                            style:
                                                const TextStyle(fontSize: 16),
                                          )
                                        : const SizedBox(),
                                    // child: Text(fileName.toString()),
                                  ),
                                  Positioned(
                                      top: 0,
                                      left: 0,
                                      child: InkWell(
                                        onTap: () {
                                          _image.value.delete();
                                          _image.value = File("");
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.black.withOpacity(.6),
                                            shape: BoxShape.circle,
                                          ),
                                          padding: const EdgeInsets.all(8),
                                          child: const Icon(
                                            Icons.clear,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: MaterialButton(
                        onPressed: () {
                          checkValues();
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          child: Text(
                            "Register",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    GestureDetector(
                      //   onTap: () {
                      //     Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //           builder: (context) => Login(),
                      //         ));
                      //   },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an Account?",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          Text(
                            " Sign In",
                            style:
                                TextStyle(color: Colors.purple, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DropDownValues {
  final String title;
  final String slug;

  DropDownValues({required this.title, required this.slug});
}
