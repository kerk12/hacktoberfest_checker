import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hacktoberfest_checker/services/github.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc() : super(null);

  @override
  Stream<HomeScreenState> mapEventToState(
    HomeScreenEvent event,
  ) async* {
    if (event is LoadPRs){
      SharedPreferences sp = await SharedPreferences.getInstance();
      GitHubService ghs = GitHubService(sp.getString("github_username"));
      ghs.getPRs();
    }
  }
}
