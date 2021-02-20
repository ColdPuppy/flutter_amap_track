/// @author DoggieX
/// @create 2021/2/19 10:14
/// @mail coldpuppy@163.com

class AccuracyMode {
  static String createAccuracyMode(int startPos, int endPos) {
    if (startPos <= 0 && endPos <= 0) {
      return '';
    }
    return '${startPos > 0 ? startPos : ''}-${endPos >= startPos ? endPos : ''}';
  }
}
