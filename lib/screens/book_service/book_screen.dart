import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gift_of_the_nile/models/book_ref.dart';
import 'package:gift_of_the_nile/screens/book_service/bloc/book_screen_bloc.dart';
import 'package:gift_of_the_nile/screens/book_service/pdf_screen.dart';

class BookScreen extends StatefulWidget {
  final Book book;
  final String heroTag;

  BookScreen(this.book, this.heroTag);

  @override
  _BookScreenState createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  Book _book;
  BookScreenBloc _bloc;

  @override
  void initState() {
    super.initState();
    _book = widget.book;
    _bloc = BookScreenBloc(_book);
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  List<Widget> mapLabelToButton(DownloadTaskStatus downloadState) {
    if (DownloadTaskStatus.undefined == downloadState ||
        downloadState == DownloadTaskStatus.canceled) {
      return [
        Text(
          'Download',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        )
      ];
    } else if (downloadState == DownloadTaskStatus.running) {
      return [
        StreamBuilder<int>(
            stream: _bloc.progressValue,
            initialData: 0,
            builder: (context, progressValue) {
              return Row(
                children: <Widget>[
                  Container(
                    width: 35,
                    height: 35,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  Text(
                    (progressValue.data).toString() + '%',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              );
            }),
      ];
    } else if (DownloadTaskStatus.complete == downloadState) {
      return [
        Icon(
          Icons.book,
          color: Colors.white,
          size: 30,
        ),
        SizedBox(
          width: 15,
        ),
        Text(
          'Read',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        )
      ];
    } else {
      return [
        Text(
          'Failed to download',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: StreamBuilder<DownloadTaskStatus>(
          stream: _bloc.downloadState,
          builder: (context, downloadState) {
            if (downloadState.hasData) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: RaisedButton(
                  color: Colors.amber,
                  onPressed: () {
                    if (downloadState.data == DownloadTaskStatus.complete) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (c) => PDFScreen(_bloc.localPath),
                        ),
                      );
                      return;
                    }
                    _bloc.changeDownloadState();
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: mapLabelToButton(downloadState.data)),
                ),
              );
            } else {
              return CircularProgressIndicator();
            }
          }),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  _book.bookResult.volumeInfo.imageLinks.thumbnail,
                ),
                fit: BoxFit.fill,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
              child: new Container(
                decoration:
                    new BoxDecoration(color: Colors.white.withOpacity(0.0)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 240, left: 10, right: 10, bottom: 45),
            child: Material(
              clipBehavior: Clip.antiAlias,
              elevation: 10,
              shadowColor: Colors.amber.shade600,
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Text(
                        _book.bookResult.volumeInfo.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                      Text(
                        _book.bookResult.volumeInfo.subtitle ?? '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      Container(
                        width: 50,
                        height: 2,
                        color: Colors.amber,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        _book.bookResult.volumeInfo.authors != null
                            ? _book.bookResult.volumeInfo.authors
                                .toString()
                                .replaceAll('[', '')
                                .replaceAll(']', '')
                            : '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      RatingBar(
                        itemBuilder: (context, _) {
                          return Icon(
                            Icons.star,
                            color: Colors.amber,
                          );
                        },
                        onRatingUpdate: (rating) {},
                        ignoreGestures: true,
                        itemSize: 20,
                        itemCount: 5,
                        unratedColor: Colors.grey,
                        glowColor: Colors.amber,
                        glow: true,
                        allowHalfRating: true,
                        glowRadius: 10,
                        initialRating:
                            _book.bookResult.volumeInfo.averageRating ?? 0,
                      ),
                      Divider(),
                      Wrap(
                        spacing: 5,
                        children:
                            _book.bookResult.volumeInfo.categories.map((cate) {
                          return Chip(
                            elevation: 7,
                            shadowColor: Colors.amber.shade800,
                            backgroundColor: Colors.amber,
                            label: Text(
                              cate,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      Divider(),
                      Text(
                        'About',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Html(
                        data: _book.bookResult.volumeInfo.description,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 10,
            top: 30,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: 85,
            child: Container(
              height: 200,
              child: Hero(
                tag: widget.heroTag,
                child: Material(
                  clipBehavior: Clip.antiAlias,
                  elevation: 10,
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                  child: CachedNetworkImage(
                    imageUrl: _book.bookResult.volumeInfo.imageLinks.thumbnail,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
