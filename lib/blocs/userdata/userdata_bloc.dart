
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hacktoberfest_checker/models/pull_request.dart';
import 'package:hacktoberfest_checker/models/user.dart';
import 'package:hacktoberfest_checker/services/github.dart';

part 'userdata_event.dart';
part 'userdata_state.dart';

class UserdataBloc extends Bloc<UserdataEvent, UserDataState> {
  UserdataBloc() : super(null) {
    on<RequestSetUser>((event, emit) async {
      emit(UserDataLoading());
      GitHubService ghs = GitHubService(event.username);
      try {
        User u = await ghs.getUserData();
        List<PullRequest> prs = await ghs.getPRs();
        emit(UserDataLoaded(user: u, prs: prs));
      } on InvalidUserException {
        emit(UserDataError(UserDataErrorType.userNotFound));
      }
    });
    on<SetUser>(((event, emit) => emit(UserDataLoaded(user: event.user, prs: event.prs))));
  }
}
