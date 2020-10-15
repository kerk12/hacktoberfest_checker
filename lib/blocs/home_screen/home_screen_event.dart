part of 'home_screen_bloc.dart';

abstract class HomeScreenEvent extends Equatable {
  const HomeScreenEvent();
}

class LoadPRs extends HomeScreenEvent {
  @override
  List<Object> get props => [];
}

class PRLoadingFinished extends HomeScreenEvent {
  @override
  List<Object> get props => [];
}