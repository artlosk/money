
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';

part 'storage_observable.g.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;

class StorageState = StorageStateBase with _$StorageState;

abstract class StorageStateBase with Store {

  StorageStateBase({
    required this.userId,
  });

  final String userId;

  final _picker = ImagePicker();

  @observable
  XFile? image;

  @observable
  bool isPicked = false;

  @observable
  bool isLoading = false;

  Future<XFile?> getImageFromGallery() async {
    image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      isPicked = true;
    }
    return null;
  }

  @action
  Future<String> uploadImage() async {
    if (image == null) {
      return '';
    }

    Reference query = _storage
        .ref()
        .child("user_images/$userId");

    isLoading = true;
    UploadTask uploadTask = query.putFile(File(image!.path));

    await Future.value(uploadTask);
    isPicked = false;
    var newUrl = await query.getDownloadURL();

    await FirebaseAuth.instance.currentUser?.updatePhotoURL(newUrl);
    isLoading = false;

    return newUrl;
  }

}