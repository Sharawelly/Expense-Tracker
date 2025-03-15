import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:num_31_meal_app_the_final_version_with_implicit_animation/providers/favorites_provider.dart';
import 'package:num_31_meal_app_the_final_version_with_implicit_animation/screens/categories.dart';
import 'package:num_31_meal_app_the_final_version_with_implicit_animation/screens/filters.dart';
import 'package:num_31_meal_app_the_final_version_with_implicit_animation/screens/meals.dart';
import 'package:num_31_meal_app_the_final_version_with_implicit_animation/widgets/main_drawer.dart';

import '../providers/filters_provider.dart';

import '../data/dummy_data.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegan: false,
  Filter.vegetarian: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      await Navigator.of(context)
          // Map<Filter, bool> --> data type of returned value
          .push<Map<Filter, bool>>(
              MaterialPageRoute(builder: (ctx) => const FiltersScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    // we now have ref property available that allows us to set up listeners to our providers,
    // So, this ref property is added by Riverpod, and it is available because we are extending ConsumerState here in this state class.
    // Now, with this ref property available, the question, of course, is what we can do with it. What we can do is use a couple of utility methods.
    // Most importantly, read to get data from our provider once, or watch to set up a listener that will ensure the build method executes again as our data changes.
    // The official Riverpod documentation recommends using watch as often as possible, even if you technically only need to read data once. This way,
    // if you ever change your logic, you won’t run into unintended bugs where you forgot to replace a read with a watch. That’s why they recommend that you always use watch right from the start.
    // that now we setup a listener that will re-execute this build method whenever this filteredMealsProviders should change,
    // whenever So whenever that data in there should change
    final availableMeals = ref.watch(filteredMealsProviders);
    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final favoriteMeal = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(
        meals: favoriteMeal,
      );
      activePageTitle = 'Your Favorites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      // to add a Side drawer
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
