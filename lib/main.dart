import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/screens/categories_meals_screen.dart';
import './screens/filters_screens.dart';
import 'package:meal_app/screens/meal_detail_screen.dart';
import 'package:meal_app/screens/tabs_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals =[];

  void _setFilters(Map<String,bool>_filterData){
    setState(() {
      _filters=_filterData;
      _availableMeals=DUMMY_MEALS.where((meal) {
        if(_filters['gluten'] && !meal.isGlutenFree){
          return false;
        };
        if(_filters['lactose'] && !meal.isLactoseFree){
          return false;
        }
        if(_filters['vegan'] && !meal.isVegan){
          return false;
        }
        if(_filters['vegetarian'] && !meal.isVegetarian){
          return false;
        }
        return true;
      }).toList();
    });

  }

  bool _isMealFavorite(String id){
    return _favoriteMeals.any((meal) => meal.id==id);
  }

  void _toggleFavorite(String mealId){ //فنكشن بتضيف او بتزيل العنصر
    //الindexWhere معناها اذ العنصر موجود يعني الشرط تحقق رجع رقم العنصر عشان ينحذف
    //وذ مش موجود بترجع -1  حينهابنعمل اضافة لأول عنصر يحقق الشرط بfirstWhere
    final existingIndex =_favoriteMeals.indexWhere((meal) => meal.id==mealId);
    if(existingIndex>=0){
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    }
    else{
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id==mealId));
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //ازالة الشريط الاحمر
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.pink, //اللون الاساسي
          accentColor: Colors.amber,
          canvasColor: Color.fromRGBO(255, 254, 229, 1), //لون البدي الفارغ
          textTheme: ThemeData.light().textTheme.copyWith(
                body1: TextStyle(
                  color: Color.fromRGBO(20, 50, 50, 1),
                ),
                body2: TextStyle(
                  color: Color.fromRGBO(20, 50, 50, 1),
                ),
                title: TextStyle(
                    fontSize: 20,
                    fontFamily: 'RobotoCondensed',
                    fontWeight: FontWeight.bold),
              )),

      // home: CategoriesScreen(),
      routes: {
        //عشان نعمل push
        '/': (context) => TabsScreen(_favoriteMeals),
        //احنا موجودين بلبداية هون
        CategoriesMealsScreen.routeName: (context) => CategoriesMealsScreen(_availableMeals),
        //هاي معناه عند الانتقال ل  routeName انقلني ل CategoriesMealsScreen
        MealDetailScreen.routeName: (context) => MealDetailScreen(_toggleFavorite,_isMealFavorite),
        FilterScreen.routeName: (context) => FilterScreen(_filters,_setFilters),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Meal App"),
        ),
        body: null);
  }
}
