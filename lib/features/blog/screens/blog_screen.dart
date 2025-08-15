import 'package:flutter/material.dart';

class BlogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: [
        Text(
          'Latest Blog Posts',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        _buildBlogItem(
          'Learning Strategies',
          'Effective ways to study and retain information',
        ),
        _buildBlogItem(
          'Career Guidance',
          'Tips for choosing the right career path',
        ),
        _buildBlogItem(
          'Technology Trends',
          'Latest developments in tech education',
        ),
      ],
    );
  }

  Widget _buildBlogItem(String title, String summary) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(summary),
          ],
        ),
      ),
    );
  }
}
