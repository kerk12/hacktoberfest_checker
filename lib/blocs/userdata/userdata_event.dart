part of 'userdata_bloc.dart';

abstract class UserdataEvent extends Equatable {
  const UserdataEvent();
}

class SetUser extends UserdataEvent {
  String username;

  SetUser({@required this.username});

  @override
  // TODO: implement props
  List<Object> get props => [];
}