part of 'new_home_bloc.dart';

enum ApiStatus { initial, loading, success, error }

@immutable
class NewHomeState extends Equatable {
  const NewHomeState({
    this.status = ApiStatus.initial,
    this.responseAllCategories,
    this.responseCategory,
    this.responseLastSeen,
    this.responsePremiere
  });

  final ApiStatus status;
  final CategoryResponse? responseAllCategories;
  final List<CategoryContent>? responseCategory;
  final CategoryContent? responseLastSeen;
  final CategoryContent? responsePremiere;


  NewHomeState copyWith({

    ApiStatus? status,
    CategoryResponse? responseAllCategories,
    List<CategoryContent>? responseCategory,
    CategoryContent? responseLastSeen,
    CategoryContent? responsePremiere,


  }) => NewHomeState(
    status: status ?? this.status,
    responseAllCategories: responseAllCategories ?? this.responseAllCategories,
    responseLastSeen: responseLastSeen ?? this.responseLastSeen,
    responseCategory: responseCategory ?? this.responseCategory,
    responsePremiere: responsePremiere ?? this.responsePremiere
  );

  @override
  List<Object?> get props => [status, responseAllCategories, responseCategory, responseLastSeen, responsePremiere];

}