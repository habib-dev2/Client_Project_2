import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tesst/model/category.dart';
import 'package:tesst/services/category_services.dart';
import 'package:tesst/widgets/all_category.dart';

class CategoryList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  List<Category> _categoryList = [];
  CategoryService _categoryService = CategoryService();

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // _getAllCategories();
  }

  // _getAllCategories() async {
  //   var categories = await _categoryService.getCategories();
  //   var result = json.decode(categories.body);

  //   result['data'].forEach((data) {
  //     var model = Category();
  //     model.id = data["id"];
  //     model.name = data["name"];
  //     model.icon = data["icon"];
  //     setState(() {
  //       _categoryList.add(model);
  //       isLoading = false;
  //     });
  //   });
  //   //print(result);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Discover"),
        ),
        body: isLoading
            ? Center(
                child: CupertinoActivityIndicator(
                radius: 15,
              ))
            : Container(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: AllCategories(
                    categoryList: _categoryList,
                  ),
                ),
              ));
  }
}
