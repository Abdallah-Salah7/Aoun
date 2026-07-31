import '../../../domain/entities/ai_description_entity.dart';

abstract class AiDescriptionState {}

class AiDescriptionInitial extends AiDescriptionState {}

class AiDescriptionLoading extends AiDescriptionState {}

class AiDescriptionLoaded extends AiDescriptionState {
  final AiDescriptionEntity entity;

  AiDescriptionLoaded(this.entity);
}

class AiDescriptionError extends AiDescriptionState {
  final String message;

  AiDescriptionError(this.message);
}