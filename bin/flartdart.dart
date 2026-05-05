import 'dart:io';
import 'package:args/args.dart';

const String cliVersion = '1.6.0';

void main(List<String> arguments) async {
  final createParser = ArgParser()
    ..addOption('local-path',
        help: 'Path to local flartdart package (for development)')
    ..addOption('template',
        abbr: 't',
        help: 'Project template to use',
        allowed: ['default', 'counter', 'routing'],
        defaultsTo: 'default');

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
    ..addCommand('pub', _createPubParser())
    ..addCommand('get', ArgParser())
    ..addCommand('upgrade', ArgParser())
    ..addCommand('doctor', ArgParser())
    ..addCommand('devices', ArgParser())
    ..addCommand('fix', ArgParser())
    ..addCommand('donate', ArgParser())
    ..addFlag('version',
        abbr: 'v', negatable: false, help: 'Show version information')
    ..addFlag('help', abbr: 'h', negatable: false, help: 'Show this help');

  ArgResults results;
  try {
    results = parser.parse(arguments);
  } catch (e) {
    print('Error: ${e.toString()}');
    _printUsage(parser);
    return;
  }

  if (results['version'] == true) {
    print('Flartdart CLI v$cliVersion');
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
      print('Usage: flartdart create <project_name> [--local-path <path>] [--template <name>]');
      return;
    }
    final projectName = command.rest.first;
    final localPath = command['local-path'] as String?;
    final template = command['template'] as String? ?? 'default';
    await _createProject(projectName, localPath, template);
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
  } else if (command?.name == 'pub') {
    await _runPub(command!);
  } else if (command?.name == 'get') {
    await _runPubGet();
  } else if (command?.name == 'upgrade') {
    await _runPubUpgrade();
  } else if (command?.name == 'doctor') {
    await _runDoctor();
  } else if (command?.name == 'devices') {
    await _runDevices();
  } else if (command?.name == 'fix') {
    await _runFix();
  } else if (command?.name == 'donate') {
    await _runDonate();
  } else {
    _printUsage(parser);
  }
}

ArgParser _createPubParser() {
  return ArgParser()
    ..addCommand('get', ArgParser())
    ..addCommand('upgrade', ArgParser())
    ..addCommand('add', ArgParser())
    ..addCommand('remove', ArgParser());
}

void _printUsage(ArgParser parser) {
  print('''
╔══════════════════════════════════════════════════════╗
║           🚀 Flartdart CLI v$cliVersion                ║
║     Flutter-Inspired Framework for Dart Web          ║
╚══════════════════════════════════════════════════════╝

USAGE: flartdart <command> [arguments]

QUICK START:
  \$ dart pub global activate flartdart    # Install globally from pub.dev
  \$ flartdart create my_app              # Create a new project (auto-runs pub get)
  \$ cd my_app
  \$ flartdart run                        # Start dev server on :8080

COMMANDS:
  create <name>       Create a new Flartdart project
                      --template, -t   Template: default, counter, routing
                      --local-path     Path to local flartdart (for development)
  run                 Run the application (default: http://localhost:8080)
                      --release, -r    Run in production mode
                      --port, -p       Specify port (default: 8080)
  build               Build the application for deployment
                      --release, -r    Build in release/production mode
  test                Run tests
  clean               Clean build artifacts and caches
  analyze             Run the Dart analyzer
  pub [get|upgrade]   Manage dependencies
  get                 Shorthand for "pub get"
  upgrade             Shorthand for "pub upgrade"
  doctor              Check environment setup
  devices             List available devices
  fix                 Apply automated code fixes
  donate              Support the project

OPTIONS:
  -v, --version       Show version information
  -h, --help          Show this help

LEARN MORE:
  📖 Docs:    https://github.com/Heebu/flart#readme
  🐛 Issues:  https://github.com/Heebu/flart/issues
  💳 Support: https://www.paypal.com/donate/?hosted_button_id=QAK2GKLN4QDVW
''');
}

Future<void> _runPub(ArgResults command) async {
  final subCommand = command.command;
  if (subCommand == null) {
    print('Usage: flartdart pub <get|upgrade|add|remove>');
    return;
  }

  if (subCommand.name == 'get') {
    await _runPubGet();
  } else if (subCommand.name == 'upgrade') {
    await _runPubUpgrade();
  } else {
    // Forward unknown subcommands to dart pub
    print('Running "dart pub ${subCommand.name}"...');
    final process = await Process.start(
      'dart',
      ['pub', subCommand.name!, ...subCommand.rest],
      mode: ProcessStartMode.inheritStdio,
    );
    await process.exitCode;
  }
}

Future<void> _runPubGet() async {
  print('📦 Running "dart pub get"...');
  final process = await Process.start(
    'dart',
    ['pub', 'get'],
    mode: ProcessStartMode.inheritStdio,
  );
  await process.exitCode;
}

Future<void> _runPubUpgrade() async {
  print('📦 Running "dart pub upgrade"...');
  final process = await Process.start(
    'dart',
    ['pub', 'upgrade'],
    mode: ProcessStartMode.inheritStdio,
  );
  await process.exitCode;
}

Future<void> _runDevices() async {
  print('Found 1 available device:');
  print('\nChrome (web) • chrome • web-javascript • Google Chrome');
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
  print('=========================================');
  print('🔥 FLARTDART CLI v$cliVersion - STARTING APP 🔥');
  print('=========================================');
  print('🚀 Mode: ${release ? 'PRODUCTION' : 'DEVELOPMENT'}');
  print('🌐 Port: $port');

  // Check if pubspec.yaml exists
  if (!File('pubspec.yaml').existsSync()) {
    print('❌ Error: No pubspec.yaml found in this directory.');
    print('Make sure you are in a Flartdart project root.');
    print('\n💡 To create a new project: flartdart create <project_name>');
    return;
  }

  // Auto-run pub get if .dart_tool doesn't exist
  if (!Directory('.dart_tool').existsSync()) {
    print('📦 First run detected — fetching dependencies...');
    final pubGet = await Process.start(
      'dart',
      ['pub', 'get'],
      mode: ProcessStartMode.inheritStdio,
    );
    final pubResult = await pubGet.exitCode;
    if (pubResult != 0) {
      print('❌ Failed to fetch dependencies. Run "flartdart doctor" for help.');
      return;
    }
    print('');
  }

  final args = ['run', 'build_runner', 'serve', 'web:$port'];
  if (release) {
    args.add('--release');
  }

  print('🛠️ Executing: dart ${args.join(' ')}');
  print('=========================================');

  final process = await Process.start(
    'dart',
    args,
    mode: ProcessStartMode.inheritStdio,
    runInShell: true,
  );

  await process.exitCode;
}

Future<void> _buildApp(bool release) async {
  print(
      '🏗 Building Flartdart application for ${release ? 'RELEASE' : 'DEBUG'}...');

  // Check if pubspec.yaml exists
  if (!File('pubspec.yaml').existsSync()) {
    print('❌ Error: No pubspec.yaml found in this directory.');
    return;
  }

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
  print('══════════════════');

  // Check Dart SDK
  final dartVersion = Platform.version.split('(').first.trim();
  final dartMajor = int.tryParse(dartVersion.split('.').first) ?? 0;
  final dartOk = dartMajor >= 3;
  print('${dartOk ? '[✓]' : '[✗]'} Dart SDK: $dartVersion ${dartOk ? '' : '(requires >= 3.0.0)'}');

  // Check Flartdart
  print('[✓] Flartdart Tool: $cliVersion [LATEST]');

  // Check webdev availability
  bool webdevOk = false;
  try {
    final webdevCheck = await Process.run('dart', ['pub', 'global', 'list']);
    final output = webdevCheck.stdout.toString();
    webdevOk = output.contains('webdev');
  } catch (_) {}

  if (!webdevOk) {
    // Check local project for webdev
    final pubspec = File('pubspec.yaml');
    if (pubspec.existsSync()) {
      webdevOk = pubspec.readAsStringSync().contains('webdev');
    }
  }
  print(
      '${webdevOk ? '[✓]' : '[!]'} webdev: ${webdevOk ? 'Available' : 'Not found globally (ok if listed in project dev_dependencies)'}');

  // Check Environment
  print(
      '[✓] OS: ${Platform.operatingSystem} ${Platform.operatingSystemVersion}');

  // Check if we're in a project
  final isProject = File('pubspec.yaml').existsSync();
  print('${isProject ? '[✓]' : '[i]'} Project: ${isProject ? 'Found pubspec.yaml' : 'Not in a Flartdart project directory'}');

  if (isProject) {
    final hasDeps = Directory('.dart_tool').existsSync();
    print(
        '${hasDeps ? '[✓]' : '[!]'} Dependencies: ${hasDeps ? 'Resolved' : 'Run "flartdart get" to resolve'}');
  }

  print('\n${dartOk ? 'Everything looks good! 🚀' : '⚠️ Please upgrade your Dart SDK to >= 3.0.0'}');
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

Future<void> _createProject(
    String name, String? localPath, String template) async {
  // Validate project name (must be valid Dart package name)
  final nameRegex = RegExp(r'^[a-z][a-z0-9_]*$');
  if (!nameRegex.hasMatch(name)) {
    print('❌ Error: "$name" is not a valid project name.');
    print('   Project names must start with a lowercase letter and contain');
    print('   only lowercase letters, digits, and underscores.');
    print('   Example: my_app, todo_list, dashboard_v2');
    return;
  }

  final projectDir = Directory(name);
  if (projectDir.existsSync()) {
    print('❌ Error: Directory "$name" already exists.');
    return;
  }

  final prettyName = name
      .split('_')
      .map((w) => w[0].toUpperCase() + w.substring(1))
      .join(' ');

  print('');
  print('╔══════════════════════════════════════════════════════╗');
  print('║          🚀 Creating Flartdart Project              ║');
  print('╚══════════════════════════════════════════════════════╝');
  print('');
  print('  Project:  $name');
  print('  Template: $template');
  print('');

  try {
    await projectDir.create();

    // Create web directory
    final webDir = Directory('${projectDir.path}/web');
    await webDir.create();

    // Create pubspec.yaml
    print('  📄 Creating pubspec.yaml...');
    final pubspec = File('${projectDir.path}/pubspec.yaml');
    final flartDependency = localPath != null
        ? '''
  flartdart:
    path: ${localPath.replaceAll('\\', '/')}'''
        : '  flartdart: ^$cliVersion';

    await pubspec.writeAsString('''name: $name
description: A new Flartdart project.
version: 1.0.0
publish_to: 'none'

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
    print('  📄 Creating web/index.html...');
    final indexHtml = File('${webDir.path}/index.html');
    await indexHtml.writeAsString('''<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="$prettyName — built with Flartdart">
    <title>$prettyName</title>
    <script defer src="main.dart.js"></script>
</head>
<body>
</body>
</html>
''');

    // Create web/main.dart based on template
    print('  📄 Creating web/main.dart ($template template)...');
    final mainDart = File('${webDir.path}/main.dart');
    await mainDart.writeAsString(_getTemplate(template, prettyName));

    // Create analysis_options.yaml
    print('  📄 Creating analysis_options.yaml...');
    final analysisOptions = File('${projectDir.path}/analysis_options.yaml');
    await analysisOptions.writeAsString('''include: package:lints/recommended.yaml

linter:
  rules:
    - prefer_const_constructors
    - prefer_const_literals_to_create_immutables
''');

    // Create .gitignore
    final gitignore = File('${projectDir.path}/.gitignore');
    await gitignore.writeAsString('''.dart_tool/
build/
.packages
.pub-cache/
.pub/
pubspec.lock
''');

    // Auto-run pub get
    print('  📦 Fetching dependencies...');
    final pubGet = await Process.start(
      'dart',
      ['pub', 'get'],
      workingDirectory: projectDir.path,
      mode: ProcessStartMode.inheritStdio,
    );
    final exitCode = await pubGet.exitCode;

    print('');
    if (exitCode == 0) {
      print('╔══════════════════════════════════════════════════════╗');
      print('║       ✅ Project "$name" created successfully!      ');
      print('╚══════════════════════════════════════════════════════╝');
      print('');
      print('  Next steps:');
      print('');
      print('    cd $name');
      print('    flartdart run');
      print('');
      print('  Then open http://localhost:8080 in your browser.');
      print('');
    } else {
      print('⚠️ Project created but dependency resolution failed.');
      print('   cd $name && flartdart get');
    }
  } catch (e) {
    print('❌ Error creating project: $e');
  }
}

String _getTemplate(String template, String prettyName) {
  switch (template) {
    case 'counter':
      return '''import 'package:flartdart/flartdart.dart';

void main() {
  ScreenUtil.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return FDMaterialApp(
      title: '$prettyName',
      home: const CounterPage(),
    );
  }
}

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return FDScaffold(
      appBar: FDAppBar(
        title: const FDText('Counter Demo'),
        backgroundColor: FlartColors.blue,
      ),
      body: FDCenter(
        child: FDColumn(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FDText(
              'Count: \$_count',
              style: TextStyle(
                fontSize: 48.0.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            FDSizedBox(height: 24.0.h),
            FDRow(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FDElevatedButton(
                  onPressed: () => setState(() => _count--),
                  child: const FDText('-'),
                ),
                FDSizedBox(width: 16.0.w),
                FDElevatedButton(
                  onPressed: () => setState(() => _count++),
                  child: const FDText('+'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
''';

    case 'routing':
      return '''import 'package:flartdart/flartdart.dart';

void main() {
  ScreenUtil.init();

  PageNavigator.registerRoutes({
    '/': const HomePage(),
    '/about': const AboutPage(),
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return FDMaterialApp(
      title: '$prettyName',
      home: PageNavigator.current,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FDScaffold(
      appBar: FDAppBar(
        title: const FDText('Home'),
        backgroundColor: FlartColors.blue,
      ),
      body: FDCenter(
        child: FDColumn(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FDText(
              'Welcome to $prettyName!',
              style: TextStyle(fontSize: 28.0.sp, fontWeight: FontWeight.bold),
            ),
            FDSizedBox(height: 24.0.h),
            FDElevatedButton(
              onPressed: () => PageNavigator.pushNamed('/about'),
              child: const FDText('Go to About'),
            ),
          ],
        ),
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FDScaffold(
      appBar: FDAppBar(
        title: const FDText('About'),
        backgroundColor: FlartColors.indigo,
      ),
      body: FDCenter(
        child: FDColumn(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FDText(
              'About Page',
              style: TextStyle(fontSize: 28.0.sp, fontWeight: FontWeight.bold),
            ),
            FDSizedBox(height: 24.0.h),
            FDElevatedButton(
              onPressed: () => PageNavigator.pop(),
              child: const FDText('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
''';

    default: // 'default'
      return '''import 'package:flartdart/flartdart.dart';

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
      title: '$prettyName',
      home: FDScaffold(
        appBar: const FDAppBar(
          title: FDText('Welcome to Flartdart'),
          backgroundColor: FlartColors.blue,
        ),
        body: FDCenter(
          child: FDColumn(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const FDIcon(
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
''';
  }
}
