import 'package:flutter/material.dart';
import 'package:num_31_meal_app_the_final_version_with_implicit_animation/data/dummy_data.dart';
import 'package:num_31_meal_app_the_final_version_with_implicit_animation/models/category.dart';
import 'package:num_31_meal_app_the_final_version_with_implicit_animation/models/meal.dart';
import 'package:num_31_meal_app_the_final_version_with_implicit_animation/screens/meals.dart';
import 'package:num_31_meal_app_the_final_version_with_implicit_animation/widgets/category_grid_item.dart';

// if you want to add an explicit animation to a widget in a class you must convert this class to StatefulWidget
// because if you are adding an explicit animation to a widget you must added to the state object of that widget,
// because an animations sets the state and updates the UI all the time, as long as the animation is playing,
// which is why it needs such a StatelessWidget, so that it can update some state behind the scenes and re-execute the build method
class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.availableMeals});
  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

// SingleTickerProviderStateMixin --> if you have only single animation controller
// TickerProviderStateMixin --> if you have multiple animation controllers
class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      // vsync --> making sure that this animation executes for every frame
      // So, typically 60 times per second to overall provide a smooth animation.
      vsync: this,
      duration: const Duration(microseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );
    // forward() --> to start the animation and played to its end
    _animationController.forward();
  }

  // dispose() --> called automatically to perform cleanup work.
  @override
  void dispose() {
    // _animationController.dispose() --> makes sure that this animation controller is removed from the device memory
    // once this widget here is removed, to make sure we don't cause any memory overflows or anything like this.
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final List<Meal> filteredMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    // Navigator --> to move to different screen, navigate to a different screen
    // to navigate to different screen use push method
    // now when we push this screen "MealsScreen" this screen will be in the top of stack of pages
    // and since it would therefore be the topmost screen, it would be the screen users see!!
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
        ),
      ),
    ); // Navigator.of(context).push(route) == Navigator.push(context, route)
  }

  @override
  Widget build(BuildContext context) {
    // GridView --> rendering a grid of items,
    // like listView.builder there is GridView.builder which would allow you to build the grid dynamically,
    // if we had a potential very long list of grid items, to get this possible performance optimization of only rendering what's visible.
    return AnimatedBuilder(
      animation: _animationController,
      // child --> to set any widgets that maybe should be output as a part of the animated content, but that shouldn't be animated themselves.
      // and this will improve the performance of an animation by making sure that not all items that are part of the animated item are rebuilt
      // and re-evaluated as long as the animation is running
      child: GridView(
        padding: const EdgeInsets.all(24),
        // gridDelegate --> controls the layout of the GridView items {Controls how the grid items are arranged.}
        // SliverGridDelegateWithFixedCrossAxisCount --> to set the number of columns {Specifies a fixed number of columns.}
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          // number of columns = 2
          crossAxisCount: 2,
          // childAspectRatio --> the sizing of those GridView items
          // Controls the width-to-height ratio of each grid item (Width = 3, Height = 2).
          childAspectRatio: 3 / 2,
          // crossAxisSpacing --> to have some spacing between the items --> Horizontal spacing (space between columns)
          crossAxisSpacing: 20,
          // mainAxisSpacing --> to have some spacing between the items --> Vertical spacing (space between rows)
          mainAxisSpacing: 20,
        ),
        children: [
          // this for loop is an alternative way to using this --> ...availableCategories.map((category) => CategoryGridItem(category: category)).toList()
          for (final category in availableCategories)
            CategoryGridItem(
              category: category,
              onSelectCategory: () {
                _selectCategory(context, category);
              },
            )
        ],
      ),
      // SlideTransition --> to animate the movement of a widget from one position to another
      builder: (context, child) => SlideTransition(
        position: Tween(
          begin: const Offset(0, 0.3),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        ),
        child: child,
      ),
    );
  }
}
