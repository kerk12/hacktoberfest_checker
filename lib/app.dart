import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacktoberfest_checker/blocs/home_screen/home_screen_bloc.dart';
import 'package:hacktoberfest_checker/blocs/splash/splash_bloc.dart';
import 'package:hacktoberfest_checker/blocs/userdata/userdata_bloc.dart';
import 'package:hacktoberfest_checker/screens/home_screen.dart';
import 'package:hacktoberfest_checker/screens/splash_screen.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen();
  }
}
