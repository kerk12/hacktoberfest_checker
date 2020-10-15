import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hacktoberfest_checker/models/pull_request.dart';

part 'pr_event.dart';

class PrBloc extends Bloc<PrEvent, List<PullRequest>> {
  PrBloc() : super(<PullRequest>[]);

  @override
  Stream<List<PullRequest>> mapEventToState(
    PrEvent event,
  ) async* {
    List<PullRequest> prs = List<PullRequest>.from(state);

    if (event is SetPRs)
      prs = event.prs;
    if (event is ClearPRs)
      prs.clear();
    yield prs;
  }
}
