import '../../../domain/entities/case_entity.dart';

abstract class CaseState {}

class CaseInitial extends CaseState {}

class CaseLoaded extends CaseState {
  final List<CaseEntity> cases;

  CaseLoaded(this.cases);
}

