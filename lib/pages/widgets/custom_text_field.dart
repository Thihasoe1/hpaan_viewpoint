// import 'package:flutter/material.dart';
// import 'package:hpaan_viewpoint/pages/widgets/scale_tapper.dart';

// class CustomTextField extends StatefulWidget {
//   const CustomTextField({
//     super.key,
//     required this.textEditingController,
//     required this.hintText,
//     this.textInputType,
//     this.isPassword = false,
    
//   });

//   final TextEditingController textEditingController;
//   final String hintText;
//   final TextInputType? textInputType;
//   final bool isPassword;
  

//   @override
//   State<CustomTextField> createState() => _CustomTextFieldState();
// }

// class _CustomTextFieldState extends State<CustomTextField> {
//   bool _isVisible = false;

//   void setIsVisible() {
//     setState(() {
//       _isVisible = !_isVisible;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
      
//       controller: widget.textEditingController,
//       cursorColor: Colors.teal,
//       keyboardType: widget.textInputType,
//       style: const TextStyle(
//         fontFamily: "SF-Pro",
//         fontWeight: FontWeight.w400,
//         fontSize: 14,
//       ),
//       obscureText: !_isVisible && widget.isPassword,
//       decoration: InputDecoration(
//         hintText: widget.hintText,
//         hintStyle: const TextStyle(
//           fontSize: 14,
//           fontWeight: FontWeight.w400,
//           fontFamily: 'SF-Pro',
//           color: Colors.grey,
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(
//             color: Colors.grey.withOpacity(0.8),
//           ),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: const BorderSide(
//             color: Colors.teal,
//             width: 1.4,
//           ),
//         ),
//         //border: const OutlineInputBorder(),
//         contentPadding: const EdgeInsets.symmetric(
//           vertical: 0,
//           horizontal: 10,
//         ),
//         suffixIcon: widget.isPassword
//             ? ScaleTapper(
//                 onTap: setIsVisible,
//                 child: Icon(
//                   !_isVisible
//                       ? Icons.visibility_outlined
//                       : Icons.visibility_off_outlined,
//                   color: const Color.fromRGBO(184, 184, 184, 1),
//                   size: 22,
//                 ),
//               )
//             : const SizedBox(),
//       ),
//     );
//   }
// }
