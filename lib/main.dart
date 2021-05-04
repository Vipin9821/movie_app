import 'package:flutter/material.dart';
import 'package:movie_app/screens/splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/utilities/app_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue[900],
        accentColor: Colors.white,
        canvasColor: Color(0xff091627),
        brightness: Brightness.dark,
        // fontFamily: GoogleFonts.comfortaa().fontFamily,
        fontFamily: GoogleFonts.lato().fontFamily,
      ),
      title: 'Moviesto',
      onGenerateRoute: AppRouter().onGenerateRoute,
      home: SplashScreen(),
    );
  }
}
