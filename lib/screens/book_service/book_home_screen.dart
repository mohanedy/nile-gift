import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:gift_of_the_nile/component/loading_progress.dart';
import 'package:gift_of_the_nile/component/show_up_animation.dart';
import 'package:gift_of_the_nile/models/book_ref.dart';
import 'package:gift_of_the_nile/screens/book_service/bloc/books_home_bloc.dart';
import 'package:gift_of_the_nile/screens/book_service/book_screen.dart';
import 'package:gift_of_the_nile/screens/book_service/library.dart';

class BooksHomeScreen extends StatefulWidget {
  @override
  _BooksHomeScreenState createState() => _BooksHomeScreenState();
}

class _BooksHomeScreenState extends State<BooksHomeScreen> {
  BooksHomeBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BooksHomeBloc(context);
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: StreamBuilder<List<Book>>(
            stream: _bloc.booksStream,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data.length > 0) {
                snapshot.data.sort((a, b) {
                  if (a.bookResult.volumeInfo.averageRating != null &&
                      b.bookResult.volumeInfo.averageRating != null) {
                    return b.bookResult.volumeInfo.averageRating
                        .compareTo(a.bookResult.volumeInfo.averageRating);
                  } else {
                    return -1;
                  }
                });

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height / 3,
                      child: Stack(
                        children: <Widget>[
                          ClipPath(
                            clipper: CurveClipping(),
                            child: Container(
                              color: Colors.amber,
                            ),
                          ),
                          SafeArea(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: <Widget>[
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.arrow_back,
                                          ),
                                          color: Colors.white,
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                      Center(
                                        child: Text(
                                          'Egyptian History Library',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.book,
                                          ),
                                          color: Colors.white,
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (c) =>
                                                        LibraryScreen(
                                                            snapshot.data)));
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    'Top Picks',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Container(
                                    child: ShowUp(
                                      child: Swiper(
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          final book =
                                              snapshot.data[index].bookResult;
                                          return Column(
                                            children: <Widget>[
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (c) => BookScreen(
                                                                snapshot.data[
                                                                    index],
                                                                snapshot
                                                                        .data[
                                                                            index]
                                                                        .id +
                                                                    'swiper_' +
                                                                    index
                                                                        .toString())));
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Hero(
                                                      tag: snapshot
                                                              .data[index].id +
                                                          'swiper_' +
                                                          index.toString(),
                                                      child: Material(
                                                        color: Colors.white,
                                                        clipBehavior:
                                                            Clip.antiAlias,
                                                        elevation: 7,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15)),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl: book
                                                              .volumeInfo
                                                              .imageLinks
                                                              .thumbnail,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                        itemCount: snapshot.data.length ~/ 2,
                                        viewportFraction: 0.3,
                                        scale: 0.6,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Library',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    AnimationLimiter(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          final book = snapshot.data[index].bookResult;
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: Duration(milliseconds: 600),
                            delay: Duration(milliseconds: 200),
                            child: SlideAnimation(
                              horizontalOffset: 150,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 10.0,
                                  left: 10.0,
                                  right: 10.0,
                                ),
                                child: Container(
                                  height: 119,
                                  child: Material(
                                    borderRadius: BorderRadius.circular(15),
                                    elevation: 5,
                                    color: Colors.grey.shade200,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(
                                          child: Hero(
                                            tag: snapshot.data[index].id +
                                                'list_' +
                                                index.toString(),
                                            child: Material(
                                              color: Colors.white,
                                              clipBehavior: Clip.antiAlias,
                                              elevation: 7,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: CachedNetworkImage(
                                                imageUrl: book
                                                        .volumeInfo
                                                        .imageLinks
                                                        .smallThumbnail ??
                                                    '',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Flexible(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              AutoSizeText(
                                                book.volumeInfo.title,
                                                maxLines: 3,
                                                minFontSize: 12,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Color(0xff2D2D2D),
                                                ),
                                              ),
                                              AutoSizeText(
                                                book.volumeInfo.subtitle ?? '',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                minFontSize: 14,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              Spacer(),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: 5.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    RatingBar(
                                                      itemBuilder:
                                                          (context, _) {
                                                        return Icon(
                                                          Icons.star,
                                                          color: Colors.amber,
                                                        );
                                                      },
                                                      onRatingUpdate:
                                                          (rating) {},
                                                      ignoreGestures: true,
                                                      itemSize: 20,
                                                      itemCount: 5,
                                                      unratedColor: Colors.grey,
                                                      glowColor: Colors.amber,
                                                      glow: true,
                                                      allowHalfRating: true,
                                                      glowRadius: 10,
                                                      initialRating: book
                                                              .volumeInfo
                                                              .averageRating ??
                                                          0,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 8.0),
                                                      child: FlatButton(
                                                        color:
                                                            Color(0xfffec512),
                                                        child: Text(
                                                          'Read',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                        ),
                                                        onPressed: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (c) => BookScreen(
                                                                      snapshot.data[
                                                                          index],
                                                                      snapshot.data[index]
                                                                              .id +
                                                                          'list_' +
                                                                          index.toString())));
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: snapshot.data.length,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                      ),
                    ),
                  ],
                );
              } else {
                return SafeArea(child: Center(child: LoadingProgress()));
              }
            }),
      ),
    );
  }
}

class CurveClipping extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 100);
    path.quadraticBezierTo(
        size.width / 4, size.height, size.width / 2, size.height);
    path.quadraticBezierTo(size.width - (size.width / 4), size.height,
        size.width, size.height - 100);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
