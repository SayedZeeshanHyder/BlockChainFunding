
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'PostScreen.dart';



String truncateText(String content, {int wordLimit = 20}) {
  List<String> words = content.split(' ');
  if (words.length > wordLimit) {
    return words.sublist(0, wordLimit).join(' ') + '...';
  }
  return content;
}

class PostCard extends StatelessWidget {
  final String ngoName;
  final String content;
  final String imageUrl;
  final String likes;
  final List<Map<String, String>> comments; // Change to List<Map<String, String>>

  const PostCard({
    Key? key,
    required this.ngoName,
    required this.content,
    required this.imageUrl,
    required this.likes,
    required this.comments, // Accept comments as a parameter
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    List<String> randomimg = [
      "https://upload.wikimedia.org/wikipedia/commons/b/ba/Hopehalllogo.jpg",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSq3WEXVMAMUlB3tX2GzYDr0K9xEHaIOt1dIQ&s",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQBzLPHHdDmNc4bHFWXNMoHHhBxRZ-eXADQzA&s",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSbbWP-jowqLmZeHvy2O_xFrJB-TU39Xgi2Lg&s"
    ];
    return GestureDetector(
      onTap: () {
        // Navigate to PostPage with data
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostPage(
              ngoName: ngoName,
              content: content,
              imageUrl: imageUrl,
              likes: likes,
              comments: comments, // Pass comments to the PostPage
            ),
          ),
        );
      },
      child: Card(
        color: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.all(10),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // NGO logo, name, and timestamp
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.green, // Set your desired border color here
                        width: 2.0, // Set the border width
                      ),
                    ),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(randomimg[Random().nextInt(randomimg.length)]), // Random NGO logo
                      radius: 20,
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ngoName,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Text("1h ago", style: TextStyle(color: Colors.grey, fontSize: 12)),
                          SizedBox(width: 5),
                          Icon(Icons.public, size: 12, color: Colors.grey),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                ],
              ),
              SizedBox(height: 10),
              // Post text content
              RichText(
                text: TextSpan(
                  text: "$ngoName ", // NGO Name
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                      text: truncateText(content),
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                    TextSpan(
                      text: " more",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              // Post image
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  imageUrl, // Image URL passed as parameter
                  fit: BoxFit.cover,
                  height: 150,
                  width: double.infinity,
                ),
              ),
              SizedBox(height: 10),
              // Reactions section
              Row(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.favorite, color: Colors.red, size: 18),
                        onPressed: () {
                          print("Liked!");
                        },
                      ),
                    ],
                  ),
                  Text(
                    likes,
                    style: TextStyle(color: Colors.grey),
                  ),
                  Spacer(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
