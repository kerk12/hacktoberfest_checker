part of 'userdata_bloc.dart';

enum UserDataErrorType  { // TODO Rename it to something more relevant.
  userNotFound,
  apiError,
}

abstract class UserDataState extends Equatable {
  const UserDataState();
}

class UserDataLoading extends UserDataState {
  @override
  List<Object> get props => [];
}

class UserDataLoaded extends UserDataState {
  User user;
  List<PullRequest> prs;
  UserDataLoaded({
    @required this.user,
    @required this.prs,
  });

  @override
  List<Object> get props => [user];
}

class UserDataError extends UserDataState {
  UserDataErrorType error;

  UserDataError(this.error);

  @override
  // TODO: implement props
  List<Object> get props => [error];

}