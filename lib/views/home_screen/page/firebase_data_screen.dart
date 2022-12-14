import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../providers/firebase_cloud_helper.dart';

class FirebaseData extends StatefulWidget {
  const FirebaseData({Key? key}) : super(key: key);

  @override
  State<FirebaseData> createState() => _FirebaseDataState();
}

class _FirebaseDataState extends State<FirebaseData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase Data"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseCloudHelper.firebaseCloudHelper.fetchAllData(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("ERROR: ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            QuerySnapshot querySnapshot = snapshot.data!;
            List<QueryDocumentSnapshot> queryDocumentSnapshot = querySnapshot.docs;

            return ListView.builder(
              itemCount: queryDocumentSnapshot.length,
              itemBuilder: (context, i) {
                Map<String, dynamic> data = queryDocumentSnapshot[i].data() as Map<String, dynamic>;

                return Container(
                  padding: EdgeInsets.all(10),

                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "Name : ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black54,
                                    letterSpacing: 2,
                                  ),
                                ),
                                TextSpan(
                                  text: "${data["name"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Theme.of(context).primaryColor.withOpacity(0.7),
                                    letterSpacing: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "Genre : ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black54,
                                    letterSpacing: 2,
                                  ),
                                ),
                                TextSpan(
                                  text: "${data["genre"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Theme.of(context).primaryColor.withOpacity(0.7),
                                    letterSpacing: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "Type : ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black54,
                                    letterSpacing: 2,
                                  ),
                                ),
                                TextSpan(
                                  text: "${data["type"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Theme.of(context).primaryColor.withOpacity(0.7),
                                    letterSpacing: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "Rating : ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black54,
                                    letterSpacing: 2,
                                  ),
                                ),
                                TextSpan(
                                  text: "${data["rating"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Theme.of(context).primaryColor.withOpacity(0.7),
                                    letterSpacing: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "Wood : ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black54,
                                    letterSpacing: 2,
                                  ),
                                ),
                                TextSpan(
                                  text: "${data["wood"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Theme.of(context).primaryColor.withOpacity(0.7),
                                    letterSpacing: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "Language : ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black54,
                                    letterSpacing: 2,
                                  ),
                                ),
                                TextSpan(
                                  text: "${data["language"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Theme.of(context).primaryColor.withOpacity(0.7),
                                    letterSpacing: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),

                    ],
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
