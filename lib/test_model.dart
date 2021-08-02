import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:tflite/tflite.dart';

class DiseaseDetection extends StatefulWidget {
  @override
  _DiseaseDetectionState createState() => _DiseaseDetectionState();
}

class _DiseaseDetectionState extends State<DiseaseDetection> {
  File pickedImage;
  bool isImageLoaded = false;

  List _result;

  String _confidence = "";
  String _diseaseName = "";
  String _cropName = "";
  String numbers = '';

  getImageFromGallery() async {
    var tempStore = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      pickedImage = File(tempStore.path);
      isImageLoaded = true;
      applyModelOnImage(File(tempStore.path));
    });
  }

  getImageFromCamera() async {
    var tempStore = await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      pickedImage = File(tempStore.path);
      isImageLoaded = true;
      applyModelOnImage(File(tempStore.path));
    });
  }

  loadMyModel() async {
    var resultant = await Tflite.loadModel(
        model: 'assets/tflite/tflite_model_mobilenetv3.tflite',
        labels: 'assets/tflite/labels_test.txt');
    print("Result after loading model: $resultant");
  }

  applyModelOnImage(File file) async {
    var res = await Tflite.runModelOnImage(
        path: file.path,
        numResults: 1,
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5);

    setState(() {
      _result = res;
      print(_result);
      print('yo');

      String str = _result[0]["label"];

      _cropName = str.split("_")[0];
      _diseaseName = str.split("___")[1];
      print(_cropName);
      print(_diseaseName);
      //_name = str;
      _confidence = _result != null
          ? (_result[0]['confidence'] * 100).toString().substring(0, 2) + "%"
          : "";
    });
  }

  @override
  void initState() {
    super.initState();
    loadMyModel();
  }

  @override
  void dispose() {
    super.dispose();
    Tflite.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Disease Detection"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // SizedBox(
            //   height: 30,
            // ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Center(
                  child: Container(
                    height: 350,
                    width: 350,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: isImageLoaded
                                ? FileImage(File(pickedImage.path))
                                : AssetImage(
                                    "assets/images/0_lZbZMk8BGwlWcakg.jpeg"),
                            fit: BoxFit.contain)),
                  ),
                ),
                isImageLoaded
                    ? Text(
                        "Crop Detected: $_cropName \nDisease Detected: $_diseaseName\nConfidence: $_confidence")
                    : Container(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                        Size(40, 40),
                      ),
                    ),
                    onPressed: () => getImageFromGallery(),
                    child: Text("Import from Gallery")),
                ElevatedButton(
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                        Size(40, 40),
                      ),
                    ),
                    onPressed: () => getImageFromCamera(),
                    child: Text("Click Image")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
