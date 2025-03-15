import 'package:flutter/material.dart';
import 'package:num_31_meal_app_the_final_version_with_implicit_animation/models/meal.dart';
import 'package:num_31_meal_app_the_final_version_with_implicit_animation/widgets/meal_item_trait.dart';

import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({
    super.key,
    required this.meal,
    required this.onSelectMeal,
  });
  final Meal meal;
  final void Function(Meal meal) onSelectMeal;

  String get complexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      // clipBehavior --> the stack by default, ignores the shape I might have setup here on this card
      // so we have to add settings to enforce this shape here
      // and ensures that any content that would go out of the shape is simply cut off.
      // and this can be done by setting the clipBehavior on the card to Clip.hardEdge.
      // and this simply clip this card widget removing any content of child widgets,
      // that would go outside of shape boundaries of this card widget.
      clipBehavior: Clip.hardEdge,
      // elevation --> to add slight drop shadow behind tha card and give this card some elevation,
      // some 3D effect
      elevation: 2,
      child: InkWell(
        onTap: () {
          onSelectMeal(meal);
        },
        // Stack --> this widget can be used to position multiple widgets directly above each other,
        // so that we can, for example, set an image as a background and have some text on top of it.
        child: Stack(
          children: [
            // Hero --> to animate widgets across different widgets, across different screen
            // Two steps for using Hero():
            // 1) First, we wrap this image with `Hero()`, and this now is the image we came from (start screen).
            // 2) Next, we need to wrap the same image in the target screen (Meal Details Screen) with `Hero()` as well.
            // We want to wrap the image that we are going to with `Hero()`.
            Hero(
              // tag --> used for identifying a widget on this screen and on the target screen
              tag: meal.id,
              // it's not popping in, which can be quite ugly But it's smoothly faded in.
              // FadeInImage --> display an image that's being faded in so that when the image is loaded,
              child: FadeInImage(
                // Placeholder → The image will be displayed initially before the actual image is fetched.
                // MemoryImage --> knows how to load image from memory
                placeholder: MemoryImage(
                  // imported from 'package:transparent_image/transparent_image.dart';
                  kTransparentImage,
                ),
                // NetworkImage --> image fetched from internet.
                image: NetworkImage(meal.imageUrl),
                // BoxFit.cover --> to make sure the image is never distorted,
                // but instead, cut off and zoomed in a bit if it wouldn't fit into this box otherwise.
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
            // Position a widget on another widget
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                // Colors.black45 --> this black color is slightly transparent black background,
                // to make sure that my meal title and the metadata is always readable,
                // because of course, the background images "NetworkImages" could be very different,
                // and Therefore, I wouldn't know how to color the text that sits on top of them
                // whilst ensuring that it's always readable, and that's why I'm using this container,
                // which always assign this slightly transparent black background to my texts.
                color: Colors.black45,
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      // overflow --> controls how the text will be cut off if it needs to be cut off,
                      // because it's too long, for example, because it would take more than two lines
                      // ellipsis --> Very long text will be cut off by adding three dots {...}
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      // mainAxisAlignment in a Row for horizontal axis "from left to right"
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemTrait(
                          icon: Icons.schedule,
                          label: '${meal.duration} min',
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        MealItemTrait(
                          icon: Icons.work,
                          label: complexityText,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        MealItemTrait(
                          icon: Icons.attach_money,
                          label: affordabilityText,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
