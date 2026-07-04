import '../../../domain/entities/donor_case_entity.dart';

abstract class DonorCaseState {}

class DonorCaseInitial extends DonorCaseState {}

class DonorCaseLoading extends DonorCaseState {}

class DonorCaseLoaded extends DonorCaseState {
  final List<DonorCaseEntity> cases;

  DonorCaseLoaded(this.cases);
}

class DonorCaseDetailsLoaded extends DonorCaseState {
  final DonorCaseEntity donorCase;

  DonorCaseDetailsLoaded(this.donorCase);
}

class DonorCaseError extends DonorCaseState {
  final String message;

  DonorCaseError(this.message);
}