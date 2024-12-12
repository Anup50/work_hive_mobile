// import 'package:flutter/material.dart';
// import 'package:work_hive_mobile/app.dart';

// void main() {
//   runApp(
//     const MaterialApp(
//       initialRoute: '/',
//       routes: {},
//       home: MyApp(),
//     ),
//   );
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import provider package
import 'package:work_hive_mobile/view_model/onbord_view_model.dart';

import 'app.dart'; // Your app.dart file

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) =>
                OnboardingViewModel()), // Provide the OnboardingViewModel
      ],
      child: const MyApp(),
    ),
  );
}
