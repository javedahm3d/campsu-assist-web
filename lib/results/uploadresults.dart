import 'dart:typed_data';

import 'package:campus_assist_web/results/firestore_upload.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file_plus/open_file_plus.dart';

import '../Campus Announcements/firebase_storage.dart';
// import 'package:flutter/foundation.dart';

class UploadResult extends StatefulWidget {
  // final String course;
  final String department;
  final String sem;
  const UploadResult(
      {super.key,
      // required this.course,
      required this.department,
      required this.sem});

  @override
  State<UploadResult> createState() => _UploadResultState();
}

class _UploadResultState extends State<UploadResult> {
  // PlatformFile? files;
  List<PlatformFile> files = [];
  Uint8List? uploadfile;
  TextEditingController _context = TextEditingController();
  String? filename;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            // widget.course + " - " +
            widget.department + ' - ' + widget.sem),
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: TextField(
              textAlign: TextAlign.center,
              controller: _context,
              decoration: const InputDecoration(
                  hintText:
                      "please specify RC as the file title , eg :  RC 19-20"),
            ),
          ),
          const SizedBox(
            height: 50,
          ),

          // upload file button
          Padding(
            padding: const EdgeInsets.all(20),
            child: InkWell(
              onTap: () async {
                FilePickerResult? result =
                    await FilePicker.platform.pickFiles();
                uploadfile = result!.files.single.bytes;
                filename = result.files.single.name;

                setState(() {
                  files = result.files;
                  print(files);
                });
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.2,
                height: MediaQuery.of(context).size.height * 0.1,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 2, color: Colors.deepPurple)),
                child: Center(
                  child: ListTile(
                    leading: Icon(
                      Icons.cloud_upload_outlined,
                      color: Colors.white,
                      size: 50,
                    ),
                    title: Text(
                      'Upload Result File',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 21,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // show file name

          ListView.builder(
            shrinkWrap: true,
            itemCount: files.length,
            itemBuilder: (context, index) {
              int num = index + 1;
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 100),
                child: InkWell(
                  onTap: () async {
                    await OpenFile.open(files[index].path);
                  },
                  child: Card(
                    color: Colors.yellow,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        minLeadingWidth: 1,
                        contentPadding: EdgeInsets.all(0),
                        leading: Text(num.toString()),
                        title: Text(files[index].name),
                        trailing: IconButton(
                            onPressed: () {
                              setState(() {
                                files.removeAt(index);
                              });
                            },
                            icon: Icon(Icons.cancel_outlined)),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          const SizedBox(
            height: 30,
          ),

          Container(
            child: files.isEmpty
                ? null
                : ElevatedButton(
                    onPressed: () async {
                      if (_context.text.isEmpty) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  'please enter the RC',
                                  textAlign: TextAlign.center,
                                ),
                              );
                            });
                      } else {
                        //show circular progress indicator
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            });
                        //uploding file to storage

                        String URL = await FirebaseResultStorageClass()
                            .uploadFile(
                                uploadfile!,
                                widget.sem,
                                widget.department,
                                filename.toString(),
                                _context.text.trim());

                        final temp = await FirebaseFirestore.instance
                            .collection('results')
                            .doc(widget.sem)
                            .collection(widget.department)
                            .doc(_context.text.trim())
                            .set({'FileURL': URL, 'RC': _context.text.trim()});

                        // displaying successfull message
                        Navigator.pop(context);
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  'successfully uploaded',
                                  textAlign: TextAlign.center,
                                ),
                              );
                            });
                      }
                    },
                    child: Text(
                      'Upload',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    )),
          )
        ],
      )),
    );
  }
}
