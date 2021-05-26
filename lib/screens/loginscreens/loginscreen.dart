import 'dart:ui';

import 'package:e_commerce/constaint.dart';
import 'package:e_commerce/provider/adminmode.dart';
import 'package:e_commerce/provider/modelprogress.dart';
import 'package:e_commerce/screens/adminpage/adminpage.dart';
import 'package:e_commerce/screens/homescreens/home.dart';
import 'package:e_commerce/screens/registerscreen/register.dart';
import 'package:e_commerce/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:e_commerce/servises/auth.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  static String id = 'loginScreen';
  var formkey = GlobalKey<FormState>();
  final adminpassword = 'Admin1';
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final auth = Auth();
  String email, password;

  @override
  Widget build(BuildContext context) {
    double hight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: kmainColor,
        body: ModalProgressHUD(
          inAsyncCall: Provider.of<ModelProgress>(context).isloading,
          child: Form(
            key: formkey,
            child: ListView(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Container(
                        height: MediaQuery.of(context).size.height * .22,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image(
                              image: AssetImage('assets/images/icons/buy.png'),
                            ),
                            Positioned(
                                bottom: 0,
                                child: Text(
                                  'Buy It',
                                  style: TextStyle(
                                      fontFamily: 'Schyler', fontSize: 25),
                                ))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: hight * .1,
                    ),
                    Text_field(
                      onClick: (value) {
                        email = value;
                      },
                      type: TextInputType.emailAddress,
                      controller: emailController,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'please enter your email';
                        }
                      },
                      hint: 'Enter Your Email',
                      icon: Icons.email,
                    ),
                    SizedBox(
                      height: hight * .02,
                    ),
                    Text_field(
                      onClick: (value) {
                        password = value;
                      },
                      type: TextInputType.visiblePassword,
                      controller: passwordController,
                      hint: 'Enter Your Password',
                      icon: Icons.lock,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'please enter password';
                        }
                      },
                    ),
                    SizedBox(
                      height: hight * .05,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 80),
                      child: Container(
                        width: 150,
                        child: Builder(
                          builder: (BuildContext context) => FlatButton(
                            onPressed: () {
                              _validate(context);
                            },
                            child: Text(
                              'LOGIN',
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account ?',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, RegisterScreen.id);
                            },
                            child: Text('Register',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                )))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      child: Row(
                        children: [
                          Expanded(
                              child: GestureDetector(
                            onTap: () {
                              Provider.of<AdminMode>(context, listen: false)
                                  .changeAdmin(true);
                            },
                            child: Text(
                              'im an admin ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Provider.of<AdminMode>(context).isadmin
                                    ? kmainColor
                                    : Colors.white,
                              ),
                            ),
                          )),
                          Expanded(
                              child: GestureDetector(
                            onTap: () {
                              Provider.of<AdminMode>(context, listen: false)
                                  .changeAdmin(false);
                            },
                            child: Text(
                              'im a user ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Provider.of<AdminMode>(context).isadmin
                                    ? Colors.white
                                    : kmainColor,
                              ),
                            ),
                          )),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }

  void _validate(BuildContext context) async {
    final modelprogress = Provider.of<ModelProgress>(context, listen: false);
    modelprogress.changeloading(true);
    if (formkey.currentState.validate()) {
      formkey.currentState.save();
      if (Provider.of<AdminMode>(context, listen: false).isadmin) {
        if (password == adminpassword) {
          try {
            modelprogress.changeloading(false);
            final authResult = await auth.signIn(email, password);
            modelprogress.changeloading(false);

            Navigator.pushNamed(context, AdminPage.id);
          } catch (e) {
            modelprogress.changeloading(false);
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text(e.message)));
          }
        } else {
          modelprogress.changeloading(false);
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text('something went wrong')));
        }
      } else {
        try {
          final authResult = await auth.signIn(email, password);
          modelprogress.changeloading(false);
          Navigator.pushNamed(context, Home.id);
        } catch (e) {
          modelprogress.changeloading(false);
          Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.message)));
        }
      }
    }

    modelprogress.changeloading(false);
  }
}
