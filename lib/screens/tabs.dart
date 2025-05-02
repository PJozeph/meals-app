import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/providers/favorites_provider.dart';
import 'package:meals_app/providers/filters_provider.dart';
import 'package:meals_app/providers/meals_provider.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filter_screen.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _TabsScreenState();
  }
}

const _kInitialFilterOptions = {
  FilterOptions.glutenFree: false,
  FilterOptions.lactoseFree: false,
};

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;
  // Map<FilterOptions, bool> _selectedFilters = _kInitialFilterOptions;

  void _setScreen(String identifier) async {
    Navigator.of(context).pop(); // Close the drawer
    if (identifier == 'filters') {
      Navigator.of(context).push<Map<FilterOptions, bool>>(
        MaterialPageRoute(builder: (context) => const FilterScreen()),
      );
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final avaliableMeals = ref.watch(filteredMealsProvider);
    Widget activeWidget = CategoriesScreen(avaliableMeals: avaliableMeals);
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsPrvider);
      activeWidget = MealsScreen(meals: favoriteMeals);
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle)),
      drawer: MainDrawer(onSelectScreen: _setScreen),
      body: activeWidget,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
        onTap: _selectPage,
      ),
    );
  }
}
