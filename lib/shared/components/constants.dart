import '../../screens/login/shop_login_screen.dart';
import '../network/local/local_prefs.dart';
import 'components.dart';

String token = '';

void signOut(context) {
  SharedPrefs.removeData(key: 'token').then((value) {
    if (value) {
      replacePage(context, ShopLoginScreen());
    }
  });
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}
