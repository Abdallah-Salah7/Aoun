import '../../../data/models/charity_model.dart';

abstract class RejectedCharitiesState {}

class RejectedCharitiesInitial extends RejectedCharitiesState {}

class RejectedCharitiesLoading extends RejectedCharitiesState {}

class RejectedCharitiesSuccess extends RejectedCharitiesState {
  final List<CharityModel> charities;

  RejectedCharitiesSuccess(this.charities);
}

class RejectedCharitiesError extends RejectedCharitiesState {
  final String message;

  RejectedCharitiesError(this.message);
}