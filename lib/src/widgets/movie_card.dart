import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_movie/src/models/movie_model.dart';
import 'package:demo_movie/src/models/trending_movies_model.dart';
import 'package:demo_movie/src/utils/constants.dart';
import 'package:demo_movie/src/utils/urls.dart';
import 'package:demo_movie/src/utils/utils.dart';
import 'package:flutter/material.dart';

class MovieCard extends StatefulWidget {
  final Movie movie;
  final Function onTap;
  const MovieCard({Key? key, required this.movie, required this.onTap}) : super(key: key);

  @override
  _MovieCardState createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:(){
        widget.onTap();
      },
      child: CachedNetworkImage(
        height: screenHeight(context, dividedBy: 5),
        width: screenWidth(context, dividedBy: 3),
        imageUrl: widget.movie.posterPath != null
            ? Url.imagePathBaseUrl + widget.movie.posterPath!
            : "https://st3.depositphotos.com/23594922/31822/v/600/depositphotos_318221368-stock-illustration-missing-picture-page-for-website.jpg",
        fit: BoxFit.contain,
        imageBuilder: (context, img) {
          return Container(
            height: screenHeight(context, dividedBy: 5),
            width: screenWidth(context, dividedBy: 3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              image: DecorationImage(fit: BoxFit.cover, image: img),
            ),
            // child:ClipRRect(
            //   child: ,
            // )
          );
        },
        placeholder: (context, img) => Center(
          child: SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation(Constants.colors[0]),
            ),
          ),
        ),
        errorWidget: (_, s, d) => const Center(
          child: Icon(
            Icons.image_not_supported,
            size: 20,
            color: Colors.blueGrey,
          ),
        ),
      ),
    );
  }
}
