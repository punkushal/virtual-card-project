import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:virtual_card/utils/constants.dart';

class ScanPage extends StatefulWidget {
  static const String routeName = 'scan';
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  List<String> textLines = [];
  bool isScanOver = false;
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

          //Drop Down Item Will Be Dropped Here..
          if (isScanOver)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 1,
                color: Colors.amber.shade100,
                shadowColor: Colors.grey[300],
                child: Column(
                  children: [
                    DropTargetItem(
                        property: ContactProperties.company,
                        onDrop: getDropItem),
                    DropTargetItem(
                        property: ContactProperties.name, onDrop: getDropItem),
                    DropTargetItem(
                        property: ContactProperties.designation,
                        onDrop: getDropItem),
                    DropTargetItem(
                        property: ContactProperties.address,
                        onDrop: getDropItem),
                    DropTargetItem(
                        property: ContactProperties.email, onDrop: getDropItem),
                    DropTargetItem(
                        property: ContactProperties.mobile,
                        onDrop: getDropItem),
                  ],
                ),
              ),
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
        isScanOver = true;
      });
    }
  }

  getDropItem(String property, String value) {}
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

//Drop Item Widget
class DropTargetItem extends StatefulWidget {
  final String property;
  final Function(String, String) onDrop;
  const DropTargetItem(
      {super.key, required this.property, required this.onDrop});

  @override
  State<DropTargetItem> createState() => _DropTargetItemState();
}

class _DropTargetItemState extends State<DropTargetItem> {
  String dropItem = '';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(widget.property),
          ),
          Expanded(
            flex: 2,
            child: DragTarget(
              builder: (context, candidateData, rejectedData) => Container(
                decoration: BoxDecoration(
                  border: candidateData.isNotEmpty
                      ? Border.all(
                          width: 2,
                          color: Colors.green.shade300,
                        )
                      : null,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        dropItem.isEmpty
                            ? 'drop ${widget.property.toLowerCase()}'
                            : dropItem,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                    if (dropItem.isNotEmpty)
                      IconButton(
                        onPressed: () {
                          setState(() {
                            dropItem = '';
                          });
                        },
                        icon: const Icon(Icons.close),
                      ),
                  ],
                ),
              ),
              onAcceptWithDetails: (data) {
                if (dropItem.isEmpty) {
                  dropItem = data.data as String;
                } else {
                  dropItem += ' ${data.data as String}';
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
