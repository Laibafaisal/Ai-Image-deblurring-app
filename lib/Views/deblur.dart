import 'package:flutter/material.dart';
import 'dart:io';
import 'package:tflite/tflite.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:flutter_tflite/flutter_tflite.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class Deblur extends StatefulWidget {
  @override
  _DeblurState createState() => _DeblurState();
}

class _DeblurState extends State<Deblur>{
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  File? _file;
  File? _deblurredFile;

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  // Load the TFLite deblurring model
  Future<void> loadModel() async {
    try {
      await Tflite.loadModel(
        model: "assets/model_unquant.tflite",
        labels: "labels.txt"
      );
    } catch (e) {
      print("Error loading model: $e");
    }
  }

  // Pick an image from gallery or camera
  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        setState(() {
          _image = image;
          _file = File(image.path);
        });
        deblurImage(_file!);
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  // Deblur the image using the TFLite model
  Future<void> deblurImage(File image) async {
    try {
      final recognitions = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 1,
        imageMean: 127.5,
        imageStd: 127.5,
      );

      if (recognitions != null && recognitions.isNotEmpty) {
        // Assuming the model outputs a path to the deblurred image
        String deblurredImagePath = recognitions[0]['path'];
        setState(() {
          _deblurredFile = File(deblurredImagePath);
        });
      } else {
        print("No recognitions received from the model.");
      }
    } catch (e) {
      print("Error during deblurring: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "AI Deblurring App",
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_image != null)
                  Column(
                    children: [
                      Text(
                        "Original Image:",
                        style: GoogleFonts.poppins(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      Image.file(
                        _file!,
                        height: 200,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 20),
                    ],
                  )
                else
                  Text(
                    "No image selected",
                    style: GoogleFonts.poppins(fontSize: 16),
                  ),
                if (_deblurredFile != null)
                  Column(
                    children: [
                      Text(
                        "Deblurred Image:",
                        style: GoogleFonts.poppins(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      Image.file(
                        _deblurredFile!,
                        height: 200,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () => pickImage(ImageSource.gallery),
                  child: Text("Pick Image from Gallery"),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => pickImage(ImageSource.camera),
                  child: Text("Take a Picture"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
