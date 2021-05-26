import 'package:e_commerce/provider/adminmode.dart';
import 'package:e_commerce/provider/modelprogress.dart';
import 'package:e_commerce/screens/adminpage/adminpage.dart';
import 'package:e_commerce/screens/homescreens/home.dart';
import 'package:e_commerce/screens/registerscreen/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/loginscreens/loginscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ModelProgress>(
            create: (context) => ModelProgress()),
        ChangeNotifierProvider<AdminMode>(create: (context) => AdminMode()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: LoginScreen.id,
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          RegisterScreen.id: (context) => RegisterScreen(),
          Home.id: (context) => Home(),
          AdminPage.id: (context) => AdminPage(),
        },
      ),
    );
  }
}
