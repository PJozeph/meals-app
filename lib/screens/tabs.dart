import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filter_screen.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  List<Meal> _favoriteMeals = [];

  void _showInfoSnackBar(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop(); // Close the drawer
    if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<FilterOptions, bool>>(
        MaterialPageRoute(builder: (context) => const FilterScreen()),
      );
      print("result");
      print(result);
    }
  }

  void _toggleFavorite(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal);

    if (isExisting) {
      setState(() {
        _favoriteMeals.remove(meal);
        _showInfoSnackBar("${meal.title} removed from favorites");
      });
    } else {
      setState(() {
        _favoriteMeals.add(meal);
        _showInfoSnackBar("${meal.title} added to favorites");
      });
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activeWidget = CategoriesScreen(onToggleFavorite: _toggleFavorite);
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activeWidget = MealsScreen(
        meals: _favoriteMeals,
        onToggleFavorite: _toggleFavorite,
      );
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
