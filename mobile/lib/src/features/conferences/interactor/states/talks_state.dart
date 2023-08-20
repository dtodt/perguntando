import '../entities/talk_entity.dart';

sealed class TalksState {}

class TalksInitial extends TalksState {}

class TalksLoading extends TalksState {}

class TalksFailure extends TalksState {
  final String message;
  TalksFailure(this.message);
}

class TalksSuccess extends TalksState {
  final List<TalkEntity> talks;
  TalksSuccess(this.talks);
}
