import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:recipies/Profile%20Page.dart';
import 'package:recipies/recipe.dart';
import 'Model.dart';
import 'package:recipies/newsearch.dart';
import 'package:recipies/Catagory.dart';

class Myhome extends StatefulWidget {
  const Myhome({super.key});

  @override
  State<Myhome> createState() => _MyhomeState();
}

class _MyhomeState extends State<Myhome> {
  bool isloading = true;
  List<mymodel> finaldata = <mymodel>[];
  TextEditingController searchController = TextEditingController();
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Handle navigation based on selected index
    switch (index) {
      case 0:
      // Navigate to Home
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context)=>catagories()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage()));
        break;
      }
    }

  getRecipes(String query) async {
    setState(() {
      isloading = true; // Set loading state to true before fetching data
    });

    String url = "https://api.edamam.com/search?q=$query&app_id=09c2074f&app_key=f89b9667d9a24cc5681cb51e2672bae5";
    Response response = await get(Uri.parse(url));

    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      setState(() {
        finaldata.clear(); // Clear the previous results before adding new ones
        data["hits"].forEach((element) {
          mymodel recipeModel = mymodel.fromMap(element["recipe"]);
          finaldata.add(recipeModel);
        });
        isloading = false; // Set loading state to false after data is fetched
      });
    } else {
      setState(() {
        isloading = false;
      });
      log('Failed to load recipes');
    }
  }

  @override
  void initState() {
    super.initState();
    getRecipes('jalebi');
  }

  @override
  Widget build(BuildContext context) {
    double scWidth = MediaQuery.of(context).size.width;
    double scHeight = MediaQuery.of(context).size.height;

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
        backgroundColor: Color(0xff213A50),
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
                // colors: [Color(0xff213A50), Color(0xff071938)],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 13,right: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  style: TextStyle(color: Colors.white),
                  controller: searchController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    hintText: "Search Here",
                    labelText: "Let's Cook Something!",
                    labelStyle: TextStyle(color: Colors.white),
                    hintStyle: TextStyle(color: Colors.white54),
                    suffixIcon: IconButton(
                      onPressed: () async {
                        final s = searchController.text.trim();
                        if (s.isNotEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewSearch(s: s),
                            ),
                          );
                        }
                        if (searchController.text.trim().isNotEmpty) {
                          await getRecipes(searchController.text);
                        } else {
                          print('Search query is empty.');
                        }
                      },
                      icon: Icon(Icons.search_outlined, color: Colors.white,),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "WHAT DO YOU WANT TO COOK TODAY?",
                  style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  "Let's Cook Something New!",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                isloading
                    ? Center(child: CircularProgressIndicator()) // Show loading indicator
                    : Expanded(
                    child: ListView.builder(
                      itemCount: finaldata.length,
                      itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          dynamic name = finaldata[index].name;
                          dynamic gradurl=finaldata[index].url;
                          final List<String>? ingredint = finaldata[index].ingredient;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MakeIt(name: name, ingardint: ingredint ?? [],url:gradurl),
                            ),
                          );
                        },
                        child: Card(
                          margin: EdgeInsets.only(top: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0.0,
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.network(
                                  finaldata[index].image ?? '',
                                  width: scWidth,
                                  height: scHeight * 0.35,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                left: 0,
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.black38,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    finaldata[index].name ?? '',
                                    style: TextStyle(color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 0,
                                height: 35,
                                width: 100,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                    ),
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.local_fire_department, size: 15),
                                        Flexible(
                                          child: Text(
                                            finaldata[index].calories != null
                                                ? '${finaldata[index].calories!.toStringAsFixed(0)}kcal'
                                                : 'N/A',
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
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
