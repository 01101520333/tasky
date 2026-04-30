part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {}

class HomeEmpty extends HomeState {}

class HomeError extends HomeState {
  String error;
  HomeError(this.error);
}
