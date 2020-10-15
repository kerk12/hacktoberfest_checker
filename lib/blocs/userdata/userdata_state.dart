part of 'userdata_bloc.dart';

abstract class UserDataState extends Equatable {
  const UserDataState();
}

class UserDataLoading extends UserDataState {
  @override
  List<Object> get props => [];
}

class UserDataLoaded extends UserDataState {
  User user;
  UserDataLoaded({@required this.user});

  @override
  List<Object> get props => [user];
}