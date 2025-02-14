import 'package:dio/dio.dart';
import 'package:news_app/models/article.dart';

class NewsServices {

final dio = Dio();

 Future<List<Article>> getNews() async{

try {
  var response =await dio.get('https://newsapi.org/v2/top-headlines?country=us&apiKey=b4a2c750209d484e9c75a3d5603b5f32');
  
  Map<String,dynamic> jsonData =response.data;
  
  List<dynamic> articles =jsonData['articles'];
  
  List<Article> articlesList =[];
  
  for(var article in articles){
  
    Article articleModel =Article(
     image:  article['urlToImage'] 
     ,
      title:  article['title'] 
      , 
      subTitle:  article['description'] 
    
      );
  
       articlesList.add(articleModel);
  
  }
  return articlesList;
}  catch (e) {
  print('Error fetching news: $e');
      return [];
}


}

}