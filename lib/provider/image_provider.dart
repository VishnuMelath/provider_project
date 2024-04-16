import 'package:flutter/material.dart';

class ImageProvidr extends ChangeNotifier {
  String image='';
  change(String imagepassed)
  {
    image=imagepassed;
    notifyListeners();  
  }
  String getimage()
  {
    return image;
  }
} 