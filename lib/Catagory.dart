import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipies/myhome.dart';
import 'Profile Page.dart';
import 'newsearch.dart';

class catagories extends StatefulWidget {
  const catagories({super.key});

  @override
  State<catagories> createState() => _MyhomeState();
}

class _MyhomeState extends State<catagories> {
  int rows = 3;
  int columns = 4;
  bool isloading = true;
  TextEditingController searchController = TextEditingController();
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Handle navigation based on selected index
    switch (index) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Myhome()));
        break;
      case 1:
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    double scWidth = MediaQuery.of(context).size.width;
    double scHeight = MediaQuery.of(context).size.height;
    List<List<String>> catagories=[['Gulab Jamun','Ras Malai'],['Jalebi','Pasta'],['Poha','Dal Bati Churma'],['Kaju Katli','Rasgulla'],['Malai Kofta','French Fries']];

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFFA726), Color(0xFFFF7043),],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        leading: Align(
          alignment: Alignment(4, 0),
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/logo1.png'),
            backgroundColor: Colors.transparent,
            radius: 25,
          ),
        ),
        title: Text("R  E  C  I  P  E  S",style:TextStyle(color: Colors.white),), // Title of the app
        // centerTitle: true,
        backgroundColor: Color(0xff213A50),
        elevation: 0,
        actions: [
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage()));
            },
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/me.jpg'),
              radius: 25,
            ),
          ),
          SizedBox(width: 10,)
        ],
      ),

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
            child: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Column(
                children: [
                  for(var items in catagories)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for(var item in items)
                            Stack(
                              children:[
                                Container(
                                  height: 130,
                                  width: 130,
                                  margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2),blurRadius: 9,spreadRadius: 12)],
                                  ),
                                  child: InkWell(
                                    onTap: (){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => NewSearch(s:item.toString()),
                                        ),
                                      );
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                        "assets/images/${item}.jpg",
                                        height: 200,
                                        width: 200,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 12,
                                  right: 12,
                                  bottom: 10,
                                  child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.black38,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                    ),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        item.toString(),
                                        style: TextStyle(color: Colors.white, fontSize: 12),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFEF5350),Color(0xFFFFA726).withOpacity(0.8)],
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
