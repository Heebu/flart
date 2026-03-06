# Publishing Checklist for Flart 🚀

This guide ensures that your release to [pub.dev](https://pub.dev) is smooth, professional, and high-scoring.

## ✅ Pre-Publication Requirements

### 1. Versioning & Changelog
- [ ] Update version in `pubspec.yaml` (follow Semantic Versioning).
- [ ] Add a descriptive section to `CHANGELOG.md` for the new version.

### 2. Code Quality
- [ ] Run formatter: `dart format .`
- [ ] Run analyzer: `flartdart analyze` (ensure 0 errors/warnings).
- [ ] Run tests: `flartdart test` (ensure 100% pass rate).

### 3. CLI Verification
- [ ] Ensure the `executables` section in `pubspec.yaml` is correct:
  ```yaml
  executables:
    flartdart: flartdart
  ```
- [ ] Test CLI locally: `flartdart doctor` and `flartdart create test_proj`

### 4. Documentation
- [ ] Update `README.md` with new features or API changes.
- [ ] Update `WIDGET_GUIDE.md` with any new widgets added.
- [ ] Ensure all public methods/classes in `lib/` have doc comments (`///`).

### 5. Example Project
- [ ] Verify the `example/` project builds and runs without errors.
- [ ] Test production build: `flartdart build --release` in the example directory.

---

## 📦 Publishing Process

### Step 1: Dry Run
Always perform a dry run to catch any potential issues (e.g., missing files, too large package size).
```bash
dart pub publish --dry-run
```

### Step 2: Verification
Check the output of the dry run. Ensure that:
- No non-essential files are being uploaded (check `.pubignore` or `.gitignore`).
- The description and tags are correct.

### Step 3: Publish
Once ready, run the actual publish command:
```bash
dart pub publish
```

---

## 🎯 Post-Publication Tasks

### 1. GitHub Tagging
Tag the release in your repository for future reference.
```bash
git tag v1.0.0
git push origin v1.0.0
```

### 2. Global Activation Test
Verify that users can install the CLI globally:
```bash
dart pub global activate flartdart
flartdart --help
```

### 3. Community Engagement
- Share the release on Twitter/X, LinkedIn, and Reddit (r/dartlang, r/FlutterDev).
- Update the "Latest Version" badge in README if it doesn't auto-update.

---

## 📈 Aiming for 140/140 Pub Points
To get a perfect score on pub.dev, ensure:
- **Platform Support**: Correctly identifying `web` support in `pubspec.yaml`.
- **Documentation**: Having a valid `README.md`, `CHANGELOG.md`, and `LICENSE`.
- **Dart Layout**: Following the standard package layout.
- **Dependencies**: keeping dependencies up to date.

---

**Happy Publishing!** 🎨
