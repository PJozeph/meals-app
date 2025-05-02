import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/filters_provider.dart';

class FilterScreen extends ConsumerWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterOptions = ref.watch(filterOptionsProvider);
    final _gluteinFreeFilterSet =
        filterOptions[FilterOptions.glutenFree] ?? false;
    final _lactoseFreeFilterSet =
        filterOptions[FilterOptions.lactoseFree] ?? false;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Filters"),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.save))],
      ),
      body: Column(
        children: [
          SwitchListTile(
            value: _gluteinFreeFilterSet,
            onChanged: (isChecked) {
              ref
                  .read(filterOptionsProvider.notifier)
                  .setFilter(FilterOptions.glutenFree, isChecked);
            },
            title: Text(
              "Gluten-Free",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              "Only include gluten-free meals.",
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 5,
            ),
          ),
          SwitchListTile(
            value: _lactoseFreeFilterSet,
            onChanged: (isChecked) {
              ref
                  .read(filterOptionsProvider.notifier)
                  .setFilter(FilterOptions.lactoseFree, isChecked);
            },
            title: Text(
              "Lactose-Free",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              "Only include lactose-free meals.",
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 5,
            ),
          ),
        ],
      ),
    );
  }
}
