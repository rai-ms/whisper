import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../data/app_exceptions/app_exception.dart';
import '../model/comment.dart';
import '../model/user.dart';
import '../model/like.dart';
import '../model/post_model.dart';
import '../utils/app_helper/app_strings.dart';

const Duration apiTimeOut = Duration(minutes: 2);

bool isNullOrEmpty(dynamic value) {
  if (value == null) {
    return true;
  } else {
    if (value is List || value is String) {
      return value.isEmpty;
    } else {
      return value == AppStrings.emptyString;
    }
  }
}

void printDebug(dynamic object) {
  if (kDebugMode) {
    print(object);
  }
}

String convertNA(data) {
  try {
    if (data != null || data != AppStrings.emptyString) {
      return data.toString();
    } else {
      return AppStrings.na;
    }
  } catch (e) {
    throw UnableToConvert(AppStrings.dataTypeMismatch);
  }
}

SizedBox sizedBox({double? hei, double? wid}) {
  return SizedBox(
    height: hei ?? 0.0,
    width: wid ?? 0.0,
  );
}

double getFullHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double getFullWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

getViewPadding(BuildContext context) {
  return MediaQuery.of(context).viewPadding;
}

// GlobalKey<ScaffoldMessengerState> navigatorKeyNew =
// GlobalKey<ScaffoldMessengerState>();
// GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
// GlobalKey<ScaffoldMessengerState> navigatorScaffoldKey =
// GlobalKey<ScaffoldMessengerState>();

/// Below are the dummy models and list created for checking
// List<Post> generateDummyPosts({String id = "sdfvwasdfafsvrjt", int count = 10}) {
//   return List<Post>.generate(count, (index) {
//     return Post(
//       postDescription: 'Post $index description Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum eleifend orci non dui tincidunt, et vehicula metus tincidunt. Sed eget metus eu elit euismod fermentum. Donec quis tristique sapien, nec feugiat dolor. Sed non semper metus. Sed bibendum id justo non viverra. Aliquam eget dolor nec dui viverra vestibulum ac eu sem. Nulla tincidunt varius dui, id blandit augue tincidunt non. Donec interdum dolor nec viverra sodales. Nullam sollicitudin bibendum metus, in iaculis justo euismod at. Praesent ullamcorper, justo sit amet malesuada lacinia, quam ex feugiat urna, sed condimentum massa elit sed orci. Nulla facilisi. Sed tincidunt urna non dui auctor, sit amet tempus turpis eleifend',
//       image: 'https://m.media-amazon.com/images/I/918rExPk6fL._AC_UF1000,1000_QL80_.jpg',
//       postedAt: '2023-08-12 14:00:00',
//       postedBy: 'rai-ms',
//       likes: [
//         Like(id: 'like$id', likedBy: 'user$id', postedBy: 'user$id', createdAt: '2023-08-12 14:00:00')],
//       comments: [
//         Comment(
//           id: 'comment$id',
//           commentBy: 'user$id',
//           postedBy: 'user$id',
//           createdAt: '2023-08-12 14:00:00',
//           content: 'Great post! 👍',
//           reply: [
//             Comment(
//               id: 'comment$id',
//               commentBy: 'user$id',
//               postedBy: 'user$id',
//               createdAt: '2023-08-12 14:00:00',
//               content: 'Great post! 👍',
//               reply: [],
//             ),
//             Comment(
//               id: 'comment$id',
//               commentBy: 'user$id',
//               postedBy: 'user$id',
//               createdAt: '2023-08-12 14:00:00',
//               content: 'Love it! ❤️',
//               reply: [],
//             ),
//             Comment(
//               id: 'comment$id',
//               commentBy: 'user$id',
//               postedBy: 'user$id',
//               createdAt: '2023-08-12 14:00:00',
//               content: 'This is amazing! 😍',
//               reply: [],
//             ),
//             Comment(
//               id: 'comment$id',
//               commentBy: 'user$id',
//               postedBy: 'user$id',
//               createdAt: '2023-08-12 14:00:00',
//               content: 'So cool! 🙌',
//               reply: [],
//             ),
//             Comment(
//               id: 'comment$id',
//               commentBy: 'user$id',
//               postedBy: 'user$id',
//               createdAt: '2023-08-12 14:00:00',
//               content: 'Awesome post! 👏',
//               reply: [],
//             ),
//             Comment(
//               id: 'comment$id',
//               commentBy: 'user$id',
//               postedBy: 'user$id',
//               createdAt: '2023-08-12 14:00:00',
//               content: 'Can\'t wait to try this! 🤩',
//               reply: [
//                 Comment(
//                   id: 'comment$id',
//                   commentBy: 'user$id',
//                   postedBy: 'user$id',
//                   createdAt: '2023-08-12 14:00:00',
//                   content: 'Looks fantastic! 💫',
//                   reply: [],
//                 ),
//                 Comment(
//                   id: 'comment$id',
//                   commentBy: 'user$id',
//                   postedBy: 'user$id',
//                   createdAt: '2023-08-12 14:00:00',
//                   content: 'I want to be there! 🌴',
//                   reply: [],
//                 ),
//                 Comment(
//                   id: 'comment$id',
//                   commentBy: 'user$id',
//                   postedBy: 'user$id',
//                   createdAt: '2023-08-12 14:00:00',
//                   content: 'Incredible shot! 📷',
//                   reply: [],
//                 ),
//               ],
//             ),
//           ],
//         ),
//         Comment(
//           id: 'comment$id',
//           commentBy: 'user$id',
//           postedBy: 'user$id',
//           createdAt: '2023-08-12 14:00:00',
//           content: 'Love it! ❤️',
//           reply: [],
//         ),
//         Comment(
//           id: 'comment$id',
//           commentBy: 'user$id',
//           postedBy: 'user$id',
//           createdAt: '2023-08-12 14:00:00',
//           content: 'This is amazing! 😍',
//           reply: [],
//         ),
//         Comment(
//           id: 'comment$id',
//           commentBy: 'user$id',
//           postedBy: 'user$id',
//           createdAt: '2023-08-12 14:00:00',
//           content: 'So cool! 🙌',
//           reply: [
//             Comment(
//               id: 'comment$id',
//               commentBy: 'user$id',
//               postedBy: 'user$id',
//               createdAt: '2023-08-12 14:00:00',
//               content: 'Great post! 👍',
//               reply: [],
//             ),
//             Comment(
//               id: 'comment$id',
//               commentBy: 'user$id',
//               postedBy: 'user$id',
//               createdAt: '2023-08-12 14:00:00',
//               content: 'Love it! ❤️',
//               reply: [],
//             ),
//             Comment(
//               id: 'comment$id',
//               commentBy: 'user$id',
//               postedBy: 'user$id',
//               createdAt: '2023-08-12 14:00:00',
//               content: 'This is amazing! 😍',
//               reply: [],
//             ),
//             Comment(
//               id: 'comment$id',
//               commentBy: 'user$id',
//               postedBy: 'user$id',
//               createdAt: '2023-08-12 14:00:00',
//               content: 'So cool! 🙌',
//               reply: [],
//             ),
//             Comment(
//               id: 'comment$id',
//               commentBy: 'user$id',
//               postedBy: 'user$id',
//               createdAt: '2023-08-12 14:00:00',
//               content: 'Awesome post! 👏',
//               reply: [],
//             ),
//             Comment(
//               id: 'comment$id',
//               commentBy: 'user$id',
//               postedBy: 'user$id',
//               createdAt: '2023-08-12 14:00:00',
//               content: 'Can\'t wait to try this! 🤩',
//               reply: [
//                 Comment(
//                   id: 'comment$id',
//                   commentBy: 'user$id',
//                   postedBy: 'user$id',
//                   createdAt: '2023-08-12 14:00:00',
//                   content: 'Looks fantastic! 💫',
//                   reply: [],
//                 ),
//                 Comment(
//                   id: 'comment$id',
//                   commentBy: 'user$id',
//                   postedBy: 'user$id',
//                   createdAt: '2023-08-12 14:00:00',
//                   content: 'I want to be there! 🌴',
//                   reply: [],
//                 ),
//                 Comment(
//                   id: 'comment$id',
//                   commentBy: 'user$id',
//                   postedBy: 'user$id',
//                   createdAt: '2023-08-12 14:00:00',
//                   content: 'Incredible shot! 📷',
//                   reply: [],
//                 ),
//               ],
//             ),
//           ],
//         ),
//         Comment(
//           id: 'comment$id',
//           commentBy: 'user$id',
//           postedBy: 'user$id',
//           createdAt: '2023-08-12 14:00:00',
//           content: 'Awesome post! 👏',
//           reply: [],
//         ),
//         Comment(
//           id: 'comment$id',
//           commentBy: 'user$id',
//           postedBy: 'user$id',
//           createdAt: '2023-08-12 14:00:00',
//           content: 'Can\'t wait to try this! 🤩',
//           reply: [
//             Comment(
//               id: 'comment$id',
//               commentBy: 'user$id',
//               postedBy: 'user$id',
//               createdAt: '2023-08-12 14:00:00',
//               content: 'Looks fantastic! 💫',
//               reply: [],
//             ),
//             Comment(
//               id: 'comment$id',
//               commentBy: 'user$id',
//               postedBy: 'user$id',
//               createdAt: '2023-08-12 14:00:00',
//               content: 'I want to be there! 🌴',
//               reply: [],
//             ),
//             Comment(
//               id: 'comment$id',
//               commentBy: 'user$id',
//               postedBy: 'user$id',
//               createdAt: '2023-08-12 14:00:00',
//               content: 'Incredible shot! 📷',
//               reply: [],
//             ),
//           ],
//         ),
//
//       ],
//       report: ['user$id'],
//     );
//   });
// }

String image =
    "https://media.licdn.com/dms/image/C4E03AQEXPYjYIiM28Q/profile-displayphoto-shrink_400_400/0/1636546284775?e=1703116800&v=beta&t=5m04P8rVql9nM3_VqrHqWGfurB361_lnLyWb9Zz9zts";
String name = "Ashish Rai";
String id = "sdfvwasdfafsvrjt";
String postTime = "12/12/2012 at 12:12";
String? dp =
    "https://images.thequint.com/thequint%2F2019-09%2Fa7a64147-4af2-4245-9b42-fcf312397bd3%2Ff36ca4b4a82cfa077ef8cd57bf8c4630.jpg";

int pageViewNumber = 0;
