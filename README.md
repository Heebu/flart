### 🧱 `README.md`

````markdown
# Flart Project

A Flutter-style widget framework built for the **Dart Web** environment.  
This project aims to bring Flutter-like declarative UI development to the browser —  
using only Dart and HTML under the hood.

---

## 🚀 Getting Started

### 1. Install Dart SDK
Download and install the latest stable **Dart SDK** from:
👉 https://dart.dev/get-dart

After installation, verify it’s available globally:
```bash
dart --version
````

If the above command doesn’t work, add Dart to your system PATH manually:

```
C:\Users\<YOUR_USERNAME>\AppData\Local\Pub\Cache\bin
```

Or re-run this command in PowerShell:

```powershell
setx PATH "$env:PATH;C:\Users\<YOUR_USERNAME>\AppData\Local\Pub\Cache\bin"
```

---

## 🧩 Dependencies

Your `pubspec.yaml` should look like this:

```yaml
name: flart_project
description: A Flutter-style widget package for Dart Web
version: 0.0.1

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  html: any

dev_dependencies:
  build_runner: any
  build_web_compilers: any
```

Then install dependencies:

```bash
dart pub get
```

---

## 🧰 Run the Project

To build and serve your Dart web app locally, use:

```bash
webdev serve
```

The app will be available at:
👉 [http://localhost:8080](http://localhost:8080)

You can specify a custom port if needed:

```bash
webdev serve web:9000
```

---

## 🛠️ Troubleshooting

### `'dart' is not recognized`

Dart SDK is not in your PATH. Reinstall or re-add it manually using:

```powershell
setx PATH "$env:PATH;C:\Users\<YOUR_USERNAME>\AppData\Local\Pub\Cache\bin"
```

### `'webdev' is not recognized`

Run the following:

```bash
dart pub global activate webdev
```

Then restart your terminal and verify:

```bash
webdev --version
```

---

## 🧠 Notes

* Uses `build_runner` and `build_web_compilers` for Dart-to-JS compilation.
* Designed for experimentation and framework development (e.g., `Flart` UI library).
* Future goal: to mimic Flutter’s widget and rendering structure for pure Dart Web apps.

---

## 📜 License

MIT © 2025 Idris Adedeji

```

---

Would you like me to make this version **auto-detect the platform** (Windows/macOS/Linux) in the setup section — so it’s smarter and reusable across systems?
```
