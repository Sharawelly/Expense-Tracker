import 'package:flutter/material.dart';
import 'package:num_31_meal_app_the_final_version_with_implicit_animation/models/category.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem(
      {super.key, required this.category, required this.onSelectCategory});

  final Category category;
  final void Function() onSelectCategory;

  @override
  Widget build(BuildContext context) {
    // InkWell or GestureDetector --> to make this container or any other widget tappable
    // but InkWell has additional features like --> you get a nice visual feedback if a user taps the item
    return InkWell(
      onTap: onSelectCategory,
      // splashColor --> for this visual tapping effect that we get
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
      // Container --> gives me options to set background color or background decoration in general for this widget
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(0.55),
              category.color.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ),
    );
  }
}
