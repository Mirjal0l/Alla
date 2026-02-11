import 'dart:async';

import 'package:alla/core/utils/app_colors.dart';
import 'package:alla/core/utils/utils.dart';
import 'package:alla/features/home_new/blocs/new_home_bloc.dart';
import 'package:alla/features/home_new/data/static_datas.dart';
import 'package:alla/features/home_new/presentation/widgets/header_content.dart';
import 'package:alla/features/home_new/presentation/widgets/middle_content.dart';
import 'package:alla/features/home_new/presentation/widgets/my_page_view.dart';
import 'package:alla/features/home_new/presentation/widgets/super_list.dart';
import 'package:alla/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/custom_bold_text.dart';
import '../../widgets/custom_sub_text.dart';
import 'models/category_response.dart';
import 'models/category_content.dart';

class NewHomePage extends StatefulWidget {
  const NewHomePage({super.key});

  @override
  State<NewHomePage> createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage>
    with TickerProviderStateMixin {
  int currentIndex = 0;

  bool isLoading = true;

  void setTimer() {
    Future.delayed(Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          isLoading = !isLoading;
        });
      }
    });
  }

  List<bool> list = [
    true,
    false,
    false,
    false,
    false,
    false,
  ]; // for changing progress bar

  late final PageController _pageController;

  late AnimationController _animationController;

  late CategoryResponse? responseAllCategoryData = CategoryResponse();
  late List<CategoryContent>? responseCategoryData = [];
  late CategoryContent? responseLastSeenData = CategoryContent();

  late CategoryContent? responsePremiereData = CategoryContent();
  
  late List<CategoryContent>? CategoryList = [];

  @override
  Widget build(BuildContext context) =>
      BlocListener<NewHomeBloc, NewHomeState>(
        listener: (BuildContext context, NewHomeState state) async {
          if (state.responseAllCategories != null) {
            responseAllCategoryData = state.responseAllCategories;
          }

          if (state.responseLastSeen != null) {
            responseLastSeenData = state.responseLastSeen!;
          }

          // if (state.responseCategory != null) {
          //   responseCategoryData = state.responseCategory;
          //   for(var a in responseCategoryData!) {
          //     if (a.data!.content![0].categoryId == ) {
          //
          //     }
          //   }
          // }


          if (state.responsePremiere != null) {
            responsePremiereData = state.responsePremiere!;
          }

          for(var b in responseAllCategoryData!.data!) {
            if (b.contentIntentType == 'GAME') {
              break;
            }
          }

        },


        listenWhen: (NewHomeState previous, NewHomeState current) =>
        previous.status != current.status ||
            previous.responseAllCategories != current.responseAllCategories ||
            previous.responseCategory != current.responseCategory ||
            previous.responseLastSeen != current.responseLastSeen ||
            previous.responsePremiere != current.responsePremiere,


        child: BlocBuilder<NewHomeBloc, NewHomeState>(
          buildWhen: (previous, current) =>
          previous.responseCategory != current.responseCategory ||
              previous.responseAllCategories != current.responseAllCategories ||
              previous.responseLastSeen != current.responseLastSeen ||
              previous.responsePremiere != current.responsePremiere ||
              previous.status != current.status,

          builder: (context, stated) {
            final categories = responseAllCategoryData?.data ?? [];
            final lastSeen = responseLastSeenData?.data?.content ?? [];
            final premiere = responsePremiereData?.data?.content ?? [];


            return Scaffold(
              extendBody: true,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.6,
                      child: Stack(
                        children: [
                          // Page builder
                          MyPageView(
                            currentIndex: currentIndex,
                            pageController: _pageController,
                          ),

                          // Gradient effect
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.dark_blue,
                                    AppColors.transparent,
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: [0.05, 0.5],
                                ),
                              ),
                            ),
                          ),

                          Positioned.fill(
                            child: Column(
                              children: [
                                AppUtils.kGap48,
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      HeaderContent(),

                                      MiddleContent(
                                        currentIndex: currentIndex,
                                        list: list,
                                        animationController: _animationController,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Oxirgi ko'rilganlar
                    lastSeen.isNotEmpty ? Container(
                      color: AppColors.dark_blue,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: 148,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                ),
                                child: CustomBoldText(
                                  text: 'Oxirgi ko‘rilganlar',
                                  size: 16,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.white08,
                                ),
                              ),

                              Spacer(),
                              CustomSubText(
                                text: 'Barchasi',
                                size: 14,
                                color: AppColors.white08,
                              ),
                              Icon(
                                Icons.keyboard_arrow_right_rounded,
                                size: 24,
                                color: AppColors.white,
                              ),
                            ],
                          ),

                          Expanded(
                            child: ListView.builder(
                              itemCount: lastSeen.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: AppUtils.kPaddingTop8Others4,
                                  width: 161,
                                  height: 90,
                                  decoration: BoxDecoration(
                                    borderRadius: AppUtils.kBorderRadius8,
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          lastSeen[index].mobileThumbnailUrl
                                              .toString()
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ) : SizedBox(),

                    // Premyera list
                    premiere.isNotEmpty ? Container(
                      color: AppColors.dark_blue,
                      padding: AppUtils.kPaddingTop16,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: 148,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                ),
                                child: CustomBoldText(
                                  text: 'Premyeralar',
                                  size: 16,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.white08,
                                ),
                              ),

                              Spacer(),
                              CustomSubText(
                                text: 'Barchasi',
                                size: 14,
                                color: AppColors.white08,
                              ),
                              Icon(
                                Icons.keyboard_arrow_right_rounded,
                                size: 24,
                                color: AppColors.white,
                              ),
                            ],
                          ),

                          Expanded(
                            child: ListView.builder(
                              itemCount: premiere.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return premiere[index].mobileThumbnailUrl !=
                                    null
                                    ? Container(
                                  margin: AppUtils.kPaddingTop8Others4,
                                  width: 147,
                                  height: 106,
                                  decoration: BoxDecoration(
                                    borderRadius: AppUtils.kBorderRadius8,
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        premiere[index].mobileThumbnailUrl
                                            .toString(),
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                                    : SizedBox();
                              },
                            ),
                          )
                        ],
                      ),
                    ) : SizedBox(),

                    // LIST VIEW  SUPER LIST
                    SizedBox(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      child: SuperList(
                        allCategories: categories,
                        categoryContentData: responseCategoryData,
                      ),
                    ),

                    FloatingActionButton(
                      onPressed: () {
                        print('lastSeen[0].image: ${responseLastSeenData?.data
                            ?.content?[0].mobileThumbnailUrl}');
                        print('lastSeen.length: ${lastSeen.length}');
                        print('lastSeen: ${lastSeen}');

                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${responseCategoryData?[6].data?.content}'))
                        );
                      },
                    )
                  ],
                ),
              ),
            );
          },
        ),
      );

  void _autoPlay() {
    if (!_pageController.hasClients) {
      return; // Exit  immediately if controller is not attached
    }

    if (currentIndex < StaticDatas().pageBuilderItem.length - 1) {
      setState(() {
        currentIndex++;
      });

      _pageController.animateToPage(
        currentIndex,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      setState(() {
        currentIndex = 0;
      });

      _pageController.jumpToPage(currentIndex);
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<NewHomeBloc>().add(PremiereEvent());
    context.read<NewHomeBloc>().add(LastSeenEvent());
    context.read<NewHomeBloc>().add(CategoriesEvent(activeOnly: true));
    _pageController = PageController();
    _animationController =
    AnimationController(vsync: this, duration: const Duration(seconds: 5))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          bool lastItem = list.removeLast();
          list.insert(0, lastItem);
          _animationController.reset();
          _animationController.forward();
          _autoPlay();
        }
      })
      ..forward();

    // Check if Bloc is initialized and making API call
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print('TRIGGERING GETAPICATEGORIES...');
      localSource.setAccessToken(
        'eyJhbGciOiJIUzI1NiJ9.eyJwaG9uZU51bWJlciI6Iis5OTgwMDAwMDAwMDAiLCJ0b2tlblR5cGUiOiJBQ0NPVU5UIiwidXNlcklkIjozLCJzdWIiOiIrOTk4MDAwMDAwMDAwIiwiaWF0IjoxNzY5MzEyNzMxLCJleHAiOjE3Njk3NDQ3MzF9.KAm9LWb6RW5sUuA-htgjoshjerXjp'
            'bfsCOIttkEKdl8',
      );
    });


  }
  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();
    super.dispose();
  }
}
