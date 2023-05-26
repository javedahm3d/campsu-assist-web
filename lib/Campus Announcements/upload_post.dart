import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'firebase_storage.dart';

class UploadPostScreen extends StatefulWidget {
  final title;
  final body;

  const UploadPostScreen({super.key, required this.title, required this.body});

  @override
  State<UploadPostScreen> createState() => _UploadPostScreenState();
}

class _UploadPostScreenState extends State<UploadPostScreen> {
  late TextEditingController titleController = TextEditingController();
  late TextEditingController bodyController = TextEditingController();
  bool isButtonActive = false;
  bool isLoading = false;

  List<PlatformFile> files = [];

  @override
  void initState() {
    super.initState();
    titleController.addListener(() {
      setState(() {
        isButtonActive = titleController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
  }

  createPost() async {
    try {
      setState(() {
        isLoading = true;
      });

      // String userId = FirebaseAuth.instance.currentUser!.uid;

      FirebaseFirestore firestore = FirebaseFirestore.instance;

      String postId = const Uuid().v1();
      print('before');

      await firestore.collection('Campus announcements').doc(postId).set({
        'postId': postId,
        'title': titleController.text,
        'body': bodyController.text,
        'published time': DateTime.now().toString(),
      });

      print('after');
      setState(() {
        Navigator.pop(context);
        isLoading = false;
      });
    } catch (e) {
      print(e);
      // ShowMessage().showMessage(e.toString().replaceAll('-', ' '), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              CupertinoIcons.back,
            )),
        iconTheme: IconThemeData(color: Colors.black),
        title: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              '',
              softWrap: true,
              style: TextStyle(color: Colors.black, fontSize: 16),
            )),
        backgroundColor: Colors.white,
        elevation: 3,
        actions: [
          isButtonActive
              ? Padding(
                  padding: const EdgeInsets.all(8.0).copyWith(right: 25),
                  child: InkWell(
                    onTap: createPost,
                    child: Container(
                      width: 100,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 61, 141, 64),
                          borderRadius: BorderRadius.circular(10)),
                      child: isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                              color: Colors.white,
                            ))
                          : const Center(
                              child: Text(
                              'Create Post',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            )),
                    ),
                  ),
                )
              : Container()
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),

                Divider(thickness: 1.5),

                //title field

                TextField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.text_fields),
                      labelText: 'title*',
                      enabledBorder:
                          OutlineInputBorder(borderSide: BorderSide.none)),
                  controller: titleController,
                ),

                Divider(thickness: 1.5),

                //body field
                Container(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 300),
                    child: TextField(
                      maxLines: null,
                      decoration: InputDecoration(
                          prefixIcon: Icon(CupertinoIcons.text_append),
                          labelText: 'body',
                          enabledBorder:
                              OutlineInputBorder(borderSide: BorderSide.none)),
                      controller: bodyController,
                    ),
                  ),
                ),

                Divider(thickness: 1.5),

                SizedBox(height: 20),

                //attach file
                InkWell(
                    onTap: () async {
                      FilePickerResult? result = await FilePicker.platform
                          .pickFiles(allowMultiple: true);

                      setState(() {
                        files = files + result!.files;
                      });
                    },
                    child: Container(
                        // height: 60,
                        // child: Row(
                        //   children: [
                        //     Icon(Icons.attach_file),
                        //     SizedBox(
                        //       width: 10,
                        //     ),
                        //     Text(
                        //       'attach files',
                        //       style: TextStyle(
                        //           fontSize: 16, color: Colors.grey.shade700),
                        //     )
                        //   ],
                        // ),
                        )),

                //Divider(thickness: 1.5),

                //SizedBox(height: 20),

                //attached files preview

                ListView.builder(
                  shrinkWrap: true,
                  itemCount: files.length,
                  itemBuilder: (context, index) {
                    int num = index + 1;
                    return InkWell(
                      onTap: () async {
                        await OpenFile.open(files[index].path);
                      },
                      child: Card(
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
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
