import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practical_test/modals/movie.dart';
import 'package:practical_test/providers/movie_db_helper.dart';
import 'dart:developer';

import 'package:practical_test/views/home_screen/page/detail_page.dart';
import 'package:practical_test/views/home_screen/page/firebase_data_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

Future<List<Movie>>? movieData;

class _HomePageState extends State<HomePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController genreController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController ratingController = TextEditingController();
  TextEditingController woodController = TextEditingController();
  TextEditingController languageController = TextEditingController();

  final GlobalKey<FormState> insertFormKey = GlobalKey<FormState>();

  String name = "";
  String genre = "";
  String type = "";
  String rating = "";
  String wood = "";
  String language = "";

  addData() {
    Movie d3 = Movie(name: "Race 3", genre: "UA", type: "Comedy", language: "Telugu", wood: "Hollywood", rating: "9.8");
    MovieDBHelper.movieDBHelper.insertData(data: d3);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    movieData = MovieDBHelper.movieDBHelper.fetchAllData();
    //addData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("practical App"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FirebaseData(),
                  ),
                );
              },
              icon: Icon(
                Icons.move_up,
              )),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          insertData(context);
        },
        child: Icon(Icons.add),
      ),
      body: FutureBuilder(
        future: movieData,
        builder: (context, snapShot) {
          if (snapShot.hasError) {
            return Center(
              child: Text("ERROR: ${snapShot.error}"),
            );
          } else if (snapShot.hasData) {
            List<Movie>? data = snapShot.data;
            return Card(
              elevation: 3,
              child: ListView.builder(
                itemCount: data!.length,
                itemBuilder: (context, i) {
                  return InkWell(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DetailMoviePage(),
                          settings: RouteSettings(
                            arguments: data[i],
                          ),
                        ),
                      );
                      movieData = MovieDBHelper.movieDBHelper.fetchAllData();
                      setState(() {});
                    },
                    child: ListTile(
                      leading: Text("${data[i].id}"),
                      title: Text(data[i].name),
                      subtitle: Text(data[i].wood),
                      trailing: Text(data[i].rating),
                    ),
                  );
                },
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  insertData(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Insert Movie"),
            content: Form(
              key: insertFormKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: nameController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter name first";
                        }
                        return null;
                      },
                      onSaved: (val) {
                        setState(() {
                          name = val!;
                        });
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Name",
                        hintText: "Enter name...",
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: genreController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter genre first";
                        }
                        return null;
                      },
                      onSaved: (val) {
                        setState(() {
                          genre = val!;
                        });
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Genre",
                        hintText: "Enter genre...",
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: typeController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter type first";
                        }
                        return null;
                      },
                      onSaved: (val) {
                        setState(() {
                          type = val!;
                        });
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Type",
                        hintText: "Enter type...",
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: ratingController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter rating first";
                        }
                        return null;
                      },
                      onSaved: (val) {
                        setState(() {
                          rating = val!;
                        });
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Rating",
                        hintText: "Enter rating...",
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: woodController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter wood first";
                        }
                        return null;
                      },
                      onSaved: (val) {
                        setState(() {
                          wood = val!;
                        });
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Wood",
                        hintText: "Enter wood...",
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: typeController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter language first";
                        }
                        return null;
                      },
                      onSaved: (val) {
                        setState(() {
                          language = val!;
                        });
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Language",
                        hintText: "Enter language...",
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () async {
                  if (insertFormKey.currentState!.validate()) {
                    insertFormKey.currentState!.save();

                    log(name, name: "name");
                    log(genre, name: "genre");
                    log(type, name: "type");
                    log(rating, name: "rating");
                    log(wood, name: "wood");
                    log(language, name: "language");

                    Movie myMovieData = Movie(
                      name: name,
                      genre: genre,
                      type: type,
                      language: language,
                      wood: wood,
                      rating: rating,
                    );

                    int res = await MovieDBHelper.movieDBHelper.insertData(data: myMovieData);

                    log(res.toString(), name: "res");

                    if (res > 0) {
                      setState(() {
                        movieData = MovieDBHelper.movieDBHelper.fetchAllData();
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.green,
                          content: Text("Data Inserted Successfully..."),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text("Failed To Insert data"),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.red,
                        content: Text("Failed To Add data"),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }

                  Navigator.pop(context);
                },
                child: const Text("Insert"),
              ),
              OutlinedButton(
                onPressed: () {
                  nameController.clear();
                  genreController.clear();
                  typeController.clear();
                  ratingController.clear();
                  woodController.clear();
                  languageController.clear();
                  setState(() {
                    name = "";
                    genre = "";
                    type = "";
                    rating = "";
                    wood = "";
                    language = "";
                  });

                  Navigator.pop(context);
                },
                child: const Text("cancel"),
              ),
            ],
          );
        });
  }
}
