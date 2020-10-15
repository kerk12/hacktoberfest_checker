part of 'pr_bloc.dart';

abstract class PrEvent extends Equatable {
  const PrEvent();
}

class SetPRs extends PrEvent {
  final List<PullRequest> prs;

  SetPRs(this.prs);

  @override
  List<Object> get props => [];
}

class ClearPRs extends PrEvent {
  @override
  List<Object> get props => [];
}