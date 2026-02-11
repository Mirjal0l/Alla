

import 'package:alla/api/repository.dart';
import 'package:alla/core/error/failure.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/model/profile_response.dart';


part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({this.repository}) : super(ProfileState(status: ProfileStatus.initial)) {
    on<GetProfileDataEvent>(_getProfileDataEventHandler);
  }

  final Repository? repository;

  Future<void> _getProfileDataEventHandler(
      GetProfileDataEvent event,
      Emitter emit,
      ) async {
    emit(state.copyWith(status: ProfileStatus.loading));

    final result = await repository?.getProfileData();
    await result?.fold(
        (Failure left) {
          emit(
              ProfileState(status: ProfileStatus.error, message: left.message));
        },
        (ProfileResponse right) async {
          emit(ProfileState(status: ProfileStatus.success, profileResponse: right));
        }
    );
  }
}

