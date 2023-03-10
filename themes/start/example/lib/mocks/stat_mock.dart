import 'configs.dart';
import 'data/data.dart';

Future getStatApi() async {
  await Future.delayed(timeDelay);
  return starData;
}
