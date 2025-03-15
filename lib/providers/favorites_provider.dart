import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:num_31_meal_app_the_final_version_with_implicit_animation/models/meal.dart';

// Provider() --> is great if we have static dummy data a list that never changes
// if we have more complex data that should change under certain circumstances,
// the Provider() class is the wrong choice, you should instead use the StateNotifierProvider
// and the StateNotifierProvider() works together with another class extends {StateNotifier}

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  // we want to fill this class with some life.
  // A --> initial value for this example, initially an empty list of meals.
  // B --> all the methods that should exist to change value,  to change that list in this case.
  // this is the initial value for list of meals, the initial value is an empty list
  FavoriteMealsNotifier() : super([]);

  // method to change the list of meals
  bool toggleMealFavoriteStatus(Meal meal) {
    // when using StateNotifier you're not allowed to edit an existing value in memory,
    // instead you must create a new one, so we aren't allowed to reach out to the empty list
    // and use .add, or .remove, this wouldn't be allowed, instead we have to replace it.
    // now to replace it, there is this globally available state property.
    // state --> this property is made available by the StateNotifier, this state property holds your data,
    // so in this case this state property holds list of meals, and again calling add, or remove like that
    // state.add(), state.remove() wouldn't be allowed instead you have to re-assign it by using
    // the assignment operator to a new list like that "state = List<Meal>", no mater if you adding a meal or removing a meal
    // Therefore, what we have to do here is first find out whether a meal is part of that list or not, and then thereafter,
    // we have to create a new list based on that information.
    final mealIsFavorite = state.contains(meal);
    if (mealIsFavorite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      // if the meals isn't favorite we add all previous elements in the meal and then adding new favorite meal in it,
      // we pull out and keep all the existing meals and add them to a new list, and we also add the new meal to that list.
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
  return FavoriteMealsNotifier();
});
