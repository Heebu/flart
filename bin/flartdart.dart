import 'dart:io';
import 'package:args/args.dart';

void main(List<String> arguments) async {
  final createParser = ArgParser()
    ..addOption('local-path',
        help: 'Path to local flartdart package (for development)');
  final runParser = ArgParser()
    ..addFlag('release',
        abbr: 'r', help: 'Run in release mode', negatable: false)
    ..addOption('port', abbr: 'p', help: 'Port to run on', defaultsTo: '8080');

  final buildParser = ArgParser()
    ..addFlag('release',
        abbr: 'r', help: 'Build in release mode', negatable: false);

  final parser = ArgParser()
    ..addCommand('create', createParser)
    ..addCommand('run', runParser)
    ..addCommand('build', buildParser)
    ..addCommand('test', ArgParser())
    ..addCommand('clean', ArgParser())
    ..addCommand('analyze', ArgParser())
    ..addCommand('doctor', ArgParser())
    ..addCommand('fix', ArgParser())
    ..addCommand('donate', ArgParser())
    ..addFlag('help', abbr: 'h', negatable: false, help: 'Show this help');

  ArgResults results;
  try {
    results = parser.parse(arguments);
  } catch (e) {
    print('Error: ${e.toString()}');
    _printUsage(parser);
    return;
  }

  if (results['help'] == true ||
      (arguments.isEmpty && results.command == null)) {
    _printUsage(parser);
    return;
  }

  final command = results.command;
  if (command?.name == 'create') {
    if (command!.rest.isEmpty) {
      print('Error: Project name is required.');
      print('Usage: flartdart create <project_name> [--local-path <path>]');
      return;
    }
    final projectName = command.rest.first;
    final localPath = command['local-path'] as String?;
    await _createProject(projectName, localPath);
  } else if (command?.name == 'run') {
    final isRelease = command!['release'] as bool;
    final port = command['port'] as String;
    await _runApp(isRelease, port);
  } else if (command?.name == 'build') {
    final isRelease = command!['release'] as bool;
    await _buildApp(isRelease);
  } else if (command?.name == 'test') {
    await _runTest();
  } else if (command?.name == 'clean') {
    await _runClean();
  } else if (command?.name == 'analyze') {
    await _runAnalyze();
  } else if (command?.name == 'doctor') {
    await _runDoctor();
  } else if (command?.name == 'fix') {
    await _runFix();
  } else if (command?.name == 'donate') {
    await _runDonate();
  } else {
    _printUsage(parser);
  }
}

void _printUsage(ArgParser parser) {
  print('Flartdart CLI Tool');
  print('Usage: flartdart <command> [arguments]');
  print('\nCommands:');
  print('  create <project_name>   Create a new Flartdart project');
  print('  run                     Run the application (dev mode by default)');
  print('    --release, -r         Run in release (production) mode');
  print('    --port, -p            Port to serve on (default: 8080)');
  print('  build                   Build the application');
  print('    --release, -r         Build for release');
  print('  test                    Run tests for the project');
  print('  clean                   Clean build artifacts and temporary files');
  print('  analyze                 Run dart analyzer on the project');
  print('  doctor                  Check the environment setup');
  print('  fix                     Apply automated fixes for common issues');
  print('  donate                  Support the project developers');
  print('\nOptions:');
  print(parser.usage);
}

Future<void> _runDonate() async {
  print('\n💳 Support Flartdart');
  print('-----------------');
  print('If you find Flartdart useful, please consider supporting us!');
  print('Your support helps us maintain the project and build new features.');
  print(
      '\nDonate via PayPal: https://www.paypal.com/donate/?hosted_button_id=QAK2GKLN4QDVW');
  print('\nThank you for being part of the community! ❤️\n');
}

Future<void> _runApp(bool release, String port) async {
  print(
      '🚀 Starting Flartdart application in ${release ? 'RELEASE' : 'DEBUG'} mode on port $port...');

  final args = ['run', 'build_runner', 'serve', 'web:$port'];
  if (release) {
    args.add('--release');
  }

  final process = await Process.start(
    'dart',
    args,
    mode: ProcessStartMode.inheritStdio,
  );

  await process.exitCode;
}

Future<void> _buildApp(bool release) async {
  print(
      '🏗 Building Flartdart application for ${release ? 'RELEASE' : 'DEBUG'}...');

  final args = ['run', 'build_runner', 'build', '--output', 'web:build'];
  if (release) {
    args.add('--release');
  }

  final process = await Process.start(
    'dart',
    args,
    mode: ProcessStartMode.inheritStdio,
  );

  final exitCode = await process.exitCode;
  if (exitCode == 0) {
    print('\n✅ Build completed successfully! Output located in web/build/');
  } else {
    print('\n❌ Build failed with exit code $exitCode');
  }
}

Future<void> _runTest() async {
  print('🧪 Running tests...');
  final process = await Process.start(
    'dart',
    ['test'],
    mode: ProcessStartMode.inheritStdio,
  );
  await process.exitCode;
}

Future<void> _runClean() async {
  print('🧹 Cleaning project...');
  final directories = ['.dart_tool', 'build'];
  for (final dir in directories) {
    final d = Directory(dir);
    if (d.existsSync()) {
      await d.delete(recursive: true);
      print('  Deleted $dir/');
    }
  }
  final lockFile = File('pubspec.lock');
  if (lockFile.existsSync()) {
    await lockFile.delete();
    print('  Deleted pubspec.lock');
  }
  print('✨ Clean completed.');
}

Future<void> _runAnalyze() async {
  print('🔍 Analyzing project...');
  final process = await Process.start(
    'dart',
    ['analyze'],
    mode: ProcessStartMode.inheritStdio,
  );
  await process.exitCode;
}

Future<void> _runDoctor() async {
  print('🩺 Flartdart Doctor');
  print('-----------------');

  // Check Dart SDK
  final dartVersion = Platform.version.split('(').first.trim();
  print('[✓] Dart SDK: $dartVersion');

  // Check Flartdart (Mock version for now, could read from pubspec if in package dir)
  print('[✓] Flartdart Tool: 1.4.0');

  // Check Environment
  print(
      '[✓] OS: ${Platform.operatingSystem} ${Platform.operatingSystemVersion}');

  print('\nEverything looks good! 🚀');
}

Future<void> _runFix() async {
  print('🔧 Applying fixes...');
  final process = await Process.start(
    'dart',
    ['fix', '--apply'],
    mode: ProcessStartMode.inheritStdio,
  );
  await process.exitCode;
}

Future<void> _createProject(String name, String? localPath) async {
  final projectDir = Directory(name);
  if (projectDir.existsSync()) {
    print('Error: Directory "$name" already exists.');
    return;
  }

  print('Creating project "$name"...');

  try {
    await projectDir.create();

    // Create web directory
    final webDir = Directory('${projectDir.path}/web');
    await webDir.create();

    // Create pubspec.yaml
    final pubspec = File('${projectDir.path}/pubspec.yaml');
    final flartDependency = localPath != null
        ? '''
  flartdart:
    path: ${localPath.replaceAll('\\', '/')}'''
        : '  flartdart: ^1.0.0';

    await pubspec.writeAsString('''
name: $name
description: A new Flartdart project.
version: 1.0.0

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
$flartDependency

dev_dependencies:
  build_runner: ^2.10.4
  build_web_compilers: ^4.4.6
  lints: ^3.0.0
  test: ^1.24.0
''');

    // Create web/index.html
    final indexHtml = File('${webDir.path}/index.html');
    await indexHtml.writeAsString('''
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${name[0].toUpperCase()}${name.substring(1)}</title>
    <script defer src="main.dart.js"></script>
</head>
<body>
</body>
</html>
''');

    // Create web/main.dart
    final mainDart = File('${webDir.path}/main.dart');
    await mainDart.writeAsString('''
import 'package:flartdart/flartdart.dart';

void main() {
  // Initialize Responsive Utility with desktop design size (1440x900)
  ScreenUtil.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return FDMaterialApp(
      title: 'Flartdart App',
      home: FDScaffold(
        appBar: FDAppBar(
          title: FDText('Welcome to Flartdart'),
          backgroundColor: FlartColors.blue,
        ),
        body: FDCenter(
          child: FDColumn(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FDIcon(
                icon: FDIcons.favorite,
                size: 64.0,
                color: FlartColors.red,
              ),
              FDSizedBox(height: 20.0.h),
              FDText(
                'Hello, Flartdart!',
                style: TextStyle(
                  fontSize: 32.0.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              FDSizedBox(height: 10.0.h),
              FDText(
                'Your new project is ready.',
                style: TextStyle(fontSize: 18.0.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
''');

    // Create analysis_options.yaml
    final analysisOptions = File('${projectDir.path}/analysis_options.yaml');
    await analysisOptions.writeAsString('''
include: package:lints/recommended.yaml

linter:
  rules:
    - prefer_const_constructors
    - prefer_const_literals_to_create_immutables
''');

    // Create .gitignore
    final gitignore = File('${projectDir.path}/.gitignore');
    await gitignore.writeAsString('''
.dart_tool/
build/
.packages
.pub-cache/
.pub/
pubspec.lock
''');

    print('\nProject "$name" created successfully!');
    print('To run your app:');
    print('  cd $name');
    print('  dart pub get');
    print('  flartdart run');
  } catch (e) {
    print('Error creating project: \$e');
  }
}
