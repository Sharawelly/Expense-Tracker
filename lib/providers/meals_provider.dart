import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:num_31_meal_app_the_final_version_with_implicit_animation/data/dummy_data.dart';

// We now set up a provider, and with that provider set up, we can now use it in widgets that need the data that is provided by this provider.

// So in this case, we can use this provider in widgets that need our meals. In this application, that would, for example, be the tabs.dart file and the tabs screen because,
// in this tabs.dart file, specifically in the tabs screen state, I'm using these dummy meals in the build method to derive my available meals based on the filters that were set.

final mealsProvider = Provider((ref) {
  return dummyMeals;
});
