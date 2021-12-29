import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;

class VideoPost extends StatefulWidget {
  const VideoPost({Key? key}) : super(key: key);

  @override
  _VideoPostState createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost> {
  File? _image;
  final picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;



  Future uploadImage() async{
    final uri =
    Uri.parse('https://coonch.com/admin/api/add-video');
    var request = http.MultipartRequest("POST", uri);
    request.fields['videoTitle'] = 'tt';
    request.fields['user_id'] =  1.toString();
    request.fields['category'] = 2.toString();
    request.fields['subCategory'] = 1.toString();
    var pic = await http.MultipartFile.fromPath('videoUrl', _image!.path);
    request.files.add(pic);

    var response = await request.send();

    if (response.statusCode == 200) {
      print('Image uploaded');
      Navigator.pop(context);
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => HomePage(),
      //   ),
      // );
    } else {
      print("Failed to upload");
      print(response);
    }
  }

  Future choiceImage() async {
    var pickedImage = await picker.pickImage(
        source: ImageSource.gallery,  imageQuality: 50
        //maxDuration: const Duration(minutes: 03)
    );
    setState(() {
      _image = File(pickedImage!.path);
    });
  }

  Future cameraImage() async {
    var pickedImage = await picker.pickVideo(
      source: ImageSource.camera,
      maxDuration: Duration(minutes: 10),
    );
    setState(() {
      _image = File(pickedImage!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video post"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some message';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: 'write your message',border: OutlineInputBorder(
                  borderRadius:  BorderRadius.circular(25.0),
                  borderSide:  BorderSide(
                  ),
                ),),
                maxLines: 5,
              ),
            ),
            Center(
                child: _image == null
                    ? CircleAvatar(
                    radius: 30,
                    child: IconButton(
                        icon: Icon(
                          Icons.video_call,
                          size: 35,
                        ),
                        onPressed: () {
                          _showPicker(context);
                        }))
                    : SizedBox(
                  height: 300,
                  child: Chewie(
                    controller: ChewieController(
                        videoPlayerController:
                        VideoPlayerController.file(_image!),aspectRatio: 3/4),
                  ),
                )),
            !isLoading
                ?
            ElevatedButton(onPressed: (){
              if (_formKey.currentState!.validate()) {
                // If the form is valid, display a snackbar. In the real world,
                // you'd often call a server or save the information in a database.
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data')),
                );
                uploadImage();
                setState(() {
                  isLoading = true;
                });
              }
            } , child: Text("Submit"),
            ): Container(width: 50, child: CircularProgressIndicator())
          ] ,
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
              child:  Wrap(
                children: <Widget>[
                   ListTile(
                      leading: Icon(Icons.photo_library),
                      title: Text('Video from Gallery'),
                      onTap: () {
                        choiceImage();
                        Navigator.of(context).pop();
                      }),
                   ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: Text('Record Video'),
                    onTap: () {
                      cameraImage();
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
