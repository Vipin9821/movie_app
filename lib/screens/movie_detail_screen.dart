import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_app/models/model.dart';
import 'package:movie_app/repositories/api/api.dart';
import 'package:movie_app/screens/video_screen.dart';

class MovieDetailsPage extends StatelessWidget {
  static const routeName = 'movie-details-page';

  final MovieModel data;
  MovieDetailsPage({this.data});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                height: 400,
                width: size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        'https://image.tmdb.org/t/p/w500' + data.posterPath),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      end: Alignment.bottomCenter,
                      begin: Alignment.topCenter,
                      colors: [
                        Colors.transparent,
                        Color(0xff091627),
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.arrow_back),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )
                          ],
                        ),
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () async {
                            var key =
                                await Api().getVideoLink(data.id.toString());
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return PlayerScreen(
                                videoId: key,
                              );
                            }));
                          },
                          child: CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.white,
                            // alignment: Alignment.center,
                            child: Center(
                              child: Icon(
                                Icons.play_arrow,
                                color: Colors.red,
                                size: 75,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.originalTitle,
                            style: TextStyle(
                              fontSize: 30,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8.2),
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(15)),
                            child: Text(
                              data.voteAverage.toString() + '/10',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Overview',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      data.overview,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.all(30),
                // height: 100,
                // color: Colors.grey,
                width: size.width,
                alignment: Alignment.center,
                child: Row(
                  // main,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Icon(Icons.date_range_sharp),
                          Text(data.releaseDate.toString()),
                        ],
                      ),
                    ),
                    Divider(),
                    Container(
                      child: Column(
                        children: [
                          Icon(Icons.timeline),
                          Text(data.runtime.toString() + ' min'),
                        ],
                      ),
                    ),
                    Divider(),
                    Container(
                      child: Column(
                        children: [
                          Icon(Icons.language),
                          Text(data.originalLanguage),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Production Companies',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      // width: 390,
                      height: 70,
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            print(data.productionCompanies[index].logoPath);
                            return Container(
                              // width: 200,
                              height: 90, padding: const EdgeInsets.all(18),
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(15)),
                              child: FadeInImage(
                                placeholder: AssetImage(
                                  'assets/popcorn.png',
                                ),
                                image: NetworkImage(
                                    'https://image.tmdb.org/t/p/w500' +
                                        data.productionCompanies[index].logoPath
                                            .toString()),
                              ),
                            );
                          },
                          separatorBuilder: (context, _) {
                            return SizedBox(
                              width: 25,
                            );
                          },
                          itemCount: data.productionCompanies.length),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
