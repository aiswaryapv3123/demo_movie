import 'package:demo_movie/src/models/movie_model.dart';
import 'package:demo_movie/src/models/trending_movies_model.dart';
import 'package:demo_movie/src/screens/movie_details_page.dart';
import 'package:demo_movie/src/utils/utils.dart';
import 'package:demo_movie/src/widgets/movie_card.dart';
import 'package:demo_movie/src/widgets/title_text.dart';
import 'package:flutter/material.dart';

class MovieTrendingList extends StatefulWidget {
  final List<Movie>? movieList;
  const MovieTrendingList({Key? key, this.movieList}) : super(key: key);

  @override
  _MovieTrendingListState createState() => _MovieTrendingListState();
}

class _MovieTrendingListState extends State<MovieTrendingList> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleText(title: "Trending"),
        // SizedBox(
        // height: screenHeight(context, dividedBy: 70),
        // ),
        widget.movieList == null
            ? Container()
            : Container(
                width: screenWidth(context),
                height: screenHeight(context, dividedBy: 4),
                child: ListView.builder(
                  itemCount: widget.movieList!.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, index) {
                    return Row(
                      children: [
                        MovieCard(
                          movie: widget.movieList![index],
                          onTap: () {
                            push(context,
                                route: MovieDetailsPage(
                                    movieData: widget.movieList![index]));
                          },
                        ),
                        SizedBox(
                          width: screenWidth(context, dividedBy: 30),
                        )
                      ],
                    );
                  },
                ),
              )
      ],
    ));
  }
}
