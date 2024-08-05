import 'package:flutter/material.dart';

import '../../components/custom_text.dart';
import '../../controller/category_controller.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.categoryController,
    required this.categoryIndex,
  });

  final CategoryController categoryController;
  final int categoryIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFC0C0C0).withOpacity(0.15),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(1, 1),
          ),
          const BoxShadow(
            color: Colors.white,
            offset: Offset(-1, -1),
            blurRadius: 2,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  left: 4,
                  top: 5,
                ),
                width: 30,
                height: 30,
                padding: const EdgeInsets.all(5),
                child: Image.asset(
                  categoryController.categoryList[categoryIndex].icon,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              top: 6,
            ),
            child: SizedBox(
              child: CustomText(
                text: categoryController.categoryList[categoryIndex].name,
                fontFamily: 'Lato',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF252525),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
