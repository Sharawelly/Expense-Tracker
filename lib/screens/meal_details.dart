import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:num_31_meal_app_the_final_version_with_implicit_animation/models/meal.dart';
import 'package:num_31_meal_app_the_final_version_with_implicit_animation/providers/favorites_provider.dart';

class MealDetailsScreen extends ConsumerWidget {
  const MealDetailsScreen({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeals = ref.watch(favoriteMealsProvider);
    final isFavorite = favoriteMeals.contains(meal);
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {
              final wasAdded = ref
                  .read(favoriteMealsProvider.notifier)
                  .toggleMealFavoriteStatus(meal);
              // show a snackbar
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    wasAdded ? 'Meal added as a favorite.' : 'Meal removed.',
                  ),
                ),
              );
            },
            // we now want to add implicit animation
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              // transitionBuilder --> holds the information of which animation should play,
              // how we want to animate!
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  // in turn we can use the default animation by make it like that --> turns: animation,
                  // or we can use Tween() --> because Tween() gives us more control over between which values you want to animate
                  turns: Tween<double>(begin: 0.5, end: 1).animate(animation),
                  child: child,
                );
              },
              child: Icon(
                isFavorite ? Icons.star : Icons.star_border,
                // without key Flutter can't really detect whether anything changed, because sure,
                // I'm swapping the icon data instead of my icon, but it's technically still an icon widget and therefore an icon element that is visible on the screen.
                // And Flutter therefore doesn't see any difference. It doesn't explore the detailed data stored in this icon. It just sees that it was an icon widget before and that it's now still an icon widget.
                // So to make sure that Flutter is aware of this change, we should add a key to our icon here.
                // keys are always useful if you need to differentiate between two widgets that are of the same type,
                // but got different data attached to them, so here we must add a key because the AnimatedSwitcher will take that key into account to find out if we technically have a different widget than before,
                // even though the type might be the same.
                // And the key I will add here is a value key, which is isFavorite, and therefore it will indeed change between true and false and Flutter will therefore see that something changed here and will then trigger this animation.
                key: ValueKey(isFavorite),
              ),
            ),
          ),
        ],
      ),
      // SingleChildScrollView --> to make our screen scrollable, when also use ListView
      body: SingleChildScrollView(
        child: Column(
          children: [
            // we wrapped the target image in target screen with Hero()
            Hero(
              // same tag as start screen
              tag: meal.id,
              // Image.network --> load the images from url and the display them
              child: Image.network(
                meal.imageUrl,
                width: double.infinity,
                height: 300,
                // BoxFit.cover --> to make sure that the image is sized appropriately, but not distorted.
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(
              height: 14,
            ),
            for (final ingredient in meal.ingredients)
              Text(
                ingredient,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            const SizedBox(
              height: 24,
            ),
            Text(
              'Steps',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(
              height: 14,
            ),
            for (final step in meal.steps)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Text(
                  step,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
