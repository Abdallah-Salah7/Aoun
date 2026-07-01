part of 'top_charities_cubit.dart';

abstract class TopCharitiesState {}

class TopCharitiesInitial extends TopCharitiesState {}

class TopCharitiesLoading extends TopCharitiesState {}

class TopCharitiesSuccess extends TopCharitiesState {
  final List<TopCharityModel> charities;

  TopCharitiesSuccess(this.charities);
}

class TopCharitiesError extends TopCharitiesState {
  final String message;

  TopCharitiesError(this.message);
}