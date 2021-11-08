import 'package:deli_meals/models/filters.dart';
import 'package:deli_meals/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Filters filters;
  final Function(Filters) setFilters;
  const FiltersScreen(
      {Key? key, required this.setFilters, required this.filters})
      : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  Filters _filters = Filters(
      lactoseFree: false, glutenFree: false, vegan: false, vegetarian: false);

  @override
  initState() {
    _filters = widget.filters;
    super.initState();
  }

  Widget _buildSwitchListTile(
      {required String title,
      required String description,
      required bool currentValue,
      required Function(bool) updateValue}) {
    return SwitchListTile.adaptive(
      title: Text(title),
      value: currentValue,
      onChanged: updateValue,
      subtitle: Text(description),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
        actions: [
          IconButton(
              onPressed: () {
                widget.setFilters(_filters);
              },
              icon: const Icon(Icons.save))
        ],
      ),
      drawer: const MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection.',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              _buildSwitchListTile(
                  title: 'Gluten-Free',
                  description: 'Only include gluten free meals',
                  currentValue: _filters.glutenFree,
                  updateValue: (value) {
                    setState(() {
                      _filters.glutenFree = value;
                    });
                  }),
              _buildSwitchListTile(
                  title: 'Lactose-Free',
                  description: 'Only include lactose free meals',
                  currentValue: _filters.lactoseFree,
                  updateValue: (value) {
                    setState(() {
                      _filters.lactoseFree = value;
                    });
                  }),
              _buildSwitchListTile(
                  title: 'Vegetarian',
                  description: 'Only include vegetarian meals',
                  currentValue: _filters.vegetarian,
                  updateValue: (value) {
                    setState(() {
                      _filters.vegetarian = value;
                    });
                  }),
              _buildSwitchListTile(
                  title: 'Vegan',
                  description: 'Only include vegan meals',
                  currentValue: _filters.vegan,
                  updateValue: (value) {
                    setState(() {
                      _filters.vegan = value;
                    });
                  })
            ],
          ))
        ],
      ),
    );
  }
}
