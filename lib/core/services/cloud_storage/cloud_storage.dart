import 'dart:io';

abstract class CloudStorage {
  Future<String> uploadFile(File file, String path);
  
}
