import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:recipies/Catagory.dart';
import 'myhome.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 2; // Index for bottom navigation bar

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
    switch (index) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Myhome()));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context)=>catagories()));
        break;
      case 2:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    double scWidth = MediaQuery.of(context).size.width;
    double scHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      body: Stack(
        children: [
          Container(
            width: scWidth,
            height: scHeight,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFFA726),Color(0xFFFF7043),],
              ),
            ),
          ),
          SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  // Curved background image
                  Container(
                    height: 350,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black,
                          width: 5,
                        ),
                      ),
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(50),
                      ),
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(50),
                          ),
                          child: Image.asset(
                            'assets/images/me.jpg', // Replace with your background image URL
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 350,
                          ),
                        ),
                        Positioned.fill(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                            child: Container(
                              color: Colors.black.withOpacity(0), // Transparent color to apply blur only
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Circular profile image overlay
                  Positioned(
                    bottom: 80,
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 75,
                        backgroundImage:AssetImage('assets/images/me.jpg'),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Profile Name and Location
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Manoj Kumhar',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on, color: Colors.blueGrey, size: 16,),
                        SizedBox(width: 5),
                        Text(
                          'IIT Patna, Bihar',
                          style: TextStyle(color: Colors.blueGrey, fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    // Action Icons
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.favorite, color: Colors.redAccent),
                            SizedBox(width: 20),
                            Icon(Icons.chat_bubble_outline, color: Colors.blueGrey),
                            SizedBox(width: 20),
                            Icon(Icons.bookmark_border, color: Colors.blueGrey, size: 27),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 6),
                            Text('1M'),
                            SizedBox(width: 20),
                            Text('55k'),
                            SizedBox(width: 20),
                            Text('10k'),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 50),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0xfffffa726), // Darker grey for a more polished look
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24), // Add padding
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // Rounded corners
                        ),
                      ),
                      child: Text(
                        'Follow',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        ]
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFEF5350), Color(0xFFFFA726).withOpacity(0.8)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent, // Make it transparent to show gradient
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: Colors.lightGreenAccent,
          unselectedItemColor: Colors.white70,
        ),
      ),
    );
  }
}
