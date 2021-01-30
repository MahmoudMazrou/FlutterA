import 'package:flutter/material.dart';
import 'package:meal_app/screens/meal_detail_screen.dart';
import '../models/meal.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final Function removeItem; //هاي عشان عند الضغط ع الحدف يرجع  الاي دي استخدمناها

  const MealItem({
    @required this.id,
    @required this.title,
    @required this.imageUrl,
    @required this.duration,
    @required this.complexity,
    @required this.affordability,
    @required this.removeItem,

  });

  String get complexityText{
    switch(complexity){
      case Complexity.Simple:return 'Simple';break;
      case Complexity.Challenging:return 'Challenging';break;
      case Complexity.Hard:return 'Hard';break;
      default:return 'Unknown'; break ;
    }
  }

  String get affordabilityText{
    switch(affordability){
      case Affordability.Affordable:return 'Affordably';break;
      case Affordability.Pricey:return 'Pricey';break;
      case Affordability.Luxurious:return 'Luxurious';break;
      default:return 'Unknown'; break ;
    }
  }
  void selectMeal(BuildContext ctx){
    Navigator.of(ctx).pushNamed(MealDetailScreen.routeName,
    arguments: id,
    ).then((result){if (result != null)removeItem(result) ;}); //الي بعد thin هينن استققبل id من ال pop وخزنو ب rusult اذ مش فارغ
  } //removeItemايضا مرر النتيجة ب

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:(){ selectMeal(context);} ,
      child:Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Stack( //بترتب العناصر فوق بعض بشاشة
              children: [
                ClipRRect(//هاد لضبط الصورة بلمكان الصحيح
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(imageUrl,height: 200,width: double.infinity,fit:BoxFit.cover,),
                ),
                Positioned(//عشان احط النص واحدد موقعو ببط
                  bottom: 20,
                  right: 10,
                  child: Container(
                    width: 300,
                    color: Colors.black54,
                    padding: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                    child: Text(
                      title,
                      style: TextStyle(fontSize: 26,color: Colors.white),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                )
              ],
            ),
            Padding(  //عشان هيكون اكثر من صف بينهن ابعاد معينة
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Icon(Icons.schedule),
                      SizedBox(width: 6,),//هاي عشان اعمل مسافة بين الايقونة ورقم
                      Text("$duration min"),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.work),
                      SizedBox(width: 6,),
                      Text("$complexityText"),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.attach_money),
                      SizedBox(width: 6,),
                      Text("$affordabilityText"),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ) ,
    );
  }
}
