import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:practical_test/modals/movie.dart';
import 'package:practical_test/providers/firebase_cloud_helper.dart';
import 'package:practical_test/providers/movie_db_helper.dart';

import 'home_screen.dart';

class DetailMoviePage extends StatefulWidget {
  const DetailMoviePage({Key? key}) : super(key: key);

  @override
  State<DetailMoviePage> createState() => _DetailMoviePageState();
}

class _DetailMoviePageState extends State<DetailMoviePage> {
  final GlobalKey<FormState> updateFormKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController genreController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController ratingController = TextEditingController();
  TextEditingController woodController = TextEditingController();
  TextEditingController languageController = TextEditingController();

  String name = "";
  String genre = "";
  String type = "";
  String rating = "";
  String wood = "";
  String language = "";

  @override
  Widget build(BuildContext context) {
    Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
      appBar: AppBar(
        title: Text("${movie.name} Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Text.rich(
                    TextSpan(children: [
                      TextSpan(
                        text: "Id: ",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 2),
                      ),
                      TextSpan(
                        text: "${movie.id}",
                        style: TextStyle(fontSize: 18, letterSpacing: 2),
                      ),
                    ]),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text.rich(
                    TextSpan(children: [
                      TextSpan(
                        text: "Name: ",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 2),
                      ),
                      TextSpan(
                        text: "${movie.name}",
                        style: TextStyle(fontSize: 18, letterSpacing: 2),
                      ),
                    ]),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text.rich(
                    TextSpan(children: [
                      TextSpan(
                        text: "Genre: ",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 2),
                      ),
                      TextSpan(
                        text: "${movie.genre}",
                        style: TextStyle(fontSize: 18, letterSpacing: 2),
                      ),
                    ]),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text.rich(
                    TextSpan(children: [
                      TextSpan(
                        text: "Type: ",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 2),
                      ),
                      TextSpan(
                        text: "${movie.type}",
                        style: TextStyle(fontSize: 18, letterSpacing: 2),
                      ),
                    ]),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text.rich(
                    TextSpan(children: [
                      TextSpan(
                        text: "Rating: ",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 2),
                      ),
                      TextSpan(
                        text: "${movie.rating}",
                        style: TextStyle(fontSize: 18, letterSpacing: 2),
                      ),
                    ]),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text.rich(
                    TextSpan(children: [
                      TextSpan(
                        text: "Wood: ",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 2),
                      ),
                      TextSpan(
                        text: "${movie.wood}",
                        style: TextStyle(fontSize: 18, letterSpacing: 2),
                      ),
                    ]),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text.rich(
                    TextSpan(children: [
                      TextSpan(
                        text: "Language: ",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 2),
                      ),
                      TextSpan(
                        text: "${movie.language}",
                        style: TextStyle(fontSize: 18, letterSpacing: 2),
                      ),
                    ]),
                  ),
                ],
              ),
              SizedBox(
                height: 180,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SimpleOutlinedButton(
                    borderRadius: 10,
                    padding: const EdgeInsets.all(15),
                    onPressed: () {
                      updateData(context, data: movie);
                    },
                    outlineColor: Theme.of(context).primaryColor,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.edit,
                        ),
                        Text(
                          "   Update",
                          style: TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ],
                    ),
                  ),
                  SimpleOutlinedButton(
                    borderRadius: 10,
                    padding: EdgeInsets.all(15),
                    onPressed: () async {
                      deleteOneRecord(movie.id);
                    },
                    outlineColor: Theme.of(context).primaryColor,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.delete_sweep_outlined,
                          color: Theme.of(context).primaryColor,
                        ),
                        Text(
                          "   Delete",
                          style: TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  SimpleOutlinedButton(
                    borderRadius: 10,
                    padding: const EdgeInsets.all(15),
                    onPressed: () async {
                      await FirebaseCloudHelper.firebaseCloudHelper.insertData(
                          id: movie.id ?? 0,
                          name: movie.name,
                          genre: movie.genre,
                          type: movie.type,
                          rating: movie.rating,
                          wood: movie.wood,
                          language: movie.language);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.green,
                          content: Text("Data Uploaded Success..."),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );

                    },
                    outlineColor: Theme.of(context).primaryColor,
                    child: Row(
                      children: [
                        Icon(
                          Icons.cloud_upload_outlined,
                          color: Theme.of(context).primaryColor,
                        ),
                        Text(
                          "   Upload",
                          style: TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  updateData(BuildContext context, {required Movie data}) {
    nameController.text = data.name;
    genreController.text = data.genre;
    typeController.text = data.type;
    ratingController.text = data.rating;
    woodController.text = data.wood;
    languageController.text = data.language;

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Update Record"),
            content: Form(
              key: updateFormKey,
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
                  if (updateFormKey.currentState!.validate()) {
                    updateFormKey.currentState!.save();

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
                      id: data.id,
                    );

                    int res = await MovieDBHelper.movieDBHelper.updateData(data: myMovieData, id: data.id);

                    log(res.toString(), name: "res");

                    if (res > 0) {
                      setState(() {
                        movieData = MovieDBHelper.movieDBHelper.fetchAllData();
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.green,
                          content: Text("Data Updated Successfully..."),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text("Failed To update data"),
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
                  Navigator.pop(context);
                },
                child: const Text("Update"),
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
                  Navigator.pop(context);
                },
                child: const Text("cancel"),
              ),
            ],
          );
        });
  }

  deleteOneRecord(int? id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete record"),
        content: const Text(
          "Are you sure to delete this record permanently",
        ),
        actions: [
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.redAccent,
              onPrimary: Colors.white,
            ),
            onPressed: () {
              MovieDBHelper.movieDBHelper.deleteSingleData(id: id!);
              setState(() {
                movieData = MovieDBHelper.movieDBHelper.fetchAllData();
              });
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text("Ok"),
          ),
        ],
      ),
    );
  }
}

class SimpleOutlinedButton extends StatelessWidget {
  const SimpleOutlinedButton(
      {this.child,
      this.textColor,
      this.outlineColor,
      required this.onPressed,
      this.borderRadius = 6,
      this.padding = const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
      Key? key})
      : super(key: key);
  final Widget? child;
  final Function onPressed;
  final double borderRadius;
  final Color? outlineColor;
  final Color? textColor;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    ThemeData currentTheme = Theme.of(context);
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: textColor ?? outlineColor ?? currentTheme.primaryColor,
        padding: padding,
        textStyle: TextStyle(color: currentTheme.primaryColor),
        side: BorderSide(color: outlineColor ?? currentTheme.primaryColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      onPressed: onPressed as void Function()?,
      child: child!,
    );
  }
}
