import 'package:flutter/material.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/services/news_services.dart';

/*class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

bool isLoading =true;

List<Article> articles =[];
@override
  void initState() {
    super.initState();
    getGeneralNews();
  }

Future<void> getGeneralNews() async {
  articles =await NewsServices().getNews();
   isLoading =false;
  setState(() {
    
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Latest News'),centerTitle: true,),
      body: isLoading ?
           const Center(child: CircularProgressIndicator()) // عرض اللودنج في المنتصف
          : ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];

                return Card(
                  margin: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // صورة المقال
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.vertical(top: Radius.circular(10)),
                        child: Image.network(
                          article.image!,
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 200,
                              width: double.infinity,
                              color: Colors.grey[300],
                              child: const Icon(Icons.broken_image,
                                  size: 50, color: Colors.grey),
                            );
                          },
                        ),
                      ),
                      // العنوان والوصف
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              article.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              article.subTitle!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}*/



class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Future<List<Article>> future;

  @override
  void initState() {
    super.initState();
    future = NewsServices().getNews();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Article>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasData) {
          return ListNews(articles: snapshot.data!);
        } else if (snapshot.hasError) {
          return const Scaffold(
            body: Center(child: Text("Oops! There was an error, try again later")),
          );
        }
        return const SizedBox();
      },
    );
  }
}


class ListNews extends StatelessWidget {
  final List<Article> articles;

  const ListNews({Key? key, required this.articles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: const Text(
                'News Cloud',
                style: TextStyle(fontSize: 30),
              ),
              backgroundColor: Colors.white,
              floating: true, 
              snap: true, 
              elevation: 0,
            ),
          ];
        },
        body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: articles.length,
          itemBuilder: (context, index) {
            final article = articles[index];

            return Card(
              margin: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                    child: Image.network(
                      article.image ?? '', 
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 200,
                          width: double.infinity,
                          color: Colors.grey[300],
                          child: const Icon(Icons.broken_image, size: 50, color: Colors.grey),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          article.title ?? 'No Title', 
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          article.subTitle ?? 'No Description', 
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}