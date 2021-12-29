import 'dart:io';
import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tesst/controllers/audioController.dart';

class AudioPost extends StatefulWidget {
  const AudioPost({Key? key}) : super(key: key);

  @override
  _AudioPostState createState() => _AudioPostState();
}

class _AudioPostState extends State<AudioPost> {
  final _audioC = Get.put(AudioController(), permanent: true);
  final _formKey = GlobalKey<FormState>();

  File? file;
  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) return;
    final path = result!.files.single.path!;
    setState(() {
      file = File(path);
    });
  }

  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file!.path) : 'No file selected';
    return Scaffold(
      appBar: AppBar(
        title: Text("Audio Post"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: _audioC.audioTitle,
                  decoration: InputDecoration(
                    labelText: 'write your message',
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                    errorText: _audioC.audioTitle.value.isNotEmpty &&
                            _audioC.audioTitle.value.length > 1
                        ? null
                        : _audioC.audioTitle.value.isEmpty
                            ? null
                            : 'Please enter some message',
                  ),
                  // maxLines: 5,
                ),
              ),
            ),
            Center(
              child: CircleAvatar(
                radius: 30,
                child: IconButton(
                  icon: Icon(
                    Icons.multitrack_audio_outlined,
                    size: 35,
                  ),
                  onPressed: () {
                    selectFile();
                    // Navigator.of(context).pop();
                  },
                ),
              ),
            ),
            Text(fileName),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                },
                child: Text("Submit"))
          ],
        ),
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: Icon(Icons.photo_library),
                      title: Text('Audio from Gallery'),
                      onTap: () {
                        selectFile();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: Text('Record Audio'),
                    onTap: () {
                      //cameraImage();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
