import '../entities/conference_entity.dart';

sealed class ConferencesState {}

class ConferencesInitial extends ConferencesState {}

class ConferencesLoading extends ConferencesState {}

class ConferencesFailure extends ConferencesState {
  final String message;
  ConferencesFailure(this.message);
}

class ConferencesSuccess extends ConferencesState {
  final List<ConferenceEntity> conferences;
  ConferencesSuccess(this.conferences);
}
