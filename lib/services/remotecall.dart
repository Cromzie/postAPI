import 'package:builder/models/post.dart';
import 'package:http/http.dart' as http;

class RemoteCall {
  Future<List<Post>?> getPosts() async {
    http.Client client = http.Client();

    Uri uri = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    http.Response response = await client.get(uri);
    if (response.statusCode == 200) {
      String json = response.body;
      return postFromJson(json);
    }
    return null;
  }
}
