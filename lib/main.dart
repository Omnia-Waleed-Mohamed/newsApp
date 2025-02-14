import 'package:flutter/material.dart';
import 'package:news_app/services/news_services.dart';
import 'package:news_app/views/home_view.dart';

void main() {
  runApp(News());
}


class News extends StatelessWidget {
  const News({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeView() ,
    )
    
    
    ;
  }
}
