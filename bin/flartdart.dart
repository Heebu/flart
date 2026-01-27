import 'dart:io';
import 'package:args/args.dart';

void main(List<String> arguments) async {
  final createParser = ArgParser()
    ..addOption('local-path',
        help: 'Path to local flartdart package (for development)');
  final parser = ArgParser()
    ..addCommand('create', createParser)
    ..addFlag('help', abbr: 'h', negatable: false, help: 'Show this help');

  ArgResults results;
  try {
    results = parser.parse(arguments);
  } catch (e) {
    print('Error: ${e.toString()}');
    _printUsage(parser);
    return;
  }

  if (results['help'] == true || arguments.isEmpty) {
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
  } else {
    _printUsage(parser);
  }
}

void _printUsage(ArgParser parser) {
  print('Flartdart CLI Tool');
  print('Usage: flartdart <command> [arguments]');
  print('\nCommands:');
  print('  create <project_name>   Create a new Flartdart project');
  print('\nOptions:');
  print(parser.usage);
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
    path: $localPath'''
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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return const FDMaterialApp(
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
              FDSizedBox(height: 20.0),
              FDText(
                'Hello, Flartdart!',
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              FDSizedBox(height: 10.0),
              FDText(
                'Your new project is ready.',
                style: TextStyle(fontSize: 18.0),
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

    print('\\nProject "$name" created successfully!');
    print('To run your app:');
    print('  cd $name');
    print('  dart pub get');
    print('  dart run build_runner serve');
  } catch (e) {
    print('Error creating project: \$e');
  }
}
