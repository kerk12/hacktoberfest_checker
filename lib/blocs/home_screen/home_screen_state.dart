part of 'home_screen_bloc.dart';

abstract class HomeScreenState extends Equatable {
  const HomeScreenState();
}

class HSNotLoaded extends HomeScreenState {
  @override
  List<Object> get props => [];
}

class HSLoading extends HomeScreenState {
  @override
  List<Object> get props => [];
}

class HSLoaded extends HomeScreenState {
  @override
  List<Object> get props => [];
}

class HSError extends HomeScreenState {
  @override
  List<Object> get props => [];
}