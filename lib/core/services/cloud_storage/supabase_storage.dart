// import 'dart:io';

// import 'package:social_network_app/core/services/cloud_storage/cloud_storage.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:path/path.dart' as p;

// class SupabaseStorageService implements CloudStorage {
//   static late Supabase _supabase;

//   static Future<void> initialize() async {
//     _supabase = await Supabase.initialize(
//       url: KSupabaseUrl,
//       anonKey: KSupabaseKey,
//     );
//   }

//   static createBucket(String bucketName) async {
//     // Check if bucket exist
//     var buckets = await _supabase.client.storage.listBuckets();

//     // flag
//     bool isBucketExist = false;

//     // if bucket exist return
//     for (var bucket in buckets) {
//       if (bucket.id == bucketName) {
//         isBucketExist = true;
//         break;
//       }
//     }
//     // if bucket not exist create
//     if (!isBucketExist) {
//       await _supabase.client.storage.createBucket(bucketName);
//     }
//   }

//   @override
//   Future<String> uploadFile(File file, String path) async {
//     String fileName = p.basename(file.path);
//     String extensionName = p.extension(fileName);
//     var result = await _supabase.client.storage
//         .from('fruits_images')
//         .upload('$path/$fileName.$extensionName', file);

//     final String publicUrl = _supabase.client.storage
//         .from('fruits_images')
//         .getPublicUrl('$path/$fileName.$extensionName');
//     print(publicUrl);

//     return result;
//   }
// }