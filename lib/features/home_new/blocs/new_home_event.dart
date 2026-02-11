part of 'new_home_bloc.dart';

sealed class NewHomeEvent extends Equatable {
  const NewHomeEvent();

  List<Object?> get props => [];
}

final class CategoriesEvent extends NewHomeEvent {
  const CategoriesEvent({this.activeOnly = true, this.id = ''});
  final bool activeOnly;
  final String? id;
  @override
  List<Object?> get props => [activeOnly, id];
}

final class LastSeenEvent extends NewHomeEvent {
  const LastSeenEvent();

  @override
  List<Object?> get props => [];
}

final class PremiereEvent extends NewHomeEvent {
  const PremiereEvent();

  @override
  List<Object?> get props => [];
}
