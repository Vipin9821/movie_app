import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/bloc/home_bloc/home_bloc.dart';
import 'package:movie_app/screens/movie_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home-screen';
  final HomeBloc _bloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    _bloc.add(GetHomeScreenContent());
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(color: Color(0xff132d4e)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: SafeArea(
                child: Scrollbar(
                  isAlwaysShown: true,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: size.width,
                          margin: const EdgeInsets.all(18),
                          child: ListTile(
                            title: Row(
                              children: [
                                Text(
                                  'Hello',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'user!',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Text(
                              'See Trending Movie Trailer.',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.5)),
                            ),
                            trailing: CircleAvatar(
                              backgroundImage: AssetImage('assets/image1.png'),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                          height: 110,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.all(18),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.deepOrangeAccent.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '''“Life is a banquet, and most poor suckers are starving to death!”''',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontFamily: GoogleFonts.lobster().fontFamily,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text('''-Auntie Mame, 1958'''),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                          margin: const EdgeInsets.all(18),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Trending',
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Movies',
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                icon: Icon(Icons.arrow_forward),
                                onPressed: () {},
                              )
                            ],
                          ),
                        ),
                        TrendingMovies(
                          size: size,
                          bloc: _bloc,
                        )
                        // Text(routeName),
                        // TextButton(
                        //     onPressed: () {
                        //       Navigator.of(context)
                        //           .push(MaterialPageRoute(builder: (context) {
                        //         return MyHomePage();
                        //       }));
                        //     },
                        //     child: Text('Video'))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TrendingMovies extends StatelessWidget {
  TrendingMovies({
    Key key,
    @required this.size,
    this.bloc,
  }) : super(key: key);
  final HomeBloc bloc;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is MovieDetailState) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return MovieDetailsPage(
                  data: state.detail,
                );
              },
            ));
          }
        },
        builder: (context, state) {
          print(state);
          if (state is HomeScreenContentLoadedState) {
            return Container(
              height: size.height * 0.5,
              // width: size.width * 0.8,
              child: Swiper(
                containerHeight: 500,
                containerWidth: 400,
                viewportFraction: 0.9,
                curve: Curves.bounceInOut,
                control: SwiperControl(),
                pagination: new SwiperPagination(
                  alignment: Alignment.bottomCenter,
                  builder: new DotSwiperPaginationBuilder(
                      color: Colors.grey, activeColor: Color(0xff38547C)),
                ),
                itemCount: 4,
                itemHeight: 500,
                itemWidth: 400,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      bloc.add(GetMovieDetails(
                          movieId: state.movieData[index].id.toString()));
                    },
                    child: Container(
                      margin: const EdgeInsets.all(15),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Material(
                          color: Colors.white.withOpacity(0.5),
                          elevation: 8.0,
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                  'https://image.tmdb.org/t/p/w500${state.movieData[index].posterPath}',
                                ),
                              ),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.transparent,
                                    Colors.black,
                                  ],
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8.2),
                                    decoration: BoxDecoration(
                                        color: Colors.amber,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Text(state
                                            .movieData[index].voteAverage
                                            .toString() +
                                        '/10'),
                                  ),
                                  Container(
                                    height: 95,
                                    alignment: Alignment.bottomCenter,
                                    width: size.width * 0.4,
                                    margin: const EdgeInsets.all(8.2),
                                    padding: const EdgeInsets.all(8.2),
                                    decoration: BoxDecoration(
                                        // color: Colors.amber,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Text(
                                      state.movieData[index].originalTitle
                                          .toString(),
                                      maxLines: 3,
                                      // overflow: Overflow.clip,
                                      style: TextStyle(
                                        fontSize: 25,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return CircularProgressIndicator();
        });
  }
}
