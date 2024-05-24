import 'package:exam/models/article_model.dart';
import 'package:flutter/material.dart';

import '../services/http_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  List<Article> articles = [];

  _loadArticles() async {
    var response =
        await Network.GET(Network.API_GET_INFOS, Network.paramsArticle());
    List<Article> articlesList = Network.parseArticles(response!);
    print(articlesList.length);
    setState(() {
      articles = articlesList;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              return itemOfArticle(articles[index], index);
            },
          )
        ],
      ),
    );
  }

  Widget itemOfArticle(Article article, int index) {
    return Container(
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey[300],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(20)
            ),
            child: Column(
              children: [
                Container(
                  child: Row(
                    children: [
                      Text(index.toString()),
                      SizedBox(width: 10),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: NetworkImage(article.urlToImage!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Text(article.source.name, style: TextStyle(fontSize: 20))
                    ],
                  ),
                ),
                Divider(),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(),
                  child: Column(
                    children: [
                      Text(article.title),
                      Divider(),
                      Text(article.description),
                      Divider(),
                      Text(article.content),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
