import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/widgets/meal_item.dart';
//import '../dummy_data.dart';  كنا معرفينو لمن كنا نوخد من الميل مباشرة سرنا نوخد من هديك عشان الفلتر

class CategoriesMealsScreen extends StatefulWidget {
  static const routeName = 'category_mealse'; //عرفت الاسم بداخل متغير عشان ما اخطأ بيها

  final List<Meal> availableMeals;

  CategoriesMealsScreen(this.availableMeals);

  @override
  _CategoriesMealsScreenState createState() => _CategoriesMealsScreenState();
}

class _CategoriesMealsScreenState extends State<CategoriesMealsScreen> {
  String categoryTitle;  //عرفناهن هين عشان نقدر نستخدمهم بلودجت
  List<Meal> displayedMeals ;

  @override
  void didChangeDependencies() {  //هاي الميثود بتتنفد قبل تنفيدWidget كل متفتحها لتحديث
    final routeArg = ModalRoute.of(context).settings.arguments
    as Map<String, String>; //عشان استخرج المعلومات المبعوتة
    final categoryId = routeArg['id']; // استخرجت id
     categoryTitle = routeArg['title']; //استخرجت title
    //هاي معناها اني عملت ليست من ليستت ال MEALS ولكن بشرط cateforyId
     displayedMeals = widget.availableMeals.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();    super.didChangeDependencies();
  }
  void _removeItem (String mealId){  //هاي هي مثود الازالة لل عنصر من meal
    setState(() { // بنبحث ب displayedMeals عن الاي دي الراجع من البووب ومخزن عنا وبنحذفها
      displayedMeals.removeWhere((meal) => meal.id == mealId); //طبعا في شرط
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayedMeals[index].id,
            title: displayedMeals[index].title,
            imageUrl: displayedMeals[index].imageUrl,
            duration: displayedMeals[index].duration,
            complexity:displayedMeals[index].complexity,
            affordability: displayedMeals[index].affordability,
              removeItem:_removeItem,
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
