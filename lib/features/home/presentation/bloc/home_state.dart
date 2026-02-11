// Explanation: States represent what the UI should show
// Like loading, success, error, etc.

part of 'home_bloc.dart';


enum ApiStatus { initial, loading, success, error }

class HomeState extends Equatable {
  const HomeState({
    this.success,
    this.status,
    this.message,
    this.categoryResponse
  });

  final bool? success;
  final ApiStatus? status;
  final String? message;
  final CategoryResponseOld? categoryResponse;



  // copyWith method - allows creating new state with updated fields
  // Explanation: This is used in BLoC to create new states while keeping unchanged fields

  HomeState copyWith({
    bool? success,
    ApiStatus? status,
    String? message,
    CategoryResponseOld? categoryResponse,
  }) =>
      HomeState(
          success: success ?? this.success,
          status: status ?? this.status,
          message: message ?? this.message,
        categoryResponse: categoryResponse ?? this.categoryResponse
      );

  @override
  List<Object?> get props => [success, status, message, categoryResponse];
}
