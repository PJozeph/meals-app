import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key, required this.title, required this.meals});

  final String title;
  final List<Meal> meals;

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: meals.length,
      itemBuilder: (context, index) {
        return Text(
          meals[index].title,
          style: Theme.of(context).textTheme.titleLarge,
        );
      },
    );

    if (meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "No meals found!",
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            Icon(Icons.warning, size: 50),
            SizedBox(height: 20),
            Text('No meals available for this category!'),
          ],
        ),
      );
    }

    return Scaffold(appBar: AppBar(title: Text(title)), body: content);
  }
}
