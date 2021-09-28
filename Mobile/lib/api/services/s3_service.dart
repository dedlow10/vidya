import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';

import '../../amplifyconfiguration.dart';

void configureAmplify() async {
  if (!Amplify.isConfigured) {
    AmplifyAuthCognito authPlugin = AmplifyAuthCognito();
    AmplifyStorageS3 s3Plugin = AmplifyStorageS3();
    Amplify.addPlugins([authPlugin, s3Plugin]);

    try {
      await Amplify.configure(amplifyconfig);
    } catch (e) {
      print('Error ' + e.toString());
    }
  }
}

Future<void> createAndUploadFile(file, fileName) async {
  await configureAmplify();
  try {
    return Amplify.Storage.uploadFile(
      local: file,
      key: fileName + ".mp4",
    );
  } on StorageException catch (e) {
    print('Error uploading file: $e');
  }
}
