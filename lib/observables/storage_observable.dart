import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';

part 'storage_observable.g.dart';

//final FirebaseStorage _storage = FirebaseStorage.instance;

IOSOptions _getIOSOptions() => const IOSOptions(
  accessibility: IOSAccessibility.first_unlock,
);

AndroidOptions _getAndroidOptions() => const AndroidOptions(
  encryptedSharedPreferences: true,
);

const _storage = FlutterSecureStorage();

class StorageState = StorageStateBase with _$StorageState;

abstract class StorageStateBase with Store {

  StorageStateBase({
    required this.userId,
  });

  final int userId;

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
  uploadImage() async {
    if (image == null) {
      return '';
    }
    isLoading = true;
    final Dio _dio = Dio();
    String token = await _storage.read(key: 'token', iOptions: _getIOSOptions(), aOptions: _getAndroidOptions()) ?? '';

    try {
      String fileName = image!.path.split('/').last;
      FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(image!.path, filename:fileName),
      });

      final response = await _dio.post(
        'http://10.0.2.2:80/cabinet/default/update-image',
        data: formData,
        options: Options(
          headers: {
            "Authorization": "Bearer " + token,
          },
          sendTimeout: 50000,
          receiveTimeout: 50000,
        ),
      );
      if (response.statusCode == 200) {
        isLoading = false;
        return 'http://10.0.2.2:80' + response.data;
      }
    } on DioError catch (e) {
      print(e);
    }
    return null;
    // Reference query = _storage
    //     .ref()
    //     .child("user_images/$userId");
    //
    // isLoading = true;
    // UploadTask uploadTask = query.putFile(File(image!.path));
    //
    // await Future.value(uploadTask);
    // isPicked = false;
    // var newUrl = await query.getDownloadURL();
    //
    // await FirebaseAuth.instance.currentUser?.updatePhotoURL(newUrl);
    // isLoading = false;
    //
    // return newUrl;
  }

}