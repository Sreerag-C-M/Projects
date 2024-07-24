import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../models/news_models.dart';


class NewsDetail extends StatelessWidget {
  final NewsModel newsModel;
  const NewsDetail({super.key, required this.newsModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(2.w),
            child: Text(
              newsModel.title!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.sp,
                color: Colors.white
              ),
            ),
          ),
          Row(
            children: [
              const Expanded(
                child: SizedBox(),
              ),
              Expanded(
                  child: Text(
                    "- ${newsModel.author!}",
                    maxLines: 1,
                  ))
            ],
          ),
          SizedBox(height: 1.h),
          Padding(
            padding: EdgeInsets.all(3.w),
            child: Image.network(newsModel.urlToImage!),
          ),
          SizedBox(height: 1.h),
          Padding(
            padding: EdgeInsets.all(2.w),
            child: Text(
              newsModel.content!,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.white
              ),
            ),
          ),
          SizedBox(height: 1.h),
          Padding(
            padding: EdgeInsets.all(2.w),
            child: Text(
              newsModel.description!,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.white
              ),
            ),
          )
        ],
      ),
    );
  }
}