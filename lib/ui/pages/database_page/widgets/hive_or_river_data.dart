// import 'package:flutter/material.dart';

// class HiveOrRiverData extends StatelessWidget {
//   final int itemCount;
//   final BoxBorder border;
//   final String title;
//   final String body;
//   const HiveOrRiverData({super.key, required this.itemCount, required this.border, required this.title, required this.body});

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       flex: 8,
//       child: ListView.builder(
//                 itemCount: itemCount,
//                 itemBuilder: (context, index) {
//                   return Container(
//                     margin: const EdgeInsets.symmetric(horizontal: 8),
//                     decoration: BoxDecoration(
//                         border: border),
//                     child: ListTile(
//                       title: Text(
//                         title,
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         style: const TextStyle(
//                             color: Colors.green, fontWeight: FontWeight.w700,fontSize: 20),
//                       ),
//                       subtitle: Text(
//                         body,
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                         style: const TextStyle(
//                           fontSize: 18,
//                           color: Colors.white
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//     );
//   }
// }