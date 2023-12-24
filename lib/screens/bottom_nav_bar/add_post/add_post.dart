import 'dart:io';

import 'package:everyhosta/screens/bottom_nav_bar/add_post/widget/custom_input.dart';
import 'package:everyhosta/widgets/custom_text_input.dart';
import 'package:everyhosta/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';

import '../../../services/db_services.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  String selectedImage = '';
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  pickImage(ImageSource source) async {
    await ImagePicker().pickImage(source: source).then((value) {
      setState(() {
        selectedImage = value!.path.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.sizeOf(context).height * 0.3,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.shade100),
                  child: selectedImage == ''
                      ? IconButton(
                          onPressed: () async {
                            showModalBottomSheet(context: context!, builder: (_){
                              return SizedBox(
                                height: 200,
                                child: Column(
                                  children: [
                                    ListTile(
                                      onTap:(){
                                        Navigator.pop(context);
                                        pickImage(ImageSource.camera);
                                      },
                                      leading:const  Icon(Icons.camera_alt_outlined),
                                      title:const  Text('From Camera'),
                                    ),
                                    ListTile(
                                      onTap:(){
                                        Navigator.pop(context);

                                        pickImage(ImageSource.gallery);
                                      },
                                      leading:const  Icon(Icons.photo),
                                      title:const  Text('From Gallery'),
                                    ),
                                  ],
                                ),
                              );
                            });

                          },
                          icon: const Icon(
                            Icons.add,
                            size: 40,
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.file(
                            File(selectedImage),
                            fit: BoxFit.cover,
                          )),
                ),
                const SizedBox(height: 20),
                CustomInput(
                  title: "Title",
                  controller: titleController,
                ),
                const SizedBox(height: 20),
                CustomInput(
                  title: "Description",
                  controller: descriptionController,
                  maxLines: 4,
                ),
                const SizedBox(height: 20),
                PrimaryButton(
                  title: "Add",
                  onPressed: () async {
                    if (selectedImage == '') {
                      EasyLoading.showError("Image is required");
                    } else if (titleController.text.isEmpty ||
                        titleController.text == '') {
                      EasyLoading.showError("title is required");
                    } else if (descriptionController.text.isEmpty ||
                        descriptionController.text == '') {
                      EasyLoading.showError("description is required");
                    } else {
                      DbServices.uploadData(
                          context: context,
                          imageUrl: selectedImage,
                          title: titleController.text,
                          description: descriptionController.text);
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
