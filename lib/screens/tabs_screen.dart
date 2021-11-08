import 'package:deli_meals/models/meal.dart';
import 'package:deli_meals/screens/categories_screen.dart';
import 'package:deli_meals/screens/favorites_screen.dart';
import 'package:deli_meals/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class _ScreenPage {
  final String title;
  final Widget page;

  const _ScreenPage({required this.title, required this.page});
}

class TabsScreen extends StatefulWidget {
  final List<Meal> favorites;
  const TabsScreen({Key? key, required this.favorites}) : super(key: key);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late List<_ScreenPage> _pages;

  @override
  initState() {
    _pages = [
      const _ScreenPage(title: 'Categories', page: CategoriesScreen()),
      _ScreenPage(
          title: 'Your Favorites',
          page: FavoritesScreen(favorites: widget.favorites))
    ];
    super.initState();
  }

  int _currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MainDrawer(),
      appBar: AppBar(
        title: Text(_pages[_currentPageIndex].title),
      ),
      body: _pages[_currentPageIndex].page,
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentPageIndex,
          onTap: _selectItem,
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.white,
          selectedItemColor: Theme.of(context).colorScheme.secondary,
          items: const [
            BottomNavigationBarItem(
                label: 'Categories', icon: Icon(Icons.category)),
            BottomNavigationBarItem(label: 'Favorites', icon: Icon(Icons.star))
          ]),
    );
  }

  void _selectItem(int value) {
    setState(() {
      _currentPageIndex = value;
    });
  }
}
