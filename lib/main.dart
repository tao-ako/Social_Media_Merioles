import 'package:flutter/material.dart';

import 'model/commentstore.dart';
import 'socialmedia.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CommentStore.initialize();
  runApp(const TikTokTokApp());
}
