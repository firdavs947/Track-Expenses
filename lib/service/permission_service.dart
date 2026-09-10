import 'package:permission_handler/permission_handler.dart';

class PermissionService {
 static Future<void> requestGalleryPermission() async {
    try {
      var status = await Permission.photos.status;

      if (status == PermissionStatus.granted ||
          status == PermissionStatus.limited) {
        return;
      }

      if (status != PermissionStatus.permanentlyDenied) {
        status = await Permission.photos.request();
        if (status == PermissionStatus.granted ||
            status == PermissionStatus.limited) {
          return;
        }
      }

      return;
    } catch (e) {
      print('Permission error $e');
    }
  }





static Future<void> requestCameraPermission() async {
    try {
      var status = await Permission.camera.status;

      if (status == PermissionStatus.granted ||
          status == PermissionStatus.limited) {
        return;
      }

      if (status != PermissionStatus.permanentlyDenied) {
        status = await Permission.camera.request();
        if (status == PermissionStatus.granted ||
            status == PermissionStatus.limited) {
          return;
        }
      }

      return;
    } catch (e) {
      print('Permission error $e');
    }
  }

}
