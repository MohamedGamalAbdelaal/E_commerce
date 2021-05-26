import 'package:e_commerce/provider/modelprogress.dart';
import 'package:e_commerce/screens/homescreens/home.dart';
import 'package:e_commerce/screens/loginscreens/loginscreen.dart';
import 'package:e_commerce/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/servises/auth.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

import '../../constaint.dart';

class RegisterScreen extends StatelessWidget {
  static String id = 'RegisterScreen';
  final _auth = Auth();
  var formkey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final auth = Auth();
  String name, email, password;
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
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
                      height: height * .1,
                    ),
                    Text_field(
                        type: TextInputType.name,
                        controller: nameController,
                        hint: 'Enter Your Name',
                        icon: Icons.person,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'please enter your name';
                          }
                        }),
                    SizedBox(
                      height: height * .02,
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
                      height: height * .02,
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
                      height: height * .05,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 80),
                      child: Container(
                        width: 150,
                        child: Builder(
                          builder: (BuildContext context) => FlatButton(
                            onPressed: () async {
                              final modelprogress = Provider.of<ModelProgress>(
                                  context,
                                  listen: false);
                              modelprogress.changeloading(true);
                              if (formkey.currentState.validate()) {
                                formkey.currentState.save();
                                try {
                                  final authResult =
                                      await auth.signUp(email, password);
                                  modelprogress.changeloading(false);
                                  Navigator.pushNamed(context, Home.id);
                                } catch (e) {
                                  modelprogress.changeloading(false);
                                  Scaffold.of(context).showSnackBar(
                                      SnackBar(content: Text(e.message)));
                                }
                              }
                              modelprogress.changeloading(false);
                            },
                            child: Text(
                              'REGISTER',
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
                          'Do have an account ?',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, LoginScreen.id);
                            },
                            child: Text('Login',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                )))
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
