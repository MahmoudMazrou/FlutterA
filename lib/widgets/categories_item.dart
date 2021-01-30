import 'package:flutter/material.dart';
import '../screens/categories_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  final String id;

  final String title;
  final Color color;

  CategoryItem(this.id, this.title, this.color);

  void selectCategory(BuildContext ctx) {
    //هاي الدالة تنفد عند الضغط ع ال Category
    //لأنو حطيناها ب onTap
    Navigator.of(ctx).pushNamed(
      CategoriesMealsScreen.routeName ,//عرفنها ب main عند الاشارة الها وديني
      arguments: { //لتمرير البيانات
    'id': id,
    'title' :title,
    },

    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      //استخدمتها عشان فيها عند الضغط
      onTap: () {
        selectCategory(context);
      },
      splashColor: Theme
          .of(context)
          .primaryColor, //تأثير عند الضغط عليها واخدت اللون من الي معرفهن
      borderRadius: BorderRadius.circular(15), //عشان تأثير يظهر بنفس ابعاد

      child: Container(
        padding: EdgeInsets.all(15),
        child: Text(title,
            style: Theme
                .of(context)
                .textTheme
                .title), //style حددتو من الي عرفتو في ال المين
        decoration: BoxDecoration(
          //افضل  بعرض اللون هيك
          gradient: LinearGradient(
            //هاي لتدرج اللون
            colors: [
              color.withOpacity(0.4),
              color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
