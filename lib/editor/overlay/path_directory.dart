// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../data_parse.dart';
// import '../../provider/path_privider_lib.dart';
//
// //Main Splines on left side
// class PathDirectory extends ConsumerStatefulWidget {
//   final int id;
//   const PathDirectory({super.key, required this.id});
//
//   @override
//   ConsumerState<PathDirectory> createState() => _PathObjectState();
// }
//
// class _PathObjectState extends ConsumerState<PathDirectory> {
//   static const IconData modeEditOutlined =
//       IconData(0xf1d8, fontFamily: 'MaterialIcons');
//   static const IconData visibilityOffOutlined =
//       IconData(0xf4a0, fontFamily: 'MaterialIcons');
//   static const IconData visibilityOutlined =
//       IconData(0xf4a1, fontFamily: 'MaterialIcons');
//   static const IconData deleteOutlined =
//       IconData(0xefa8, fontFamily: 'MaterialIcons');
//
//   bool edit = false;
//   bool showPath = true;
//
//   @override
//   Widget build(BuildContext context) {
//     //set edit variable if own id is found in edit provider
//     if (ref.watch(pathDirectoryIdProvider) == widget.id) {
//       setState(() {
//         edit = true;
//       });
//     } else {
//       setState(() {
//         edit = false;
//       });
//     }
//
//     return Padding(
//         padding: const EdgeInsets.only(top: 8),
//         child: ListTile(
//           title: edit == true
//               //return Lined/Filled Button coresponding to edit variable
//               ? FilledButton(
//                   onPressed:
//                       ref.watch(pathDirectoryLockProvider) ? null : () {},
//                   child: const Icon(modeEditOutlined),
//                 )
//               : OutlinedButton(
//                   onPressed: ref.watch(pathDirectoryLockProvider)
//                       ? null
//                       : () {
//                           setState(() {
//                             //set edit to true and change editing privider id
//                             edit = true;
//                             ref
//                                 .read(shownSplinesProvider.notifier)
//                                 .update(widget.id, true);
//                             showPath = true;
//                             ref
//                                 .read(pathDirectoryIdProvider.notifier)
//                                 .set(widget.id);
//                             //show spline creaton window
//                             ref.read(cncModeProvider.notifier).set(true);
//                           });
//                         },
//                   child: const Icon(modeEditOutlined),
//                 ),
//           //hide Button
//           trailing: Visibility(
//             visible: !edit,
//             replacement: OutlinedButton(
//                 onPressed: ref.watch(pathDirectoryLockProvider)
//                     ? null
//                     : () {
//                         ref
//                             .read(entityProvider.notifier)
//                             .removeDirectory(ref.read(pathDirectoryIdProvider));
//                         ref
//                             .read(pathDirectoryProvider.notifier)
//                             .remove(ref.read(pathDirectoryIdProvider));
//
//                         //close edit overlay
//                         ref.read(cncModeProvider.notifier).set(false);
//                         ref.read(pathDirectoryIdProvider.notifier).set(0);
//                         ref.read(pathDirectoryLockProvider.notifier).set(false);
//                         ref.read(showModelProvider.notifier).set(true);
//                       },
//                 //change icon
//                 child: const Icon(deleteOutlined)),
//             child: OutlinedButton(
//               onPressed: ref.watch(pathDirectoryLockProvider)
//                   ? null
//                   : () {
//                       setState(() {
//                         //set show path variable
//                         if (showPath == true) {
//                           showPath = false;
//                           ref
//                               .read(shownSplinesProvider.notifier)
//                               .update(widget.id, false);
//                         } else {
//                           showPath = true;
//                           ref
//                               .read(shownSplinesProvider.notifier)
//                               .update(widget.id, true);
//                         }
//                       });
//                     },
//               //change icon
//               child: showPath == true
//                   ? const Icon(visibilityOutlined)
//                   : const Icon(visibilityOffOutlined),
//             ),
//           ),
//         ));
//   }
// }
//
// //Button for spline creaton
// class CreatePathButton extends ConsumerWidget {
//   const CreatePathButton({super.key});
//
//   static const IconData addBoxOutlined =
//       IconData(0xee3c, fontFamily: 'MaterialIcons');
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 8, left: 15, right: 22, bottom: 8),
//       child: OutlinedButton(
//         onPressed: ref.watch(pathDirectoryLockProvider)
//             ? null
//             : () {
//                 //open edit overlay
//                 ref.read(cncModeProvider.notifier).set(true);
//                 int newDirId =
//                     ref.read(pathDirectoryProvider.notifier).getNewId();
//                 ref
//                     .read(pathDirectoryProvider.notifier)
//                     .add(newDirId, PathDirectory(id: newDirId));
//                 ref.read(shownSplinesProvider.notifier).update(newDirId, true);
//                 ref
//                     .read(pathDirectoryIdProvider.notifier)
//                     .set(newDirId); //set new id as active window
//                 ref.read(entityProvider.notifier).newDirectory(
//                     newDirId); //create new directory in main data structure
//               },
//         child: const Icon(addBoxOutlined),
//       ),
//     );
//   }
// }
