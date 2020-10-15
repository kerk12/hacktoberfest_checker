part of 'userdata_bloc.dart';

abstract class UserdataEvent extends Equatable {
  const UserdataEvent();
}

class RequestSetUser extends UserdataEvent {
  String username;

  RequestSetUser({@required this.username});

  @override
  // TODO: implement props
  List<Object> get props => [username];
}

class SetUser extends UserdataEvent {
  User user;
  SetUser(this.user);

  @override
  List<Object> get props => [user];

}