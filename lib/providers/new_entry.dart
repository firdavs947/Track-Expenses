import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:track_expenses/gen/assets.gen.dart';
import 'package:track_expenses/models/expense_model.dart';
import 'package:track_expenses/service/database_service.dart';

class NewEntry extends ChangeNotifier {
  File? photo;


  static final List<String> imageExtensions = [
    '.png', '.jpg', '.jpeg', '.gif', '.bmp', '.webp', '.heic'
  ];

    static final List<String> musicExtensions = [
    '.mp3', '.wav', '.aac', '.m4a', '.ogg', '.flac', '.wma'
  ];


  List category = [
    Assets.icons.home,
    Assets.icons.food,
    Assets.icons.transit,
    Assets.icons.foodsMarket,
    Assets.icons.biils,
    Assets.icons.more,
  ];
  List categorytext = ['HOME', 'FOOD', 'TRANSIT', 'SHOP', 'BILLS', 'MORE'];

  int currentCategory = 0;

  bool isLoading = false;

  // bool expense = true;
  // bool income = false;
  void onPageChanged(int index) {
    currentCategory = index;
    notifyListeners();
  }

  int selectedindex2 = 0;
  void selected2(int index) {
    selectedindex2 = index;
    notifyListeners();
  }

  int selectedindex = 0;
  void selected(int index) {
    selectedindex = index;
    notifyListeners();
  }

  Future<void> sendincome({
    required ExpenseModel expense,
    required Function onError,
    required Function onSuccess,
  }) async {
    isLoading = true;
    notifyListeners();
    try {
      await DatabaseService.addExpenseToDb(
        ExpenseModel(
          image: photo?.path,
          id: 0,
          value: expense.value,
          income: expense.income,
          type: expense.type,
          note: expense.note,
        ),
      );
      onSuccess();
    } catch (e) {
      onError();
    } finally {
      isLoading = false;
    }
  }

  // XFile? pickedImage;
  Future<void> pickImageFromGallery({required Function onSuccess}) async {
    final picker = ImagePicker();
    final result = await picker.pickImage(
      imageQuality: 100,
      source: ImageSource.gallery,
    );

    // final result = await picker.pickMultiImage( imageQuality: 100);
    if (result != null) {
      photo = File(result.path);
    }
    onSuccess();
    notifyListeners();
  }
  // final result = await ImagePicker.platform.getImageFromSource(
  //   source: ImageSource.gallery,
  // );
  // if (result != null) {
  //   pickedImage = result;
  //   notifyListeners();
  //   onSuccess();
  // }

  Future<void> pickImageFromCamera({required Function onSuccess}) async {
    try {
      final picker = ImagePicker();
      final result = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 100,
      );
      if (result != null) {
        photo = File(result.path);
        notifyListeners();
        onSuccess();
      }
    } catch (e) {
      print('Error on pick image $e');
    }
  }

  Future<void> pickFileFromFolder({required Function onSuccess}) async {
    final result = await FilePicker.pickFile(
      type: FileType.any,
      dialogTitle: 'Pick File:',
    );
    if (result?.xFile != null) {
      photo = File(result!.xFile.path);
      notifyListeners();
      onSuccess();

    }
  }

  bool get isPhotoImage {
    if (photo == null) return false;
    final ext = path.extension(photo!.path).toLowerCase();
    return imageExtensions.contains(ext);
  }

 bool get isPhotoMusic {
    if (photo == null) return false;
    final ext = path.extension(photo!.path).toLowerCase();
    return musicExtensions.contains(ext);
  }

}
