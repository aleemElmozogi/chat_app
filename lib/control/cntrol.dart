// import '../constent/cons.dart';
//
// void addUserName({fireStore, email, userName}) {
//   int newId = 0;
//   newId = fireStore.collection('users').snapshots().length as int;
//   print(newId);
// }
//
// Future<int> getIdByEmail(fireStore, email) async {
//   int id = 1;
//   await for (var snapshot in fireStore.collection('users').snapshots()) {
//     for (var message in snapshot.docs) {
//       // print('line60 ${message.data()}');
//       if (message.data()['email'] == email) {
//         id = message.data()['id'];
//       }
//     }
//   }
//   return id;
// }
//
// void getNameByEmail(fireStore, email) async {
//   String name = email;
//   await for (var snapshot in fireStore.collection('users').snapshots()) {
//     for (var message in snapshot.docs) {
//       if (message.data()['email'] == email) {
//         // return message.data()['userName'];
//         print('line60 ${message.data()['userName']}');
//         kUserName = message.data()['userName'];
//       }
//     }
//   }
//   // return name;
// }
// List letters = [
//   'a',
//   'b',
//   'c',
//   'd',
//   'e',
//   'f',
//   'g',
//   'h',
//   'i',
//   'j',
//   'k',
//   'l',
//   'n',
//   'm',
//   'o',
//   'p',
//   'q',
//   'r',
//   's',
//   't',
//   'u',
//   'v',
//   'w',
//   'x',
//   'y',
//   'z',
// ];

// String encrypt(String message, int id) {
//   String newDMessage = '';
//
//   for (int x = 0; x < message.length; x++) {
//     newDMessage =
//         newDMessage + letters[(letters.indexOf(message[x]) + id % 26)];
//   }
//   return newDMessage;
// }
//
// String deCrypt(String message, int id) {
//   String newDMessage = '';
//
//   for (int x = 0; x < message.length; x++) {
//     newDMessage =
//         newDMessage + letters[(letters.indexOf(message[x]) - id % 26)];
//   }
//   return newDMessage;
// }
