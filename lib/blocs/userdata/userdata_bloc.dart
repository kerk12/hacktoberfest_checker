import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hacktoberfest_checker/models/pull_request.dart';
import 'package:hacktoberfest_checker/models/user.dart';
import 'package:hacktoberfest_checker/services/github.dart';

part 'userdata_event.dart';
part 'userdata_state.dart';

class UserdataBloc extends Bloc<UserdataEvent, UserDataState> {
  UserdataBloc() : super(null);

  @override
  Stream<UserDataState> mapEventToState(
    UserdataEvent event,
  ) async* {
    if (event is RequestSetUser) {
      yield UserDataLoading();
      GitHubService ghs = GitHubService(event.username);
      try {
        User u = await ghs.getUserData();
        List<PullRequest> prs = await ghs.getPRs();
        yield UserDataLoaded(user: u, prs: prs);
      } on InvalidUserException {
        yield UserDataError(UserDataErrorType.userNotFound);
      }

    }
    if (event is SetUser)
      yield UserDataLoaded(user: event.user, prs: event.prs);
  }
}
