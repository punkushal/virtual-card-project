import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

class ScanPage extends StatefulWidget {
  static const String routeName = 'scan';
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  List<String> textLines = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Page'),
      ),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () {
                  getImage(ImageSource.camera);
                },
                icon: const Icon(Icons.camera_alt_outlined),
                label: const Text('Capture'),
              ),
              TextButton.icon(
                onPressed: () {
                  getImage(ImageSource.gallery);
                },
                icon: const Icon(Icons.photo),
                label: const Text('Choose'),
              ),
            ],
          ),

          //For Displaying Extracted Texts From Image
          Wrap(
            children: textLines
                .map(
                  (line) => LineItem(line: line),
                )
                .toList(),
          )
        ],
      ),
    );
  }

  void getImage(ImageSource camera) async {
    final picker = ImagePicker();
    final xFile = await picker.pickImage(source: camera);
    if (xFile != null) {
      EasyLoading.show(
        status: 'Loading file....',
      );
      final textRecognizer =
          TextRecognizer(script: TextRecognitionScript.latin);
      final recognizedText = await textRecognizer.processImage(
        InputImage.fromFile(
          File(xFile.path),
        ),
      );
      EasyLoading.dismiss();
      final List<String> tempList = [];
      for (var block in recognizedText.blocks) {
        for (var line in block.lines) {
          tempList.add(line.text);
        }
      }
      setState(() {
        textLines = tempList;
      });
    }
  }
}

class LineItem extends StatelessWidget {
  final String line;
  const LineItem({super.key, required this.line});

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable(
      data: line,
      feedback: Container(
        //Unique key for each draggable feedback
        key: GlobalKey(),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.black54, borderRadius: BorderRadius.circular(8)),
        child: Text(
          line,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Chip(
          label: Text(line),
        ),
      ),
    );
  }
}
