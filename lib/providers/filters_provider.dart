import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:num_31_meal_app_the_final_version_with_implicit_animation/providers/meals_provider.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  // initial state for the Map<Filter, bool>
  FiltersNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegetarian: false,
          Filter.vegan: false,
        });
  // after initial state we can then add a method that allows us to manipulate that state in an immutable way
  void setFilter(Filter filter, bool isActive) {
    // state[filter] = isActive; // not allowed! => mutating state
    // filter: isActive --> will override the key-value pair in this map with the same filter identifier that has been copied,
    // and all the other key-value pairs will be kept along with this new sittings
    // so here we are creating a new map with the old key-value pairs and one new key-value pair,
    // that overrides the respective old key-value pair for the same filter
    state = {
      ...state,
      filter: isActive,
    };
  }

  void setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
        (ref) => FiltersNotifier());

// here I want to connect Multiple providers with each others
// we are going to build a provider that depends on other providers

final filteredMealsProviders = Provider((ref) {
  // .watch() --> will make sure that this function here gets re-executed whenever the watched value changes,
  // So now, because of watch, whenever the mealsProvider or filtersProvider value changes, this function will be re-executed.
  // and therefore the filtered meals are recalculated
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);
  return meals.where((meal) {
    if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    } else if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    } else if (activeFilters[Filter.vegan]! && !meal.isVegan) {
      return false;
    } else if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    return true;
  }).toList();
});
