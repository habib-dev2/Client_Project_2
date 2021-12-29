import 'package:flutter/material.dart';
import 'package:tesst/model/category.dart';
import 'package:tesst/screens/player.dart';

class AllCategories extends StatefulWidget {
  final List<Category>? categoryList;
  AllCategories({this.categoryList});
  @override
  _AllCategoriesState createState() => _AllCategoriesState();
}

class _AllCategoriesState extends State<AllCategories> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.0,
            ),
            itemCount: widget.categoryList!.length,
            itemBuilder: (context, index) {
              return AllCategory(
                id: this.widget.categoryList![index].id,
                name: this.widget.categoryList![index].name,
                icon: this.widget.categoryList![index].icon,
              );
            }));
  }
}

class AllCategory extends StatefulWidget {
  final int? id;
  final String? name;
  final String? icon;
  AllCategory({this.name, this.icon, this.id});
  @override
  _AllCategoryState createState() => _AllCategoryState();
}

class _AllCategoryState extends State<AllCategory> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AllVideoPlayer()));
        },
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    widget.icon!,
                    fit: BoxFit.fill,
                    height: 70,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12, left: 5,right: 5,bottom: 5),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black45
                ),
                height: 70,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  widget.name!,
                  style: const TextStyle(
                    fontSize: 21,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ));
  }
}
