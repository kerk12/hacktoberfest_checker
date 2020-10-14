import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'userdata_event.dart';

class UserdataBloc extends Bloc<UserdataEvent, String> {
  UserdataBloc() : super(null);

  @override
  Stream<String> mapEventToState(
    UserdataEvent event,
  ) async* {
    if (event is SetUser) {
      yield event.username;
    }
  }
}
