import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_movie/src/models/get_movies_model.dart';
import 'package:demo_movie/src/models/movie_model.dart';
import 'package:demo_movie/src/models/trending_movies_model.dart' as trend;
import 'package:demo_movie/src/utils/constants.dart';
import 'package:demo_movie/src/utils/urls.dart';
import 'package:demo_movie/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

class MovieDetailsPage extends StatefulWidget {
  // final trend.Movie? movie;
  final Movie? movieData;
  const MovieDetailsPage(
      {Key? key,
      // this.movie,
      this.movieData})
      : super(key: key);

  @override
  _MovieDetailsPageState createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child:
            // widget.movie != null
            //     ? Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           CachedNetworkImage(
            //             width: screenWidth(context, dividedBy: 1),
            //             height: screenHeight(context, dividedBy: 2),
            //             imageUrl: widget.movie!.posterPath!= null ? Url.imagePathBaseUrl + widget.movie!.posterPath! : "https://st3.depositphotos.com/23594922/31822/v/600/depositphotos_318221368-stock-illustration-missing-picture-page-for-website.jpg",
            //             fit: BoxFit.cover,
            //             imageBuilder: (context, img) {
            //               return Container(
            //                 width: screenWidth(context, dividedBy: 1),
            //                 height: screenHeight(context, dividedBy: 2),
            //                 decoration: BoxDecoration(
            //                   // color:Colors.yellow,
            //                   // borderRadius: const BorderRadius.all(
            //                   //   Radius.circular(4),
            //                   // ),
            //                   image: DecorationImage(
            //                     fit: BoxFit.cover,
            //                     image: img,
            //                   ),
            //                 ),
            //               );
            //             },
            //             placeholder: (context, img) => Center(
            //               child: SizedBox(
            //                 width: 16,
            //                 height: 16,
            //                 child: CircularProgressIndicator(
            //                   strokeWidth: 2,
            //                   valueColor:
            //                       AlwaysStoppedAnimation(Constants.colors[0]),
            //                 ),
            //               ),
            //             ),
            //             errorWidget: (_, s, d) => const Center(
            //               child: Icon(
            //                 Icons.image_not_supported,
            //                 size: 20,
            //                 color: Colors.white,
            //               ),
            //             ),
            //           ),
            //           Padding(
            //             padding: EdgeInsets.symmetric(
            //                 horizontal: screenWidth(context, dividedBy: 30),
            //                 vertical: screenHeight(context, dividedBy: 40)),
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Text(
            //                   widget.movie!.title ?? widget.movie!.name ?? "",
            //                   style: TextStyle(
            //                     fontSize: 18,
            //                     fontWeight: FontWeight.bold,
            //                     color: Constants.colors[0],
            //                   ),
            //                 ),
            //                 widget.movie!.releaseDate != null
            //                     ? Text(
            //                         "Release ${DateFormat('dd/MM/yyyy').format(widget.movie!.releaseDate!)}",
            //                         style: TextStyle(
            //                           fontSize: 10,
            //                           fontWeight: FontWeight.bold,
            //                           color: Constants.colors[0],
            //                         ),
            //                       )
            //                     : Container(),
            //                 SizedBox(
            //                   height: screenHeight(context, dividedBy: 50),
            //                 ),
            //                 Text(
            //                   widget.movie!.overview ?? " ",
            //                   style: TextStyle(
            //                     fontSize: 12,
            //                     fontWeight: FontWeight.w400,
            //                     color: Constants.colors[0],
            //                   ),
            //                 ),
            //
            //                 SizedBox(
            //                   height: screenHeight(context, dividedBy: 50),
            //                 ),
            //                 Text(
            //                   "Rating : ${widget.movie!.voteAverage!}",
            //                   style: const TextStyle(
            //                     fontSize: 12,
            //                     fontWeight: FontWeight.w400,
            //                     color: Colors.blueGrey,
            //                   ),
            //                 ),
            //                 SizedBox(
            //                   height: screenHeight(context, dividedBy: 150),
            //                 ),
            //                 // Text("Genres : "+ widget.movieData.genres.toString(),
            //                 //   style: TextStyle(
            //                 //     fontSize: 12,
            //                 //     fontWeight: FontWeight.w400,
            //                 //     color: Colors.blueGrey,
            //                 //   ),),
            //               ],
            //             ),
            //           ),
            //         ],
            //       )
            //     :
            Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              width: screenWidth(context, dividedBy: 1),
              height: screenHeight(context, dividedBy: 2),
              imageUrl: widget.movieData!.posterPath != null
                  ? Url.imagePathBaseUrl + widget.movieData!.posterPath!
                  : "https://st3.depositphotos.com/23594922/31822/v/600/depositphotos_318221368-stock-illustration-missing-picture-page-for-website.jpg",
              fit: BoxFit.cover,
              imageBuilder: (context, img) {
                return Container(
                  width: screenWidth(context, dividedBy: 1),
                  height: screenHeight(context, dividedBy: 2),
                  decoration: BoxDecoration(
                    // color:Colors.yellow,
                    // borderRadius: const BorderRadius.all(
                    //   Radius.circular(4),
                    // ),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: img,
                    ),
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
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth(context, dividedBy: 30),
                  vertical: screenHeight(context, dividedBy: 40)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.movieData!.title ?? "",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Constants.colors[0],
                    ),
                  ),
                  widget.movieData!.releaseDate != null
                      ? Text(
                          "Release ${DateFormat('dd/MM/yyyy').format(widget.movieData!.releaseDate!)}",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Constants.colors[0],
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: screenHeight(context, dividedBy: 50),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: screenWidth(context, dividedBy: 10),
                        height: screenWidth(context, dividedBy: 10),
                        decoration: BoxDecoration(
                            color: widget.movieData!.voteAverage! > 6
                                ? Colors.deepPurple
                                : Colors.purple,
                            borderRadius: BorderRadius.circular(7)),
                        child: Center(
                          child: Text(
                            widget.movieData!.voteAverage != 0.0
                                ? "${widget.movieData!.voteAverage!}"
                                : "0",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: screenWidth(context, dividedBy: 40)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              height: screenHeight(context, dividedBy: 90)),
                          RatingBar.builder(
                            initialRating: widget.movieData!.voteAverage != null
                                ? ((widget.movieData!.voteAverage!) / 2)
                                    .toDouble()
                                : 0.0,
                            minRating: 0,
                            direction: Axis.horizontal,
                            allowHalfRating: false,
                            unratedColor: Constants.colors[0].withOpacity(0.3),
                            itemCount: 5,
                            itemSize: 10,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 0.0),
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
                          SizedBox(
                            height: screenHeight(context, dividedBy: 200),
                          ),
                          Text(
                            "${widget.movieData!.voteCount!} ratings ",
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: screenHeight(context, dividedBy: 90),
                  ),
                  Text(
                    "${widget.movieData!.genreId1}",
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.blueGrey,
                    ),
                  ),
                  Text(
                    "${widget.movieData!.genreId2}",
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.blueGrey,
                    ),
                  ),
                  // Text(
                  //   "${widget.movieData!.genreId3}",
                  //   style: const TextStyle(
                  //     fontSize: 12,
                  //     fontWeight: FontWeight.w400,
                  //     color: Colors.blueGrey,
                  //   ),
                  // ),
                  SizedBox(
                    height: screenHeight(context, dividedBy: 90),
                  ),
                  Text(
                    widget.movieData!.overview ?? " ",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Constants.colors[0],
                    ),
                  ),

                  SizedBox(
                    height: screenHeight(context, dividedBy: 50),
                  ),
                  // Row(
                  //   children: [
                  //     Text(
                  //       "Ratings : ${widget.movieData!.voteCount!}",
                  //       style: const TextStyle(
                  //         fontSize: 12,
                  //         fontWeight: FontWeight.w400,
                  //         color: Colors.blueGrey,
                  //       ),
                  //     ),
                  //     // SizedBox(width:screenWidth(context, dividedBy: 30)),
                  //     RatingBar.builder(
                  //       initialRating: widget.movieData!.voteAverage != null
                  //           ? ((widget.movieData!.voteAverage!) / 2).toDouble()
                  //           : 0.0,
                  //       minRating: 0,
                  //       direction: Axis.horizontal,
                  //       allowHalfRating: false,
                  //       unratedColor: Constants.colors[0].withOpacity(0.3),
                  //       itemCount: 5,
                  //       itemSize: 10,
                  //       itemPadding:
                  //           const EdgeInsets.symmetric(horizontal: 0.0),
                  //       itemBuilder: (context, _) => Icon(
                  //         Icons.star,
                  //         color: Constants.colors[0],
                  //         size: 2,
                  //       ),
                  //       onRatingUpdate: (rating) {
                  //         print(rating);
                  //         // setState(() {
                  //         //   this.rating = widget.movie.voteAverage != null ? widget.movie.voteAverage!.toDouble() : 0.0;
                  //         // });
                  //       },
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: screenHeight(context, dividedBy: 150),
                  // ),
                  // Text("Genres : "+ widget.movieData.genres.toString(),
                  //   style: TextStyle(
                  //     fontSize: 12,
                  //     fontWeight: FontWeight.w400,
                  //     color: Colors.blueGrey,
                  //   ),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
