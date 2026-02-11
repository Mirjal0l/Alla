import 'dart:math';

import 'package:alla/api/repository.dart';
import 'package:alla/core/error/failure.dart';
import 'package:alla/features/home_new/models/category_response.dart';
import 'package:alla/features/home_new/models/category_content.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

part 'new_home_event.dart';

part 'new_home_state.dart';

class NewHomeBloc extends Bloc<NewHomeEvent, NewHomeState> {
  NewHomeBloc({required this.repository}) : super(NewHomeState()) {
    on<CategoriesEvent>(_getApiCategories);
    on<LastSeenEvent>(_getLastSeenHandler);
    on<PremiereEvent>(_getPremiereHandler);
  }

  final Repository repository;

  Future<void> _getApiCategories(
    CategoriesEvent event,
    Emitter<NewHomeState> emit,
  ) async {
    final result = await repository.getNewCategories(
      activeOnly: event.activeOnly,
      id: event.id,
    );

    await result.fold(
      (Failure left) {
        emit(const NewHomeState(status: ApiStatus.error));
      },
      (CategoryResponse right) async {
        emit(
          NewHomeState(status: ApiStatus.success, responseAllCategories: right),
        );

        final List<CategoryContent> categoryContentList = [];
        CategoryContent game = CategoryContent();

        if (right.data != null) {
          for (var a in right.data!) {
            switch (a.contentIntentType) {
              case 'VIDEO' || 'SERIES':
                {
                  final resultVideo = await repository.getVideoById(
                    categoryId: a.id ?? '',
                  );
                  await resultVideo.fold(
                        (Failure left) {
                      emit(const NewHomeState(status: ApiStatus.error));
                    },
                        (CategoryContent right) {

                          categoryContentList.add(right);

                      // emit(
                        // NewHomeState(
                        //   status: ApiStatus.success,
                        //   // responseCategoriesContent: right,
                        // ),
                      // );
                    },
                  );
                  break;
                }
              case 'BOOK':
                {
                  final resultBook = await repository.getBookById(
                    categoryId: a.id ?? '',
                  );
                  await resultBook.fold(
                    (Failure left) {
                      emit(const NewHomeState(status: ApiStatus.error));
                    },
                    (CategoryContent right) {

                      // for(var i in right.data!.content!) {
                      //   // categoryContent.add(i.mobileThumbnailUrl);
                      //   categoryContentList.add(right);
                      // }

                      categoryContentList.add(right);

                      // emit(
                      //   NewHomeState(
                      //     status: ApiStatus.success,
                      //     // responseCategoriesContent: right,
                      //   ),
                      // );
                    },
                  );
                  break;
                }
              case 'GAME':
                {
                  final resultGame = await repository.getGameById(
                    categoryId: a.id ?? '',
                  );
                  await resultGame.fold(
                    (Failure left) {
                      emit(const NewHomeState(status: ApiStatus.error));
                    },
                    (CategoryContent right) async {

                      int counter = 0;
                      for(var b in right.data!.content!) {
                        game.data?.content?[counter].mobileThumbnailUrl = b.thumbnailUrl;
                        game.data?.content?[counter].id = b.id;
                        game.data?.content?[counter].title = b.title;
                        game.data?.content?[counter].categoryId = b.categoryId;
                        counter++;
                      }


                      // categoryContentList.add(game);

                      // emit(
                      //   NewHomeState(
                      //     status: ApiStatus.success,
                      //     // responseCategoriesContent: right,
                      //   ),
                      // );
                    },
                  );
                  break;
                }
            }
          }

          categoryContentList.add(game);

          emit(NewHomeState(
            status: ApiStatus.success,
            responseCategory: categoryContentList
          ));
        }
      },
    );
  }

  Future<void> _getLastSeenHandler(
    LastSeenEvent event,
    Emitter<NewHomeState> emit,
  ) async {
    final result = await repository.getLastSeen();
    await result.fold(
      (Failure left) {
        emit(const NewHomeState(status: ApiStatus.error));
      },
      (CategoryContent right) async {
        emit(
          NewHomeState(
            status: ApiStatus.success,
            responseLastSeen: right,
          ),
        );
      },
    );
  }

  Future<void> _getPremiereHandler(
    PremiereEvent event,
    Emitter<NewHomeState> emit,
  ) async {
    final result = await repository.getPremiere();
    await result.fold(
      (Failure left) {
        emit(const NewHomeState(status: ApiStatus.error));
      },
      (CategoryContent right) async {
        emit(
          NewHomeState(
            status: ApiStatus.success,
            responsePremiere: right,
          ),
        );
      },
    );
  }
}
