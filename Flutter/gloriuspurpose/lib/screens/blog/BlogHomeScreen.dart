import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../services/UnsplashService.dart';
import 'Calendar.dart';
import 'PostCard.dart';
import 'PostCardData.dart';

class BlogHomeScreen extends StatefulWidget {
  @override
  _BlogHomeScreenState createState() => _BlogHomeScreenState();
}

class _BlogHomeScreenState extends State<BlogHomeScreen> {
  late List<String> _carouselImages = [];
  List<Map<String, dynamic>> campaigns = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCampaigns();
  }

  Future<void> fetchCampaigns() async {
    UnsplashService unsplashService = UnsplashService();

    _carouselImages = await unsplashService.searchPhotos('government events', 'landscape');

    try {
      // Fetch images from Unsplash for the NGO query
      List<String> imageUrls = await unsplashService.searchPhotos('ngo', 'portrait');

      // Create campaign data using fetched images
      campaigns = List.generate(imageUrls.length, (index) {
        return {
          "name": "Campaign ${index + 1}",
          "organizer": "Organizer ${index + 1}",
          "date": "2024-10-${index + 1}",
          "image": imageUrls[index],
          "tags": ["Tag1", "Tagssss2", "Tag3"],
        };
      });
    } catch (e) {
      print('Error fetching images: $e');
      // Fallback to default campaigns if there's an error
      campaigns = [
        {
          "name": "Default Campaign",
          "organizer": "Default Organizer",
          "date": "2024-10-10",
          "image": "https://via.placeholder.com/300",
          "tags": ["No Tags"],
        },
      ];
    } finally {
      setState(() {
        isLoading = false; // Stop loading once data is fetched
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show loading indicator while fetching data
          : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Navigate to CalendarPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CalendarPage(), // Replace with your CalendarPage widget
                        ),
                      );
                    },
                    child: Icon(Icons.calendar_today, color: Colors.black), // Calendar icon
                  ), // Calendar icon
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: Icon(Icons.notifications, color: Colors.black),
                  ), // Notification icon
                ],
              ),
            ),
            CarouselSlider(
              options: CarouselOptions(
                height: 300,
                autoPlay: true,
                enlargeCenterPage: true,
              ),
              items: _carouselImages.map((imageUrl) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22), // Custom border radius
                        border: Border.all(
                          color: Colors.green.shade200, // Set your desired border color here
                          width: 1.0, // Set the border width
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20), // Custom border radius
                                image: DecorationImage(
                                  image: NetworkImage(imageUrl),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              height: 200,
                              width: double.infinity,
                            ),
                          ),
                          SizedBox(height: 10), // Space between the image and the button row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: Text(
                                  'Event Name',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                child: ElevatedButton(
                                  onPressed: () {
                                  },
                                  child: Text('Join', style: TextStyle(color: Colors.white),),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green.shade400, // Button color
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(13),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              }).toList(),
            ),

            SizedBox(height: 10,),

            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Text("Recommended Events",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
            ),


            Container(
              child: Column(
                children: postCardDataList.map((postData) {
                  return PostCard(
                    ngoName: postData['ngoName'],
                    content: postData['content'],
                    imageUrl: postData['imageUrl'],
                    likes: postData['likes'],
                    comments: postData['comments'],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}