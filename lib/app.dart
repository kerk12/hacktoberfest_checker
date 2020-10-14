import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacktoberfest_checker/blocs/splash/splash_bloc.dart';
import 'package:hacktoberfest_checker/blocs/userdata/userdata_bloc.dart';
import 'package:hacktoberfest_checker/screens/splash_screen.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
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
        )
      ],
      child: SplashScreen(),
    );
  }
}
