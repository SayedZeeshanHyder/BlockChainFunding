import 'package:flutter/material.dart';

class CampaignCard extends StatelessWidget {
  final String name;
  final String organizer;
  final String date;
  final String imageUrl;
  final List<String> tags;

  const CampaignCard({
    Key? key,
    required this.name,
    required this.organizer,
    required this.date,
    required this.imageUrl,
    required this.tags,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3), // Rounded corners

        border: Border.all(color: Colors.black12, width: 1), // Adding a border with color and width
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Event Image
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(3)),
            child: Image.network(
              imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Event Name
                Text(
                  name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Organizer
                Text(
                  '$organizer',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                // Event Date
                Text(
                  '$date',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                SizedBox(
                  height: 5,
                ),
                // Tags


              ],
            ),
          ),
        ],
      ),
    );
  }
}