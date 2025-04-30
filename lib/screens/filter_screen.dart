import 'dart:nativewrappers/_internal/vm/lib/internal_patch.dart';

import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _FilterScreenState();
  }
}

enum FilterOptions { glutenFree, lactoseFree }

class _FilterScreenState extends State<FilterScreen> {
  var _gluteinFreeFilterSet = false;
  var _lactoseFreeFilterSet = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Filters"),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.save))],
      ),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, dynamic result) {
          if (didPop) {
            return; // CANCEL ANY USER-DRIVEN POP EVENT
          }
          // PROGRAMMATIC POP EVENT WITH DATA
          Navigator.of(context).pop({
            FilterOptions.glutenFree: _gluteinFreeFilterSet,
            FilterOptions.lactoseFree: _lactoseFreeFilterSet,
          });
        },
        child: Column(
          children: [
            SwitchListTile(
              value: _gluteinFreeFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _gluteinFreeFilterSet = isChecked;
                });
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
                setState(() {
                  _lactoseFreeFilterSet = isChecked;
                });
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
      ),
    );
  }
}
