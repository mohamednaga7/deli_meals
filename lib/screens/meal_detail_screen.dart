import 'package:deli_meals/dummy_data.dart';
import 'package:deli_meals/models/meal.dart';
import 'package:deli_meals/models/meal_detail_screen_arguments.dart';
import 'package:flutter/material.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';

  final Function toggleFavorites;
  final Function isMealFavorite;

  const MealDetailScreen(
      {Key? key, required this.toggleFavorites, required this.isMealFavorite})
      : super(key: key);

  Widget buildSectionTitle(BuildContext context, String sectionTitle) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        sectionTitle.toUpperCase(),
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget buildContainer(BuildContext context, {required Widget child}) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      height: 150,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as MealDetailScreenArguments;
    final Meal selectedMeal =
        DUMMY_MEALS.firstWhere((meal) => meal.id == routeArgs.id);
    return Scaffold(
      appBar: AppBar(
        title: Text(routeArgs.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context, 'Ingredients'),
            buildContainer(context,
                child: ListView.builder(
                  itemBuilder: (ctx, index) => Card(
                    color: Theme.of(context).colorScheme.secondary,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Text(selectedMeal.ingredients[index]),
                    ),
                  ),
                  itemCount: selectedMeal.ingredients.length,
                )),
            buildSectionTitle(context, "Steps"),
            buildContainer(context,
                child: ListView.builder(
                  itemBuilder: (ctx, index) => Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Text('# ${(index + 1)}'),
                        ),
                        title: Text(selectedMeal.steps[index]),
                      ),
                      const Divider()
                    ],
                  ),
                  itemCount: selectedMeal.steps.length,
                ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
            isMealFavorite(selectedMeal.id) ? Icons.star : Icons.star_border),
        onPressed: () {
          toggleFavorites(selectedMeal.id);
        },
      ),
    );
  }
}
