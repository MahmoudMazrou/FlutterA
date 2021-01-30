import 'package:flutter/material.dart';
import 'package:meal_app/widgets/categories_item.dart';
import '../dummy_data.dart';

class CategoriesScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView(
        padding: EdgeInsets.all(25),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,//العرض
          childAspectRatio: 3/2,//نسبة العرض لطول
            crossAxisSpacing: 20,//المسافة بين العناصر
          mainAxisSpacing: 20,//المسافة بين العناصر
        ),
        children: DUMMY_CATEGORIES.map((catDate) =>
        CategoryItem(catDate.id, catDate.title, catDate.color ),
        ).toList(),
      ),
    );
  }
  
}