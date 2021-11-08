import 'package:deli_meals/dummy_data.dart';
import 'package:deli_meals/models/filters.dart';
import 'package:deli_meals/models/meal.dart';
import 'package:deli_meals/screens/category_meals_screen.dart';
import 'package:deli_meals/screens/filters_screen.dart';
import 'package:deli_meals/screens/meal_detail_screen.dart';
import 'package:deli_meals/screens/tabs_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Filters _filters = Filters(
      lactoseFree: false, glutenFree: false, vegan: false, vegetarian: false);

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  bool isMealFound(List<Meal> _mealsList, String mealId) {
    return _mealsList.any((meal) => meal.id == mealId);
  }

  void _toggleFavorites(String mealId) {
    if (isMealFound(_favoriteMeals, mealId)) {
      setState(() {
        _favoriteMeals =
            _favoriteMeals.where((meal) => meal.id != mealId).toList();
      });
    } else {
      setState(() {
        _favoriteMeals
            .add(_availableMeals.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  void _setFilters(Filters filterData) {
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters.glutenFree && !meal.isGlutenFree) return false;
        if (_filters.lactoseFree && !meal.isLactoseFree) return false;
        if (_filters.vegan && !meal.isVegan) return false;
        if (_filters.vegetarian && !meal.isVegetarian) return false;
        return true;
      }).toList();
    });
  }

  bool _isMealFavorite(String id) {
    return isMealFound(_favoriteMeals, id);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData(
        primarySwatch: Colors.pink,
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyText1: const TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            bodyText2: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
            headline6: const TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
                letterSpacing: 1)));
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(secondary: Colors.amber),
      ),
      routes: {
        '/': (ctx) => TabsScreen(favorites: _favoriteMeals),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(meals: _availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(
            toggleFavorites: _toggleFavorites, isMealFavorite: _isMealFavorite),
        FiltersScreen.routeName: (ctx) => FiltersScreen(
              filters: _filters,
              setFilters: _setFilters,
            )
      },
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
            builder: (ctx) => TabsScreen(
                  favorites: _favoriteMeals,
                ));
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
            builder: (ctx) => TabsScreen(
                  favorites: _favoriteMeals,
                ));
      },
    );
  }
}
