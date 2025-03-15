import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:num_31_meal_app_the_final_version_with_implicit_animation/providers/filters_provider.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  // @override
  // void initState() {
  //   super.initState();
  //   And here, I'm using read instead of watch because initState is only executed once anyways.
  //   So setting up a listener here doesn't make too much sense since this code won’t run again unless the widget is removed and re-added.
  //   final activeProvider = ref.read(filtersProvider);
  //   we don't need to call setState because as we know initState will run before the build methods executes anyways.
  //   so those new values are the values that will be available once the build methods executes without calling setState here.
  //   _glutenFreeFilterSet = activeProvider[Filter.glutenFree]!;
  //   _lactoseFreeFilterSet = activeProvider[Filter.lactoseFree]!;
  //   _vegetarianFilterSet = activeProvider[Filter.vegetarian]!;
  //   _veganFilterSet = activeProvider[Filter.vegan]!;
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // here we used watch instead of read because watch setup a listener that re-execute the build method
    // whenever the state in the provider changes, So whenever a filter changes for example,
    // and I want to re-execute the build method in that case to update my switchTiles correctly.

    final activeFilters = ref.watch(filtersProvider);
    // return a Scaffold because this is a brand new screen and there for it gets its own Scaffold
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      body: Column(
        children: [
          // SwitchListTile --> optimized for being presented in a list, where you can set a label for every switch,
          // but you will then also have that switch widget that can be tapped by the user to turn something on or off.
          SwitchListTile(
            value: activeFilters[Filter.glutenFree]!,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.glutenFree, isChecked);
            },
            title: Text(
              'Gluten-free',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text(
              'Only include gluten-free meals.',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            // activeColor --> allows us to control which color will be used for rendering this switch,
            // if it's activated, if it's turned on
            activeColor: Theme.of(context).colorScheme.tertiary,
            // contentPadding --> control how much padding will be used inside of this listTile
            contentPadding: const EdgeInsets.only(
              left: 34,
              right: 22,
            ),
          ),
          // SwitchListTile --> optimized for being presented in a list, where you can set a label for every switch,
          // but you will then also have that switch widget that can be tapped by the user to turn something on or off.
          SwitchListTile(
            value: activeFilters[Filter.lactoseFree]!,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.lactoseFree, isChecked);
            },
            title: Text(
              'Lactose-free',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text(
              'Only include lactose-free meals.',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            // activeColor --> allows us to control which color will be used for rendering this switch,
            // if it's activated, if it's turned on
            activeColor: Theme.of(context).colorScheme.tertiary,
            // contentPadding --> control how much padding will be used inside of this listTile
            contentPadding: const EdgeInsets.only(
              left: 34,
              right: 22,
            ),
          ),
          // SwitchListTile --> optimized for being presented in a list, where you can set a label for every switch,
          // but you will then also have that switch widget that can be tapped by the user to turn something on or off.
          SwitchListTile(
            value: activeFilters[Filter.vegetarian]!,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegetarian, isChecked);
            },
            title: Text(
              'Vegetarian',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text(
              'Only include vegetarians meals.',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            // activeColor --> allows us to control which color will be used for rendering this switch,
            // if it's activated, if it's turned on
            activeColor: Theme.of(context).colorScheme.tertiary,
            // contentPadding --> control how much padding will be used inside of this listTile
            contentPadding: const EdgeInsets.only(
              left: 34,
              right: 22,
            ),
          ),
          // SwitchListTile --> optimized for being presented in a list, where you can set a label for every switch,
          // but you will then also have that switch widget that can be tapped by the user to turn something on or off.
          SwitchListTile(
            value: activeFilters[Filter.vegan]!,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegan, isChecked);
            },
            title: Text(
              'Vegan',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text(
              'Only include Vegan   meals.',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            // activeColor --> allows us to control which color will be used for rendering this switch,
            // if it's activated, if it's turned on
            activeColor: Theme.of(context).colorScheme.tertiary,
            // contentPadding --> control how much padding will be used inside of this listTile
            contentPadding: const EdgeInsets.only(
              left: 34,
              right: 22,
            ),
          ),
        ],
      ),
    );
  }
}
