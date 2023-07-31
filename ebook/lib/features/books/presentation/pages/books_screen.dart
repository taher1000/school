import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ebook/core/widgets/scaffolds/custom_scaffold.dart';
import 'package:ebook/features/books/data/models/book.dart';
import 'package:flutter/material.dart';

import '../../../../core/resources/assets_manager.dart';
import '../widgets/reading_card_list.dart';

class BooksScreen extends StatelessWidget {
  const BooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return
        //PostsOverviewScreen();
        CustomScaffold(
      screenTitle: "Level Books",
      canPop: false,
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return ReadingListItemCard(
                  book: Book(
                    image: ImageAssets.book1,
                    title: "Children Book",
                    publisher: "publisher",
                    author: "author",
                    description:
                        "lorem ipsum dolor sit amet, consectetur adipiscing elit, ",
                    pagesCount: "15",
                    wordsCount: "192",
                    language: "Arabic",
                    level: "م",
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PostsOverviewScreen extends StatefulWidget {
  @override
  _PostsOverviewScreenState createState() => _PostsOverviewScreenState();
}

class _PostsOverviewScreenState extends State<PostsOverviewScreen> {
  late bool _isLastPage;
  late int _pageNumber;
  late bool _error;
  late bool _loading;
  final int _numberOfPostsPerRequest = 10;
  late List<Book> _books;
  final int _nextPageTrigger = 3;

  @override
  void initState() {
    super.initState();
    _pageNumber = 0;
    _books = [];
    _isLastPage = false;
    _loading = true;
    _error = false;
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blog App"),
        centerTitle: true,
      ),
      body: buildPostsView(),
    );
  }

  Widget buildPostsView() {
    if (_books.isEmpty) {
      if (_loading) {
        return const Center(
            child: Padding(
          padding: EdgeInsets.all(8),
          child: CircularProgressIndicator(),
        ));
      } else if (_error) {
        return Center(child: errorDialog(size: 20));
      }
    }
    return ListView.builder(
        itemCount: _books.length + (_isLastPage ? 0 : 1),
        itemBuilder: (context, index) {
          if (index == _books.length - _nextPageTrigger) {
            fetchData();
          }
          if (index == _books.length) {
            if (_error) {
              return Center(child: errorDialog(size: 15));
            } else {
              return const Center(
                  child: Padding(
                padding: EdgeInsets.all(8),
                child: CircularProgressIndicator(),
              ));
            }
          }
          final Book book = _books[index];
          return Padding(
              padding: const EdgeInsets.all(15.0),
              child: ReadingListItemCard(
                book: book,
              ));
        });
  }

  Future<void> fetchData() async {
    try {
      final response = await Dio().get(
          "http://192.168.160.84/api/v1/Book?PageNumber=$_pageNumber&PageSize=$_numberOfPostsPerRequest");
      // List responseList = json.decode(response.data);
      print("error --> ${response.data}");

      // List<Book> bookList = responseList
      //     .map((data) => Book(
      //         author: "1",
      //         pagesCount: "12",
      //         publisher: "1",
      //         language: data["language"],
      //         level: data["bookLevel"],
      //         wordsCount: "2",
      //         title: data["title"],
      //         description: data["description"],
      //         image: data["image"]))
      //     .toList();

      // setState(() {
      //   _isLastPage = bookList.length < _numberOfPostsPerRequest;
      //   _loading = false;
      //   _pageNumber = _pageNumber + 1;
      //   _books.addAll(bookList);
      // });
    } catch (e) {
      // print("error --> $e");
      // setState(() {
      //   _loading = false;
      //   _error = true;
      // });
    }
  }

  Widget errorDialog({required double size}) {
    return SizedBox(
      height: 180,
      width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'An error occurred when fetching the posts.',
            style: TextStyle(
                fontSize: size,
                fontWeight: FontWeight.w500,
                color: Colors.black),
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
              onPressed: () {
                setState(() {
                  _loading = true;
                  _error = false;
                  fetchData();
                });
              },
              child: const Text(
                "Retry",
                style: TextStyle(fontSize: 20, color: Colors.purpleAccent),
              )),
        ],
      ),
    );
  }
}
