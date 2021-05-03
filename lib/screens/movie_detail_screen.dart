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
                      Container(),
                      Container(
                        alignment: Alignment.center,
                        child: IconButton(
                            icon: Icon(
                              Icons.play_arrow,
                              size: 75,
                            ),
                            onPressed: () async {
                              var key =
                                  await Api().getVideoLink(data.id.toString());
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return PlayerScreen(key);
                              }));
                            }),
                      ),
                      Column(
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
                            child: Text(data.voteAverage.toString() + '/10'),
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
          ],
        ),
      ),
    );
    // return Scaffold(
    //   body: CustomScrollView(
    //     slivers: [
    //       SliverToBoxAdapter(
    //         child: DestinationImageCarousel(
    //           imgUrl: imgUrl,
    //           // placeName: 'Destination\nName',
    //         ),
    //       ),
    //       SliverToBoxAdapter(
    //         child: SizedBox(
    //           height: 15,
    //         ),
    //       ),
    //       SliverToBoxAdapter(
    //         child: Container(
    //           margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text(
    //                 'Place Name',
    //                 style: TextStyle(
    //                   // color: Colors.black,
    //                   fontSize: 30,
    //                   fontWeight: FontWeight.w900,
    //                   // fontFamily: GoogleFonts.lobster().fontFamily,
    //                 ),
    //               ),
    //               SizedBox(
    //                 height: 8,
    //                 // child:
    //               ),
    //               Container(
    //                 margin: EdgeInsets.all(6),
    //                 child: Text(
    //                   'Place descrition text will appear here\nIt was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum',
    //                   style: TextStyle(
    //                     fontSize: 18,
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //       // SliverToBoxAdapter(
    //       //   child: SizedBox(
    //       //     height: 15,
    //       //   ),
    //       // ),
    //       SliverToBoxAdapter(
    //         child: Container(
    //           margin: EdgeInsets.all(30),
    //           // height: 100,
    //           // color: Colors.grey,
    //           width: size.width,
    //           alignment: Alignment.center,
    //           child: Row(
    //             // main,
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             mainAxisAlignment: MainAxisAlignment.spaceAround,
    //             children: [
    //               Container(
    //                 child: Column(
    //                   children: [
    //                     Icon(Icons.grade),
    //                     Text('Rating'),
    //                   ],
    //                 ),
    //               ),
    //               Divider(),
    //               Container(
    //                 child: Column(
    //                   children: [
    //                     Icon(Icons.location_city_outlined),
    //                     Text('City'),
    //                   ],
    //                 ),
    //               ),
    //               Divider(),
    //               Container(
    //                 child: Column(
    //                   children: [
    //                     Icon(Icons.card_travel),
    //                     Text('Visitors'),
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //       SliverToBoxAdapter(
    //         child: ReviewsSection(),
    //       ),
    //       nearByPlacesTab
    //           ? SliverToBoxAdapter(
    //               child: _nearByPlaces(size, context),
    //             )
    //           : SliverToBoxAdapter(),
    //       SliverToBoxAdapter(
    //         child: SizedBox(
    //           height: 15,
    //         ),
    //       ),
    //       restaurantsTab
    //           ? SliverToBoxAdapter(
    //               child: _restaurants(size),
    //             )
    //           : SliverToBoxAdapter(),
    //       SliverToBoxAdapter(
    //         child: SizedBox(
    //           height: 15,
    //         ),
    //       ),
    //       hotelsTab
    //           ? SliverToBoxAdapter(
    //               child: _hotelsTab(size),
    //             )
    //           : SliverToBoxAdapter(),
    //       SliverToBoxAdapter(
    //         child: SizedBox(
    //           height: 15,
    //         ),
    //       ),
    //       SliverToBoxAdapter(
    //         child: Container(
    //           margin: const EdgeInsets.symmetric(vertical: 35, horizontal: 25),
    //           child: Text('Ⓒ MovieApp 2021'),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
    // ;
  }
}
