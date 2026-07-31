import '../../../domain/entities/recommend_case_entity.dart';

abstract class RecommendState {}

class RecommendInitial extends RecommendState {}

class RecommendLoading extends RecommendState {}

class RecommendLoaded extends RecommendState {
  final List<RecommendCaseEntity> recommendCases;

  RecommendLoaded({
    required this.recommendCases,
  });
}

class RecommendError extends RecommendState {
  final String message;

  RecommendError(this.message);
}