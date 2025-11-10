import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '"Netflix"',
      theme: ThemeData.dark(),
      home: const MovieHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MovieHomePage extends StatelessWidget {
  const MovieHomePage({super.key});

  final List<Map<String, String>> carouselItems = const [
    {
      'image': 'assets/images/carousel1.jpg',
      'title': 'Deadpool & Wolverine',
      'desc': 'Action | Sci-Fi'
    },
    {
      'image': 'assets/images/carousel2.jpg',
      'title': 'Guardians Vol.3',
      'desc': 'Action | Adventure'
    },
    {
      'image': 'assets/images/carousel3.jpg',
      'title': 'Interstellar',
      'desc': 'Drama | Sci-Fi'
    },
  ];

  final List<Map<String, String>> trending = const [
    {'title': 'Bad Boys', 'image': 'assets/images/trending1.jpg'},
    {'title': 'Fast Five', 'image': 'assets/images/trending2.jpg'},
    {'title': 'Minions', 'image': 'assets/images/trending3.jpg'},
  ];
  final List<Map<String, String>> popular = const [
    {'title': 'Fallout', 'image': 'assets/images/popular1.jpg'},
    {'title': 'Superman', 'image': 'assets/images/popular2.jpg'},
    {'title': 'Blue Beetle', 'image': 'assets/images/popular3.jpg'},
  ];
  final List<Map<String, String>> topRated = const [
    {'title': 'Perfect Days', 'image': 'assets/images/toprated1.jpg'},
    {'title': 'Interstellar', 'image': 'assets/images/toprated2.jpg'},
    {'title': 'Oppenheimer', 'image': 'assets/images/toprated3.jpg'},
  ];

  Widget buildSection(String title, List<Map<String, String>> items) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const Text('More', style: TextStyle(color: Colors.redAccent, fontSize: 14)),
              ],
            ),
          ),
          SizedBox(
            height: 210,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              separatorBuilder: (context, _) => const SizedBox(width: 14),
              itemBuilder: (context, index) {
                final movie = items[index];
                return MovieCard(title: movie['title']!, imageUrl: movie['image']!);
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewPadding.bottom;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SafeArea(
            child: Container(
              width: double.infinity,
              height: 56,
              color: const Color.fromARGB(255, 135, 14, 6),
              child: const Center(
                child: Text(
                  'Now Playing',
                  style: TextStyle(
                    fontFamily: 'Birthstone',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: CarouselSlider(
                    items: carouselItems
                        .map((movie) => CarouselMovieCard(
                              image: movie['image']!,
                              title: movie['title']!,
                              desc: movie['desc']!,
                            ))
                        .toList(),
                    options: CarouselOptions(
                      height: 180,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: false,
                      viewportFraction: 0.8,
                      initialPage: 0,
                    ),
                  ),
                ),
                buildSection("Trending", trending),
                buildSection("Popular", popular),
                buildSection("Top Rated", topRated),
                SizedBox(height: (bottomInset > 0 ? bottomInset : 22) + 46),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.grey[900],
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 8,
              offset: Offset(0, -1),
            ),
          ],
        ),
        padding: EdgeInsets.only(
          top: 4,
          bottom: bottomInset > 0 ? bottomInset : 14,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            NavBarItem(icon: Icons.home, label: "Home", isActive: true),
            NavBarItem(icon: Icons.movie_filter, label: "Genre", isActive: false),
            NavBarItem(icon: Icons.favorite, label: "Favorite", isActive: false),
          ],
        ),
      ),
    );
  }
}

class CarouselMovieCard extends StatelessWidget {
  final String image, title, desc;
  const CarouselMovieCard({required this.image, required this.title, required this.desc, super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            image,
            width: MediaQuery.of(context).size.width * 0.8,
            height: 180,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          left: 16,
          right: 16,
          bottom: 20,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.55),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 19,
                    shadows: [
                      Shadow(
                        offset: Offset(0, 2),
                        color: Colors.black26,
                        blurRadius: 8,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  desc,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  const MovieCard({required this.title, required this.imageUrl, super.key});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        width: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.asset(imageUrl, height: 160, width: 120, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 8),
              child: Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  const NavBarItem({
    required this.icon,
    required this.label,
    this.isActive = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: isActive ? Colors.redAccent : Colors.white70),
        Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.redAccent : Colors.white70,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
