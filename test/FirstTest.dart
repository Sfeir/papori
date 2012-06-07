#library('tests');

#import('../../../dart-editor/dart-sdk/lib/unittest/unittest.dart');
#import('./Runnable.dart');

class FirstTest implements Runnable {
  run() {
    test('this is the first test', () {
      int x = 2 + 3;
      expect(x, equals(5));
    });
  }
}
