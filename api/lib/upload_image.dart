import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File? image;
  final _picker = ImagePicker();

  bool showSpinner = false;

  Future getImage() async {
    final pickedFile =
        await _picker.getImage(source: ImageSource.gallery, imageQuality: 80);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      setState(() {});
    } else {
      debugPrint("No image Seleceted");
    }
  }

  Future<void> uploadImage() async {
    setState(() {
      showSpinner = true;
    });

    var stream = http.ByteStream(image!.openRead());
    stream.cast();

    var length = await image!.length();

    var uri = Uri.parse('https://fakestoreapi.com/products');

    var request = http.MultipartRequest('POST', uri);

    request.fields['title'] = 'Static title';

    var multiport = http.MultipartFile('image', stream, length);

    request.files.add(multiport);

    var response = await request.send();

    if (response.statusCode == 200) {
      setState(() {
        showSpinner = false;
      });
      debugPrint("Image Uploaded");
    } else {
      setState(() {
        showSpinner = false;
      });
      debugPrint('failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Upload Image"),
        ),
        body: Center(
            child: Column(
          children: [
            Container(
                child: image == null
                    ? ElevatedButton(
                        child: const Text("Pick Image"),
                        onPressed: () {
                          getImage();
                        },
                      )
                    : SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.file(
                          File(image!.path).absolute,
                          fit: BoxFit.cover,
                        ),
                      )),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  child: const Text("Upload Image"),
                  onPressed: () {
                    uploadImage();
                  },
                ))
          ],
        )),
      ),
    );
  }
}
