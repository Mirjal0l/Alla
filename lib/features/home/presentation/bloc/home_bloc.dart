import 'package:alla/core/error/failure.dart';
import 'package:alla/features/auth/data/models/requests/send_otp_request.dart';
import 'package:alla/features/auth/data/models/responses/send_otp_response.dart';
import 'package:alla/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:alla/features/home/data/model/category_response_old.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:alla/api/repository.dart';

import '../../../auth/data/models/requests/verify_otp_request.dart';
import '../../../auth/data/models/responses/verify_otp_response.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({this.repository}) : super(HomeState(status: ApiStatus.initial)) {
    on<GetCategoriesEvent>(_getCategoriesEventHandler);
  }

  final Repository? repository;

  // Verify OTP event handler
  Future<void> _getCategoriesEventHandler(
      GetCategoriesEvent event,
      Emitter<HomeState> emit,
      ) async {
    emit(state.copyWith(status: ApiStatus.loading));

    final result = await repository?.getApiCategories(
      activeOnly: event.activeOnly,
    );

    await result?.fold(
          (Failure left) {
        emit(HomeState(status: ApiStatus.error, message: left.message));
      },
          (CategoryResponseOld right) async {
        emit(HomeState(status: ApiStatus.success, categoryResponse: right));
      },
    );
  }
}
