import 'package:exam/bloc/home_state.dart';
import 'package:exam/models/article_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeBloc homeBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeBloc = BlocProvider.of<HomeBloc>(context);
    homeBloc.add(LoadArticlesListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.grey[300],
          title: Text(
            'All articles about Tesla',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return Stack(
              children: [
                ListView.builder(
                  itemCount: homeBloc.articles.length,
                  itemBuilder: (context, index) {
                    return itemOfArticle(homeBloc.articles[index], index);
                  },
                )
              ],
            );
          },
        ));
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
                borderRadius: BorderRadius.circular(20)),
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
