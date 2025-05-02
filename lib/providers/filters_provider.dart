import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/providers/meals_provider.dart';

enum FilterOptions { glutenFree, lactoseFree }

class FilterOptionsNotifier extends StateNotifier<Map<FilterOptions, bool>> {
  FilterOptionsNotifier()
    : super({
        FilterOptions.glutenFree: false,
        FilterOptions.lactoseFree: false,
      });

  void setAllFilters(Map<FilterOptions, bool> filters) {
    state = filters;
  }

  void setFilter(FilterOptions filter, bool value) {
    state = {...state, filter: value};
  }

  void resetFilters() {
    state = {FilterOptions.glutenFree: false, FilterOptions.lactoseFree: false};
  }
}

final filterOptionsProvider =
    StateNotifierProvider<FilterOptionsNotifier, Map<FilterOptions, bool>>(
      (ref) => FilterOptionsNotifier(),
    );

final filteredMealsProvider = Provider<List<Meal>>((ref) {
  final meals = ref.watch(mealPrvider);
  final activeFilters = ref.watch(filterOptionsProvider);

  return meals.where((meal) {
    if (activeFilters[FilterOptions.glutenFree] == true &&
        !meal.isGlutenFree) {
      return false;
    }
    if (activeFilters[FilterOptions.lactoseFree] == true &&
        !meal.isLactoseFree) {
      return false;
    }
    return true;
  }).toList();
});
