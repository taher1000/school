import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../../injection_container.dart';
import 'injectable.config.dart';

@InjectableInit(
  initializerName: r'$inject',
  preferRelativeImports: true,
  asExtension: false,
)
Future<GetIt> inject({String? environment}) async =>
    $inject(getIt, environment: environment);

const kInjectableDev = Environment('dev');
const kInjectableTest = Environment('test');
const kInjectableProd = Environment('prod');
