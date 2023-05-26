import 'package:campus_assist_web/Campus Announcements/annoucement_body.dart';
import 'package:campus_assist_web/Campus%20Announcements/upload_post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'annoucement_body.dart';

class AnnoucementScreen extends StatefulWidget {
  const AnnoucementScreen({super.key});

  @override
  State<AnnoucementScreen> createState() => _AnnoucementScreenState();
}

class _AnnoucementScreenState extends State<AnnoucementScreen> {
  getannouncements() async {
    var data = await FirebaseFirestore.instance
        .collection('Campus announcements')
        .orderBy('name')
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Campus Annoucements',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Campus announcements')
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final snap = snapshot.data!.docs[index].data();
              return InkWell(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AnnoucemntBody(),
                )),
                child: Card(
                  child: SizedBox(
                    width: double.infinity,
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(15)
                          .copyWith(bottom: 5, right: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snap['title'],
                            style: GoogleFonts.roboto(fontSize: 17),
                            softWrap: true,
                          ),
                          Spacer(),
                          Align(
                              alignment: Alignment.centerRight,
                              child: Text(snap['published time']
                                  .toString()
                                  .substring(0, 16)))
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => UploadPostScreen(
                title: 'null',
                body: 'null',
              ),
            ));
          }),
    );
  }
}
