import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'Model.dart';
import 'package:recipies/recipe.dart';

class NewSearch extends StatefulWidget {
  final String s;
  const NewSearch({super.key, required this.s});

  @override
  State<NewSearch> createState() => _NewSearchState();
}

class _NewSearchState extends State<NewSearch> {
  bool isloading = true;
  List<mymodel> finaldata = <mymodel>[];
  TextEditingController searchController = TextEditingController();

  // Removed the problematic getter for 's'

  getRecipes(String query) async {
    setState(() {
      isloading = true; // Set loading to true before fetching data
    });

    String url = "https://api.edamam.com/search?q=$query&app_id=09c2074f&app_key=f89b9667d9a24cc5681cb51e2672bae5";
    Response response = await get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      setState(() {
        finaldata.clear(); // Clear previous data to avoid duplication
        data["hits"].forEach((element) {
          mymodel recipeModel = mymodel.fromMap(element["recipe"]);
          finaldata.add(recipeModel);
        });
        isloading = false; // Set loading to false after data is fetched
      });
      log(finaldata.toString());
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
    getRecipes(widget.s); // Correctly use widget.s to access the passed value
  }

  @override
  Widget build(BuildContext context) {
    double scWidth = MediaQuery.of(context).size.width;
    double scHeight = MediaQuery.of(context).size.height;

    return Scaffold(
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
          Padding(
            padding: const EdgeInsets.only(top: 40, left: 10,right: 10,bottom: 0),
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
                    hintStyle: TextStyle(color: Colors.white70),
                    suffixIcon: IconButton(
                      onPressed: () async {
                        if (searchController.text.trim().isNotEmpty) {
                          await getRecipes(searchController.text);
                        } else {
                          print('Search query is empty.');
                        }
                      },
                      icon: Icon(Icons.search_outlined, color: Colors.white,size: 30,),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5,left: 2),
                  child: Text('Here are some related results . . .',style: TextStyle(fontSize: 20,color: Colors.white),),
                ),
                isloading
                    ? Center(child: CircularProgressIndicator())
                    : Expanded(
                  child: ListView.builder(
                    itemCount: finaldata.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        mouseCursor: SystemMouseCursors.click,
                        onTap: () {
                          dynamic name = finaldata[index].name;
                          dynamic gradurl = finaldata[index].url;
                          print(gradurl);
                          final List<String>? ingredint = finaldata[index].ingredient;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MakeIt(
                                  name: name,
                                  ingardint: ingredint ?? [],
                                  url: gradurl ?? ''
                              ),
                            ),
                          );
                        },
                        child: Card(
                          margin: EdgeInsets.only(top: 10),
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
                                height: 40,
                                width: 90,
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
    );
  }
}
