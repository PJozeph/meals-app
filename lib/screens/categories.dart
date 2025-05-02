import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/widgets/category_widget_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.avaliableMeals});

  final List<Meal> avaliableMeals;

  void _selectCategory(BuildContext context, Category category) {
    final filteredCategories =
        avaliableMeals
            .where((meal) => meal.categories.contains(category.id))
            .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return MealsScreen(title: category.title, meals: filteredCategories);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(15),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
      ),
      children: [
        ...availableCategories
            .map(
              (category) => CategoryItem(
                category: category,
                onSelectCategory: () {
                  _selectCategory(context, category);
                },
              ),
            )
            .toList(),
      ],
    );
  }
}
