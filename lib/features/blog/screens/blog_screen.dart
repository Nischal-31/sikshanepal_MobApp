import 'package:flutter/material.dart';

class BlogScreen extends StatefulWidget {
  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedCategory = 'All';

  final List<String> categories = [
    'All',
    'Education',
    'Career',
    'Technology',
    'Tips',
  ];

  final List<Map<String, dynamic>> blogPosts = [
    {
      'title': 'Effective Learning Strategies for Modern Students',
      'summary':
          'Discover proven techniques to enhance your learning experience and retain information better.',
      'category': 'Education',
      'author': 'Dr. Sarah Johnson',
      'date': '2 days ago',
      'readTime': '5 min read',
      'image':
          'https://images.unsplash.com/photo-1434030216411-0b793f4b4173?w=400',
      'featured': true,
      'tags': ['Study Tips', 'Learning', 'Education'],
    },
    {
      'title': 'Career Guidance: Choosing the Right Path',
      'summary':
          'Navigate your career journey with expert tips and insights from industry professionals.',
      'category': 'Career',
      'author': 'Mark Thompson',
      'date': '5 days ago',
      'readTime': '8 min read',
      'image':
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400',
      'featured': false,
      'tags': ['Career', 'Professional Growth', 'Guidance'],
    },
    {
      'title': 'Technology Trends in Education 2024',
      'summary':
          'Explore the latest technological developments reshaping the educational landscape.',
      'category': 'Technology',
      'author': 'Tech Team',
      'date': '1 week ago',
      'readTime': '6 min read',
      'image':
          'https://images.unsplash.com/photo-1488590528505-98d2b5aba04b?w=400',
      'featured': true,
      'tags': ['Technology', 'EdTech', 'Innovation'],
    },
    {
      'title': 'Time Management for Students',
      'summary':
          'Master the art of time management to balance studies, work, and personal life effectively.',
      'category': 'Tips',
      'author': 'Lisa Chen',
      'date': '1 week ago',
      'readTime': '4 min read',
      'image':
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400',
      'featured': false,
      'tags': ['Time Management', 'Productivity', 'Student Life'],
    },
    {
      'title': 'The Future of Online Learning',
      'summary':
          'How digital education is evolving and what it means for students and educators.',
      'category': 'Education',
      'author': 'Education Team',
      'date': '2 weeks ago',
      'readTime': '7 min read',
      'image':
          'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=400',
      'featured': false,
      'tags': ['Online Learning', 'Digital Education', 'Future'],
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: categories.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get filteredPosts {
    if (_selectedCategory == 'All') {
      return blogPosts;
    }
    return blogPosts
        .where((post) => post['category'] == _selectedCategory)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          // Header Section
          SliverToBoxAdapter(child: _buildHeader()),

          // Category Tabs
          SliverToBoxAdapter(child: _buildCategoryTabs()),

          // Featured Posts
          SliverToBoxAdapter(child: _buildFeaturedSection()),

          // All Posts
          SliverToBoxAdapter(child: _buildAllPostsSection()),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.article_rounded,
                  color: Colors.blue[600],
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Blog & Articles',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      'Stay updated with latest insights',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  // Search functionality
                },
                icon: Icon(
                  Icons.search_rounded,
                  color: Colors.grey[600],
                  size: 28,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Categories',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = _selectedCategory == category;

                return Container(
                  margin: const EdgeInsets.only(right: 12),
                  child: FilterChip(
                    label: Text(
                      category,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.grey[700],
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.w500,
                      ),
                    ),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                    backgroundColor: Colors.grey[200],
                    selectedColor: Colors.blue[600],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 0,
                    pressElevation: 0,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildFeaturedSection() {
    final featuredPosts = filteredPosts
        .where((post) => post['featured'] == true)
        .take(2)
        .toList();

    if (featuredPosts.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Featured Articles',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 280,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: featuredPosts.length,
              itemBuilder: (context, index) {
                final post = featuredPosts[index];
                return _buildFeaturedCard(post);
              },
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildFeaturedCard(Map<String, dynamic> post) {
    return Container(
      width: 300,
      margin: const EdgeInsets.only(right: 16),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Container(
              height: 160,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                image: DecorationImage(
                  image: NetworkImage(post['image']),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue[600],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'FEATURED',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post['title'],
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    post['summary'],
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      height: 0.25,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 12,
                        color: Colors.grey[500],
                      ),
                      const SizedBox(width: 2),
                      Flexible(
                        child: Text(
                          post['readTime'],
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[500],
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.person, size: 12, color: Colors.grey[500]),
                      const SizedBox(width: 2),
                      Flexible(
                        child: Text(
                          post['author'],
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[500],
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAllPostsSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _selectedCategory == 'All'
                    ? 'All Articles'
                    : '$_selectedCategory Articles',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Navigate to all posts
                },
                child: const Text('View All'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredPosts.length,
            itemBuilder: (context, index) {
              final post = filteredPosts[index];
              return _buildBlogCard(post);
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildBlogCard(Map<String, dynamic> post) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: InkWell(
        onTap: () {
          // Navigate to blog detail
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(post['image']),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        post['category'],
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.blue[600],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Title
                    Text(
                      post['title'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    // Summary
                    Text(
                      post['summary'],
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    // Meta info
                    Row(
                      children: [
                        Icon(Icons.person, size: 12, color: Colors.grey[400]),
                        const SizedBox(width: 2),
                        Flexible(
                          child: Text(
                            post['author'],
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey[500],
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(Icons.schedule, size: 12, color: Colors.grey[400]),
                        const SizedBox(width: 2),
                        Flexible(
                          child: Text(
                            post['date'],
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey[500],
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          post['readTime'],
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey[500],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
