import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class ImageSelectionModel extends ChangeNotifier {
  XFile? _imgXFile;

  XFile? get imgXFile => _imgXFile;

  set imgXFile(XFile? value) {
    _imgXFile = value;
    notifyListeners(); // Notify listeners when imgXFile changes
  }

  void getImageFromGallery(ImagePicker imagePicker) async {
    _imgXFile = await imagePicker.pickImage(source: ImageSource.gallery);
    notifyListeners(); // Notify listeners after picking image
  }
}