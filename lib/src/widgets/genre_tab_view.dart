import 'package:demo_movie/src/bloc/bloc.dart';
import 'package:demo_movie/src/bloc/events.dart';
import 'package:demo_movie/src/bloc/states.dart';
import 'package:demo_movie/src/models/genres_model.dart';
import 'package:demo_movie/src/utils/constants.dart';
import 'package:demo_movie/src/utils/utils.dart';
import 'package:demo_movie/src/widgets/build_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GenreTabView extends StatefulWidget {
  final ValueChanged<String> onTapItem;
  const GenreTabView({Key? key, required this.onTapItem}) : super(key: key);

  @override
  _GenreTabViewState createState() => _GenreTabViewState();
}

class _GenreTabViewState extends State<GenreTabView> {
  final MovieBloc genreBloc = MovieBloc();
  String selectedIndex = '12';
  int tabIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    genreBloc.add(GenresData());
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => genreBloc,
      child: BlocBuilder<MovieBloc, MovieStates>(
          builder: (BuildContext context, MovieStates state) {
        if (state is GenresErrorState) {
          return Container(
            height: screenHeight(context, dividedBy: 7),
            width: screenWidth(context, dividedBy: 2),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Constants.colors[3]),
            child: Center(
              child: Text(state.error.toString(),
                  style: Theme.of(context).textTheme.bodyText1),
            ),
          );
        }
        if (state is GenresLoadedState) {
          List<GenresModel> genreList = state.genresData;
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: screenHeight(context, dividedBy: 20),
            child: genreList.isNotEmpty
                ? ListView.builder(
                    itemCount: genreList.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    // physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (ctx, index) {
                      return Row(
                        children: [
                          BuildButton(
                            label: genreList[index].name ?? "",
                            selectedColor: index == tabIndex
                                ? Colors.black54
                                : Constants.colors[3],
                            onTap: () {
                              setState(() {
                                tabIndex = index;
                                selectedIndex =
                                    genreList[index].gid.toString();
                              });
                              widget.onTapItem(selectedIndex);
                            },
                          ),
                          SizedBox(
                            width: screenWidth(context, dividedBy: 60),
                          ),
                        ],
                      );
                    },
                  )
                : Container(),
          );
        }
        return SizedBox(
          width: screenWidth(context, dividedBy: 1),
          height: screenHeight(context, dividedBy: 7),

          // color: Colors.white,
          child: const Center(
            child: SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.white,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
