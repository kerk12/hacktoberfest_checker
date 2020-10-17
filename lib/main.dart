import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacktoberfest_checker/blocs/splash/splash_bloc.dart';
import 'package:hacktoberfest_checker/blocs/userdata/userdata_bloc.dart';
import 'package:hacktoberfest_checker/screens/home_screen.dart';
import 'package:hacktoberfest_checker/screens/set_user.dart';
import 'package:hacktoberfest_checker/screens/splash_screen.dart';

void main() {

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<SplashBloc>(
          create: (context) {
            return SplashBloc();
          },
        ),
        BlocProvider<UserdataBloc>(
          create: (context) {
            return UserdataBloc();
          },
        ),
      ],
      child: HacktoberfestChecker()
    )
  );
}

class HacktoberfestChecker extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primaryColor: Colors.white,
        accentColor: Colors.black87,
        textTheme: TextTheme(

        ),
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: "/splash",
      routes: {
        "/splash": (context) => SplashScreen(),
        "/": (context) => HomeScreen(),
        "/setUser": (context) => SetUserScreen(),
        // "/setUser"
      },
    );
  }
}


