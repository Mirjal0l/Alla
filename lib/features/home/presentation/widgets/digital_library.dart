import 'package:alla/core/utils/utils.dart';
import 'package:alla/features/home/data/static_data/static_data.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../router/name_routes.dart';
import 'digital_library_card.dart';

class DigitalLibrary extends StatefulWidget {
  const DigitalLibrary({super.key, required this.currentData});

  final List currentData;

  @override
  State<DigitalLibrary> createState() => _DigitalLibraryState();
}

class _DigitalLibraryState extends State<DigitalLibrary> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          mainAxisExtent: 280
        ),
        itemCount: StaticData().digitalLibrary.length,
        itemBuilder: (_, index) {
          final  item = StaticData().digitalLibrary[index];
          return GestureDetector(
            onTap: () {
              context.pushNamed(
                Routes.eduContentDetails,
                pathParameters: {'index': index.toString()},
              );
            },
              child: DigitalLibraryCard(data: item, index: index)
          );
        },
    );
  }
}
