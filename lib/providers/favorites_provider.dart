import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super([]);

  bool toggleFavorite(Meal meal) {
    final isExisting = state.contains(meal);

    if (isExisting) {
      state = [...state]..remove(meal);
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteMealsPrvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>(
      (ref) => FavoriteMealsNotifier(),
    );
