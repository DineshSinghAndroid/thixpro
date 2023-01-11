import 'package:Thixpro/router/my_router.dart';
import 'package:flutter/material.dart';
import 'package:Thixpro/screens/common/sign_up.dart';
import 'package:get/get.dart';

import '../bottom_navbar.dart';

class Login extends StatefulWidget {
  bool? isVendorLogin;
  Login({Key? key, this.isVendorLogin}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              // Text(widget.isVendorLogin! ? "Trueeeeee" : "falseeeee"),
              Container(
                height: 400,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/login.jpg'),
                        fit: BoxFit.cover)),
              ),
              // Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.purple.withOpacity(0.1),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: "Your email",
                            hintStyle: TextStyle(color: Colors.black),
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.person,
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
                      height: 65,
                      decoration: BoxDecoration(
                          color: Colors.purple.withOpacity(0.1),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: TextFormField(
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
                      height: 40,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(MyRouter.bottomNavbar);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 55,
                        decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        child: Text(
                          "SIGN IN ",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        alignment: Alignment.center,
                      ),
                    ),
                    SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpScreen(),
                            ));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an Account?",
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                          Text(
                            " Sign Up",
                            style:
                                TextStyle(color: Colors.purple, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
