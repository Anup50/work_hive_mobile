// import 'package:flutter/material.dart';
// import 'package:work_hive_mobile/view/application_report.dart';
// import 'package:work_hive_mobile/features/home/presentation/view/bottom_view/dashboard_view.dart';
// import 'package:work_hive_mobile/view/profile_view.dart';

// class HomeView extends StatefulWidget {
//   const HomeView({super.key});

//   @override
//   State<HomeView> createState() => _HomeViewState();
// }

// class _HomeViewState extends State<HomeView> {
//   int _selectedIndex = 0;

//   final List<Widget> _bottomScreens = [
//     const DashboardView(),
//     const ApplicationReport(),
//     const ProfileView(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: IndexedStack(
//         index: _selectedIndex,
//         children: _bottomScreens,
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: Colors.white, 
//         type: BottomNavigationBarType.fixed,
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.black, 
//         unselectedItemColor: Colors.grey, 
//         onTap: (index) {
//           setState(() {
//             _selectedIndex = index;
//           });
//         },
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.work),
//             label: '',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.list_alt),
//             label: '',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: '',
//           ),
//         ],
//       ),
//     );
//   }
// }
