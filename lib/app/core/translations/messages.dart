import 'package:get/get.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'hello': 'Hello World',
          'hello_name': 'Hello @name',
        },
        'de_DE': {
          'hello': 'Hallo Welt',
          'hello_name': 'Hallo @name',
        },
        'tr_TR': {
          'hello': 'Merhaba Dünya',
          'hello_name': 'Merhaba @name',
        },
      };
}
