import 'package:deli_meals/models/category_meals_screen_arguments.dart';
import 'package:deli_meals/models/meal.dart';
import 'package:deli_meals/widgets/meal_item.dart';
import 'package:flutter/material.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';
  final List<Meal> meals;
  const CategoryMealsScreen({Key? key, required this.meals}) : super(key: key);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  late String categoryTitle;
  late List<Meal> displayedMeals;
  bool _initializing = true;

  @override
  void didChangeDependencies() {
    if (_initializing) {
      final routeArgs = ModalRoute.of(context)!.settings.arguments
          as CategoryMealsScreenArguments;
      categoryTitle = routeArgs.title;
      final categoryId = routeArgs.id;
      displayedMeals = widget.meals
          .where((meal) => meal.categories.contains(categoryId))
          .toList();
      _initializing = false;
    }

    super.didChangeDependencies();
  }

  void removeMeal(String mealId) {
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(categoryTitle)),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            meal: displayedMeals[index],
            removeMeal: removeMeal,
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
