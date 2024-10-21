import 'dart:convert';
import 'package:http/http.dart' as http;

class UnsplashService {
  final String accessKey = 'N3VtnJ2PqvW7MyHu_-jqgPF-0OmEsNx2jGtSSx9xBQk'; // Replace with your Unsplash API access key

  Future<List<String>> searchPhotos(String query, String orientation) async {
    final String url =
        'https://api.unsplash.com/search/photos?query=$query&client_id=$accessKey&orientation=$orientation';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      List<String> photoUrls = [];

      for (var photo in data['results']) {
        photoUrls.add(photo['urls']['regular']); // Get the regular size URL
      }

      return photoUrls;
    } else {
      throw Exception('Failed to load photos');
    }
  }

  Future<List<String>> searchRandomPhotos(String query, String orientation) async {
    final String url =
        'https://api.unsplash.com/photos/random?query=$query&client_id=$accessKey&orientation=$orientation';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      List<String> photoUrls = [];

      for (var photo in data['results']) {
        photoUrls.add(photo['urls']['regular']); // Get the regular size URL
      }

      return photoUrls;
    } else {
      throw Exception('Failed to load photos');
    }
  }
}