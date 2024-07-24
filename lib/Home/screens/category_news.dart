import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../models/news_models.dart';
import '../../../services/services.dart';
import 'news_details.dart';

class SelectedCategoryNews extends StatefulWidget {
  String category;
  SelectedCategoryNews({super.key, required this.category});

  @override
  State<SelectedCategoryNews> createState() => _SelectedCategoryNewsState();
}

class _SelectedCategoryNewsState extends State<SelectedCategoryNews> {
  List<NewsModel> articles = [];
  bool isLoadin = true;
  getNews() async {
    CategoryNews news = CategoryNews();
    await news.getNews(widget.category);
    articles = news.dataStore;
    setState(() {
      isLoadin = false;
    });
  }

  @override
  void initState() {
    getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(
          widget.category,
          style: TextStyle(
            fontFamily: "Astonpoliz",
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 16.sp
          ),
        ),
      ),
      body: isLoadin
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : SingleChildScrollView(
        child: ListView.builder(
          itemCount: articles.length,
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemBuilder: (context, index) {
            final article = articles[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewsDetail(newsModel: article),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        article.urlToImage!,
                        height: 25.h,
                        width: 100.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                     SizedBox(height: 1.h),
                    Text(
                      article.title!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                        color: Colors.white
                      ),
                    ),
                    const Divider(thickness: 2),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}