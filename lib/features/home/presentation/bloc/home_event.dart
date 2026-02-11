

part of 'home_bloc.dart';



sealed class HomeEvent extends Equatable{
  const HomeEvent();

  @override
  List<Object?> get props => []; // Equatable requires this
}

// Send OTP event - exactly like Gotix pattern
final class GetCategoriesEvent extends HomeEvent {
  const GetCategoriesEvent({required this.activeOnly});
  final bool activeOnly;


  @override
  List<Object?> get props => [activeOnly]; // Include all fields for equality check
}

// Verify OTP event

