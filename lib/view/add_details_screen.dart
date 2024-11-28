import 'dart:io';

import 'package:admin_app/dio/api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';

class AddDetailsScreen extends StatefulWidget {
  const AddDetailsScreen({super.key, required this.menuName});
  final String menuName;

  @override
  State<AddDetailsScreen> createState() => _AddDetailsScreenState();
}

class _AddDetailsScreenState extends State<AddDetailsScreen> {
  TextEditingController controller = TextEditingController();
  File? image;
  bool isUploading = false;

  Future<void> addCategory() async {
  print("Started");
  if (image == null || controller.text.trim().isEmpty) {
    print("Something is empty");
    return;
  }

  try {
    print("Preparing form data");
    String fileName = "${controller.text}${DateTime.now().millisecondsSinceEpoch}";
    FormData formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(
        image!.path,
        filename: fileName,
      ),
      'name': controller.text.trim(),
    });

    print("File MIME type: ${lookupMimeType(image!.path)}");

    print("FormData content:");
    formData.fields.forEach((field) {
      print("${field.key}: ${field.value}");
    });

    print("FormData files:");
    formData.files.forEach((file) {
      print("${file.key}: ${file.value.filename}");
    });


    final response = await Dio().post(
      Api.addCategoryApi,
      data: formData,
    );

    print("Response status code: ${response.statusCode}");
    print("Response data: ${response.data}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Category added successfully");
      setState(() {
        isUploading = false;
      });
    } else {
      print("Failed to upload category");
    }
  } on DioException catch (e) {
    print("DioException occurred: ${e.message}");
    print('Response data: ${e.response?.data}');
    setState(() {
      isUploading = false;
    });
  } catch (e) {
    print("Unexpected error: $e");
    setState(() {
      isUploading = false;
    });
  }
}

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.menuName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const Text(
              "Add a Category",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                  hintText: "Enter the category name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => Container(
                    color: Colors.grey,
                    width: double.infinity,
                    height: 150,
                    child: Column(
                      children: [
                        const Text(
                          'Choose from',
                        ),
                        const Divider(),
                        TextButton(
                            onPressed: () async {
                              await pickImage(ImageSource.camera);
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Camera',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            )),
                        TextButton(
                            onPressed: () async {
                              await pickImage(ImageSource.gallery);

                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Gallery',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ))
                      ],
                    ),
                  ),
                );
              },
              child: Container(
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: theme.dividerColor),
                  ),
                  child: image != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.file(
                            image!,
                            fit: BoxFit.cover,
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: const Center(
                            child: Text("Please select an image"),
                          ))),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap: () async{
            if (image == null && controller.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please complete the fields'),
                ),
              );
            } else if (image == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please select an image'),
                ),
              );
            } else if (controller.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please enter the category name'),
                ),
              );
            } else {
              setState(() {
                isUploading = true;
              });
              await addCategory();
            }
          },
          child: Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            child: Center(
                child: isUploading ?  const CircularProgressIndicator() : Text(
              "Add ${widget.menuName}",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            )),
          ),
        ),
      ),
    );
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imagePermanent = await saveImagePermanently(image.path);
      setState(() => this.image = imagePermanent);
    } on PlatformException catch (e) {
      print('failed to pick image $e');
    }
  }

  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');
    return File(imagePath).copy(image.path);
  }
}
