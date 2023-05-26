import 'package:campus_assist_web/firebase_options.dart';
import 'package:campus_assist_web/homepage.dart';
import 'package:campus_assist_web/results/resultsMainScreen.dart';
import 'package:campus_assist_web/results/uploadresults.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'Library/listview.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: Homepage(),
        home: Homepage());
  }
}
