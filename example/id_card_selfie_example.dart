import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:id_card_selfie/id_card_selfie.dart';


main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ExampleCameraOverlay(),
  );
}

class ExampleCameraOverlay extends StatefulWidget {
  const ExampleCameraOverlay({Key? key}) : super(key: key);

  @override
  _ExampleCameraOverlayState createState() => _ExampleCameraOverlayState();
}

class _ExampleCameraOverlayState extends State<ExampleCameraOverlay> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.white,
          body: FutureBuilder<List<CameraDescription>?>(
            future: availableCameras(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data == null) {
                  return const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'No camera found',
                        style: TextStyle(color: Colors.black),
                      ));
                }
                return IDCardSelfie(
                    snapshot.data!.first,
                    (XFile file){
                      print(file.path);
                    },
                    info:
                    'Position your body and ID card within the frame and ensure the image is perfectly readable.',
                    label: 'ID Card Selfie');
              } else {
                return const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Fetching cameras',
                      style: TextStyle(color: Colors.black),
                    ));
              }
            },
          ),
        ));
  }
}
