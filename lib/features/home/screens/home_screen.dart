import 'package:flutter/material.dart';
import 'package:sikshanepal/features/about/screens/about_screen.dart';
import 'package:sikshanepal/features/blog/screens/blog_screen.dart';
import 'package:sikshanepal/features/contact/screens/contact_screen.dart';
import 'package:sikshanepal/features/courses/screens/course_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // Your 5 main screens
  final List<Widget> _screens = [
    HomeContentScreen(),
    AboutScreen(),
    BlogScreen(),
    CourseScreen(),
    ContactScreen(),
  ];

  final List<String> _titles = ['Home', 'About', 'Blog', 'Courses', 'Contact'];
  void _logout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Navigate back to login and clear all routes
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  (route) => false,
                );
              },
              child: Text('Logout', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false, // Remove back button
        actions: [
          // Subscription button
          IconButton(
            icon: Icon(Icons.subscriptions),
            tooltip: 'Subscription',
            onPressed: () {
              Navigator.pushNamed(context, '/subscription');
            },
          ),
          // Logout button
          IconButton(
            icon: Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: _logout,
          ),
        ],
      ),
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label: 'About',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article_outlined),
            label: 'Blog',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school_outlined),
            label: 'Courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_mail_outlined),
            label: 'Contact',
          ),
        ],
      ),
    );
  }
}

class HomeContentScreen extends StatelessWidget {
  const HomeContentScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome to SikshNepal!',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          SizedBox(height: 20),

          // Quick action cards
          Row(
            children: [
              Expanded(
                child: _buildQuickActionCard(
                  context,
                  'View Courses',
                  Icons.school,
                  Colors.green,
                  () => Navigator.pushNamed(context, '/courses'),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _buildQuickActionCard(
                  context,
                  'Read Blog',
                  Icons.article,
                  Colors.orange,
                  () => Navigator.pushNamed(context, '/blog'),
                ),
              ),
            ],
          ),

          SizedBox(height: 20),

          // Subscription banner
          Card(
            elevation: 4,
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(colors: [Colors.blue, Colors.purple]),
              ),
              child: Row(
                children: [
                  Icon(Icons.star, color: Colors.white, size: 30),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Premium Subscription',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Unlock all courses and features',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, '/subscription'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue,
                    ),
                    child: Text('View Plans'),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 30),

          // Recent activity or featured content
          Text(
            'Featured Content',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),

          _buildFeatureItem(
            'New Flutter Course',
            'Learn mobile app development',
          ),
          _buildFeatureItem('Latest Blog Post', 'Tips for effective learning'),
          _buildFeatureItem('Study Guide', 'Exam preparation resources'),
        ],
      ),
    );
  }
}

Widget _buildQuickActionCard(
  BuildContext context,
  String title,
  IconData icon,
  Color color,
  VoidCallback onTap,
) {
  return Card(
    elevation: 2,
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, size: 40, color: color),
            SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildFeatureItem(String title, String subtitle) {
  return Card(
    margin: EdgeInsets.only(bottom: 12),
    child: ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue,
        child: Icon(Icons.star, color: Colors.white),
      ),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        // Handle tap
      },
    ),
  );
}
