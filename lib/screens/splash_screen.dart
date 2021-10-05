import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacktoberfest_checker/blocs/splash/splash_bloc.dart';
import 'package:hacktoberfest_checker/blocs/userdata/userdata_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashBloc _splashBloc;
  @override
  Widget build(BuildContext context) {
    _splashBloc = BlocProvider.of<SplashBloc>(context);
    if (_splashBloc.state is SplashInitial) {
      _splashBloc.add(LoadApp());
    }
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) async {
        if (state is SplashInitial)
          _splashBloc.add(LoadApp());
        if (state is AppLoaded) {
          SharedPreferences sp = await SharedPreferences.getInstance();
          String route;
          if (sp.containsKey("github_username")) {
            route = "/home";
            UserdataBloc udb = BlocProvider.of<UserdataBloc>(context);
            udb.add(
              RequestSetUser(username: sp.getString("github_username"))
            );
          } else
            route = "/setUser";

          Navigator.of(context).pushNamedAndRemoveUntil(route, (route) => false);
        }
      },
      child: Scaffold(
        body: Container(
          // TODO Make a proper splash screen.
          child: Center(child: Text("This is where the Splash Screen should go.")),
        ),
      ),
    );
  }
}
