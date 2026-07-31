import '../../../data/models/charity_model.dart';

abstract class AcceptCharitiesState {}

class AcceptCharitiesInitial
    extends AcceptCharitiesState {}

class AcceptCharitiesLoading
    extends AcceptCharitiesState {}

class AcceptCharitiesSuccess
    extends AcceptCharitiesState {
  final List<CharityModel> charities;

  AcceptCharitiesSuccess(this.charities);
}

class AcceptCharitiesError
    extends AcceptCharitiesState {
  final String message;

  AcceptCharitiesError(this.message);
}