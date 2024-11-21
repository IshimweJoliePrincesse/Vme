import 'dart:io';
import 'package: camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:electa/utils/app_colors.dart';
import 'package: electa/view/login_screen.dart';
import 'package: electa/view/profile.dart';
import 'package: electa/view/setting_screen.dart';
import 'package: http/http.dart' as http;

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {

  CameraController? cameraController;
  bool isInitialized = false;
  File? _imageFile;
  bool auth = false;

  @override

  void initState() {
    initializeCamera();
    super.initState();
  }

  Future<void> initializeCamera() async{
    WidgetsFlutterBinding.ensureInitialized();
    final cameras = await availableCameras();
    final frontCamera = cameras.firstWhere((camera)=>camera.lensDirection === CameraLensDirection.front);
    cameraController = CameraController(frontCamera, ResolutionPreset.ultraHight, enableAudio: false);
    await cameraController!.initialize();
    setState((){
      isInitialized = true;
    })
  }

  Future<void> _getImageFromCamera() async {
    if(!isInitialized) return;

    try {
      final XFile imageFile = await cameraController!.takePicture();
      if(imageFile != null){
        setState((){
          _imageFile = File(imageFile.path);
        });
      }

      _uploadImage();
    } catch(e) {
      print("Error taking picture: $e");
    }
  } 

  Future<void> _uploadImage() async {
    if(_imageFile == null) return;

  //setState((){
  // loading = true;
  // message = '';});

  final url = Uri.parse('http://192.168.100.26:5000/verify-face');
  final request = http.MultipartRequest('POST', url);
  request.files.add(
    await http.MultipartFile.fromPath(
      'capturedImg',
      _imageFile!.path,
    ),
  );

  final  response = await request.send();
  print(response.statusCode);
  if(response.statusCode == 200) {
    print("Image uploaded successfully");

    // setState((){
    //   loading = false;
    //   message = ''

    // });
    auth= true;
    Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => LoginScreen(auth: auth,))
    );
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Face Verified'), backgroundColor: Colors.green,));
  } else {
    // setState((){
    //   loading = false;
    //   message = 'Try again Login Failed';

    // });

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to verify face'), backgroundColor: Colors.red));

    print('Failed to login: ${response.reasonPhrase} and status code: ${response.statusCode}');

    Navigator.pop(context);


  }
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(isInitialized && _imageFile == null) AspectRation(aspectRatio:3/4, child: CameraPreview(cameraController!)),
              const SizedBox(height: 10,),
              if(_imageFile != null) Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
                child: const Column(mainAxisAlignment: MainAxisAlignment.center, children: [Center(child: Image(width: 180, image: AssetImage('assets/images/face-id.png')),), SizedBox(height: 25,), Center(child: CupertinoActivityIndicator(radius: 20, color:Colors.green,)), Text('Verifying Face', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20), ), Text('Please wait for a few seconds')],),

              ) else const Center(child: Text('Capture Face, click below', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20), ))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _getImageFromCamera();
        },
        backgroundColor: primaryColor,
        child: const Icon(Icons.camera, color: Colors.white,),
      ),
    );
  }
}

//Image.File(_imageFile!, width: 100)