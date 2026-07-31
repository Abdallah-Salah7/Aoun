import '../../../domain/entities/case_entity.dart';

abstract class CaseState {}

class CaseInitial extends CaseState {}

class CaseLoading extends CaseState {}

class CaseLoaded extends CaseState {
  final List<CaseEntity> cases;

  CaseLoaded(this.cases);
}
// أضيفي هذه الحالات داخل ملف case_state.dart
class DeleteCaseLoading extends CaseState {}

class DeleteCaseSuccess extends CaseState {}

class DeleteCaseError extends CaseState {
  final String message;
  DeleteCaseError(this.message);
}
class CaseError extends CaseState {
  final String message;

  CaseError(this.message);
}