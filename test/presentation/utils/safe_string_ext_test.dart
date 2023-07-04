import 'package:flutter_test/flutter_test.dart';
import 'package:gift_of_the_nile/index.dart';

void main() {
  group("SafeStringExt", () {
    test("Returns the original string if it is not null", () {
      const str = "Hello";
      expect(str.safeStr, str);
    });

    test("Returns 'N/A' if the string is null", () {
      const String? str = null;
      expect(str.safeStr, "N/A");
    });
  });
}
