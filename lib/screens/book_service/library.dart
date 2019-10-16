import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gift_of_the_nile/component/loading_progress.dart';
import 'package:gift_of_the_nile/models/book_ref.dart';
import 'package:gift_of_the_nile/screens/book_service/bloc/library_bloc.dart';
import 'package:gift_of_the_nile/screens/book_service/pdf_screen.dart';
import 'package:koukicons/emptyTrash.dart';
import 'package:koukicons/reading.dart';

class LibraryScreen extends StatefulWidget {
  final List<Book> bookList;

  LibraryScreen(this.bookList);

  @override
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  LibraryBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = LibraryBloc(widget.bookList);
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        centerTitle: true,
        title: Text(
          'My Library',
        ),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
          stream: _bloc.downloadedBooks,
          builder: (context, booksSnapshot) {
            if (booksSnapshot.hasData) {
              return ListView.builder(
                itemBuilder: (c, index) {
                  final book = booksSnapshot.data[index]['book'] as Book;
                  final path = booksSnapshot.data[index]['path'] as String;
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.shade200,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Material(
                            clipBehavior: Clip.antiAlias,
                            elevation: 10,
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            child: CachedNetworkImage(
                              imageUrl: book
                                  .bookResult.volumeInfo.imageLinks.thumbnail,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  book.bookResult.volumeInfo.title,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 19,
                                  ),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  book.bookResult.volumeInfo.subtitle ?? '',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    IconButton(
                                      icon: KoukiconsReading(),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (c) =>
                                                    PDFScreen(path)));
                                      },
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    IconButton(
                                      icon: KoukiconsEmptyTrash(),
                                      onPressed: () {
                                        _bloc.deleteBook(book, path);
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                shrinkWrap: true,
                itemCount: booksSnapshot.data.length,
              );
            } else {
              return LoadingProgress();
            }
          }),
    );
  }
}
