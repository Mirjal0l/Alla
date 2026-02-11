

part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

final class GetProfileDataEvent extends ProfileEvent {
  const GetProfileDataEvent();

  @override
  List<Object?> get props => [];
}

