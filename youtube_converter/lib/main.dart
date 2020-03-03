import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/SplashScreen.dart';

void main() {
  /*
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.landscapeLeft])
      .then((_) {
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF141414),
        backgroundColor: Color(0xFF141414),
        floatingActionButtonTheme:
            FloatingActionButtonThemeData(backgroundColor: Color(0xFFd8153f)),
      ),
      home: SplashScreen(),
    ));
  });
  */
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Color(0xFF141414),
          elevation: 10
        ),
        scaffoldBackgroundColor: Color(0xFF141414),
        backgroundColor: Color(0xFF141414),
        
        floatingActionButtonTheme:
            FloatingActionButtonThemeData(backgroundColor: Color(0xFFd8153f)),
      ),
      home: SplashScreen(),
    ));
}
