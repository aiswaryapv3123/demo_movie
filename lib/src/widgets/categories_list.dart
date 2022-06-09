import 'package:demo_movie/src/bloc/bloc.dart';
import 'package:demo_movie/src/bloc/states.dart';
import 'package:demo_movie/src/models/get_genres_model.dart';
import 'package:demo_movie/src/utils/utils.dart';
import 'package:demo_movie/src/widgets/build_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({Key? key}) : super(key: key);

  @override
  _CategoriesListState createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  List<String> cats = [
    "Drama",
    "Action",
    "Thriller",
    "Classic",
    "Comedy",
    "Adventure"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth(context),
      // height: screenHeight(context, dividedBy:2),
      child: Column(
        children: [
          Container(
            width: screenWidth(context),
            height: screenHeight(context, dividedBy: 20),
            child: ListView.builder(
              itemCount: cats.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, index) {
                return Row(
                  children: [
                    BuildButton(label: cats[index], onTap: () {}),
                    SizedBox(
                      width: screenWidth(context, dividedBy: 50),
                    )
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
