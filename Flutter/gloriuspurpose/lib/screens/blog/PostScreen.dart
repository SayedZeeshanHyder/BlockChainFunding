import 'package:flutter/material.dart';

class PostPage extends StatelessWidget {
  final String ngoName;
  final String content;
  final String imageUrl;
  final String likes;
  final List<Map<String, String>> comments;

  const PostPage({
    Key? key,
    required this.ngoName,
    required this.content,
    required this.imageUrl,
    required this.likes,
    required this.comments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // NGO Name
                  Text(
                    ngoName,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(height: 10),

                  // Post Content
                  Text(
                    content,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),

                  // Post Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      height: 250,
                      width: double.infinity,
                    ),
                  ),

                  // Likes Count
                  Text(
                    'Likes: $likes',
                    style: TextStyle(color: Colors.grey),
                  ),




                  // Comments Section
                  Text(
                    'Comments:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),

                  ListView.builder(
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      final commentData = comments[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0), // Vertical padding between comments
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100, // Light background for each comment
                            borderRadius: BorderRadius.circular(2), // Rounded corners
                            border: Border.all(color: Colors.grey.shade300), // Light border
                          ),
                          padding: const EdgeInsets.all(10), // Padding inside the comment container
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // User and timestamp
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    commentData['user']!,
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    commentData['timestamp']!,
                                    style: TextStyle(color: Colors.grey, fontSize: 12),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5), // Spacing between user and comment text
                              // Comment text
                              Text(
                                commentData['comment']!,
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    physics: NeverScrollableScrollPhysics(), // Disable scrolling for the ListView
                    shrinkWrap: true, // Allow the ListView to take only the required height
                  ),

                ],
              ),
            ),
          ),

          // Add a comment input field at the bottom
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Add a comment...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}