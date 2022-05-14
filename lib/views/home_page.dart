import 'package:builder/models/post.dart';
import 'package:builder/services/remotecall.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post>? posts;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();

    getData();
  }

  void getData() async {
    posts = await RemoteCall().getPosts();
    if (posts != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'HomePAGE',
          style: TextStyle(color: Colors.white30),
        ),
        centerTitle: true,
      ),
      body: Visibility(
        visible: isLoaded,
        child: ListView.builder(
          itemCount: posts?.length,
          itemBuilder: ((context, index) => Card(
                child: ListTile(
                  title: Text(
                    posts![index].title.toUpperCase(),
                    maxLines: 2,
                    style:
                        TextStyle(color: Colors.brown.shade400, fontSize: 12.0),
                  ),
                  subtitle: Text(
                    posts![index].body ?? '',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.brown.shade200),
                  ),
                  leading: Text(
                    posts![index].id.toString(),
                    style: TextStyle(color: Colors.brown.shade200),
                  ),
                  trailing: Text(
                    posts![index].userId.toString(),
                    style: TextStyle(color: Colors.brown.shade200),
                  ),
                ),
              )),
        ),
        replacement: const Center(
          child: CircularProgressIndicator(
            color: Colors.lightGreen,
          ),
        ),
      ),
    );
  }
}
