

part of 'profile_bloc.dart';


enum ProfileStatus {initial, loading, success, error}

class ProfileState extends Equatable {
  final bool? success;
  final ProfileStatus? status;
  final String? message;
  final ProfileResponse? profileResponse;

  const ProfileState({
    this.success,
    this.status,
    this.message,
    this.profileResponse
  });

  ProfileState copyWith({
    bool? success,
    ProfileStatus? status,
    String? message,
    ProfileResponse? profileResponse,
  }) => ProfileState(
    success: success ?? this.success,
    status: status ?? this.status,
    message: message ?? this.message,
    profileResponse: profileResponse ?? this.profileResponse,
  );

  @override
  List<Object?> get props => [success, status, message, profileResponse];
}

