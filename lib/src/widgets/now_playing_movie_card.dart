import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_movie/src/models/get_movies_model.dart';
import 'package:demo_movie/src/models/movie_model.dart';
import 'package:demo_movie/src/utils/constants.dart';
import 'package:demo_movie/src/utils/urls.dart';
import 'package:demo_movie/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class NowPlayingMovieCard extends StatefulWidget {
  final Movie movie;
  final Function onTap;
  const NowPlayingMovieCard(
      {Key? key, required this.movie, required this.onTap})
      : super(key: key);

  @override
  _NowPlayingMovieCardState createState() => _NowPlayingMovieCardState();
}

class _NowPlayingMovieCardState extends State<NowPlayingMovieCard> {
  double rating = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      child: SizedBox(
        width: screenWidth(context, dividedBy: 2),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              height: screenHeight(context, dividedBy: 7),
              width: screenWidth(context, dividedBy: 2),
              imageUrl: widget.movie.posterPath != null
                  ? Url.imagePathBaseUrl + widget.movie.posterPath!
                  : "https://st3.depositphotos.com/23594922/31822/v/600/depositphotos_318221368-stock-illustration-missing-picture-page-for-website.jpg",
              fit: BoxFit.contain,
              imageBuilder: (context, img) {
                return Container(
                  height: screenHeight(context, dividedBy: 7),
                  width: screenWidth(context, dividedBy: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    image: DecorationImage(fit: BoxFit.cover, image: img),
                  ),
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
            SizedBox(
              height: screenHeight(context, dividedBy: 90),
            ),
            Text(
              widget.movie.title ?? "No name",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(
              height: screenHeight(context, dividedBy: 130),
            ),
            Row(
              children: [
                Text(
                  "Rating : ",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  widget.movie.voteAverage.toString(),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Spacer(),
                RatingBar.builder(
                  initialRating: widget.movie.voteAverage != null ? ((widget.movie.voteAverage!)/2).toDouble() : 0.0,
                  minRating: 0,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  unratedColor: Constants.colors[0].withOpacity(0.3),
                  itemCount: 5,
                  itemSize: 10,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Constants.colors[0],
                    size: 2,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                    // setState(() {
                    //   this.rating = widget.movie.voteAverage != null ? widget.movie.voteAverage!.toDouble() : 0.0;
                    // });
                  },
                ),
                SizedBox(width:screenWidth(context, dividedBy: 30))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
