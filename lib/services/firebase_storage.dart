import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:nazarih_mobile/services/firebase_api.dart';

Future<String> downloadUrl(String path) {
  return FirebaseStorage.instance
      .refFromURL('gs://nazarih-9bb05.appspot.com')
      .child(path)
      .getDownloadURL();
}

Future<List<String>> downloadUrls(List paths) async {
  List<String> list = [];
  for (var i = 0; i < paths.length; i++) {
    var temp = await FirebaseStorage.instance
        .refFromURL('gs://nazarih-9bb05.appspot.com')
        .child(paths[i])
        .getDownloadURL();
    list.add(temp.toString());
  }
  return list;
}

void uploadImage(String uid, String phoneNumber) async {
  final reuslt = await FilePicker.platform
      .pickFiles(allowMultiple: false, type: FileType.image);
  if (reuslt == null) return;
  final path = reuslt.files.single.path;
  uploadToStorage(uid, phoneNumber, File(path));
}

Future<String> uploadImages(
    String uid, String phoneNumber, DateTime dateTime) async {
  final reuslt = await FilePicker.platform
      .pickFiles(allowMultiple: true, type: FileType.image);
  if (reuslt == null) return 'failed';
  for (var i = 0; i < reuslt.files.length; i++) {
    final path = reuslt.files[i].path;
    await uploadMultipleToStorage(
        uid, phoneNumber, dateTime, File(path), i, reuslt.files.length);
  }
  return 'done';
}

Future<String> uploadAgainImages(
    String uid, String phoneNumber, DateTime dateTime) async {
  final reuslt = await FilePicker.platform
      .pickFiles(allowMultiple: true, type: FileType.image);
  if (reuslt == null) return 'failed';
  await FirebaseFirestore.instance
      .collection('users')
      .doc(phoneNumber)
      .collection('ads_temp')
      .doc(dateTime.toString())
      .delete();
  for (var i = 0; i < reuslt.files.length; i++) {
    final path = reuslt.files[i].path;
    await uploadMultipleToStorage(
        uid, phoneNumber, dateTime, File(path), i, reuslt.files.length);
  }
  return 'done';
}

Future<String> uploadDelegateImages(DateTime dateTime) async {
  final reuslt = await FilePicker.platform
      .pickFiles(allowMultiple: true, type: FileType.image);
  if (reuslt == null) return 'failed';
  for (var i = 0; i < reuslt.files.length; i++) {
    final path = reuslt.files[i].path;
    await uploadDelegateMultipleToStorage(
        dateTime, File(path), i, reuslt.files.length);
  }
  return 'done';
}

void uploadToStorage(String uid, String phoneNumber, File file) {
  if (file == null) return;

  final dateTime = DateTime.now();
  final path = '$uid/profile/$dateTime';
  FirebaseApi.uploadFile(path, file).then((_) => {
        FirebaseFirestore.instance
            .collection('users')
            .doc(phoneNumber)
            .update({'photo_url': path})
      });
}

void uploadMultipleToStorage(String uid, String phoneNumber, DateTime dateTime,
    File file, int index, int total) async {
  if (file == null) return;

  var rng = new Random();
  var number = rng.nextInt(100);
  final path = '$uid/ads/$dateTime/$number';
  await FirebaseApi.uploadFile(path, file).then((_) async {
    var exist = await FirebaseFirestore.instance
        .collection('users')
        .doc(phoneNumber)
        .collection('ads_temp')
        .doc(dateTime.toString())
        .get();
    (exist.exists)
        ? FirebaseFirestore.instance
            .collection('users')
            .doc(phoneNumber)
            .collection('ads_temp')
            .doc(dateTime.toString())
            .update({'photo_url $index': path, 'photo_limit': total})
        : FirebaseFirestore.instance
            .collection('users')
            .doc(phoneNumber)
            .collection('ads_temp')
            .doc(dateTime.toString())
            .set({'photo_url $index': path, 'photo_limit': total});
  });
}

void uploadDelegateMultipleToStorage(
    DateTime dateTime, File file, int index, int total) async {
  if (file == null) return;

  var rng = new Random();
  var number = rng.nextInt(100);
  final path = 'delegate/$dateTime/$number';
  await FirebaseApi.uploadFile(path, file).then((_) async {
    var exist = await FirebaseFirestore.instance
        .collection('delegate_temp')
        .doc(dateTime.toString())
        .get();
    (exist.exists)
        ? FirebaseFirestore.instance
            .collection('delegate_temp')
            .doc(dateTime.toString())
            .update({'photo_url $index': path, 'photo_limit': total})
        : FirebaseFirestore.instance
            .collection('delegate_temp')
            .doc(dateTime.toString())
            .set({'photo_url $index': path, 'photo_limit': total});
  });
}
