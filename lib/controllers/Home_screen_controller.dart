import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class HOmeScreenController extends GetxController {
  List<String> productslist = [];
  Future<List<String>> retrieveFiles() async {
    final ref = FirebaseStorage.instance.ref().child('your_folder_name');
    ListResult result = await ref.listAll();
    result.items.forEach((Reference ref) async {
      String downloadURL = await ref.getDownloadURL();
      productslist.add(downloadURL);
    });
    return productslist;
  }
}
