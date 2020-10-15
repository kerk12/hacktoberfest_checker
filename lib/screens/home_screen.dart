import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacktoberfest_checker/blocs/home_screen/home_screen_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<HomeScreenBloc, HomeScreenState>(
        builder: (context, state) {
          if (state is HSNotLoaded){
            final HomeScreenBloc hsb = context.bloc();
            hsb.add(LoadPRs());
          }
          return Container();
        },
      )
    );
  }
}
