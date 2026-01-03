import 'dart:html' as html;
import '../../../flartdart.dart';
import '../../helper/file_picker_manager.dart';

typedef ImagePickCallback = void Function(List<html.File> files);

class ImagePicker extends Widget {
  final bool multiple;
  final ImagePickCallback onImageSelected;
  final Map<String, String>? cssStyle;
  final String buttonLabel;

  ImagePicker({
    required this.onImageSelected,
    this.multiple = false,
    this.cssStyle,
    this.buttonLabel = 'Pick Image',
  });

  @override
  String render(BuildContext context) {
    final id = FlartFilePickerManager.register(onImageSelected);
    final styleString =
        (cssStyle ?? {}).entries.map((e) => '${e.key}: ${e.value};').join(' ');

    return '''
      <div>
        <input type="file" id="$id" accept="image/*" style="display:none;" ${multiple ? 'multiple' : ''} />
        <button style="$styleString" onclick="document.getElementById('$id').click()">
          $buttonLabel
        </button>
        <script>
          document.getElementById('$id').addEventListener('change', function(e) {
            window.__flartHandleFilePick('$id');
          });
        </script>
      </div>
    ''';
  }
}


//ImagePicker(
//   multiple: false,
//   buttonLabel: "Upload Profile Pic",
//   cssStyle: {
//     'padding': '10px 20px',
//     'background': '#4caf50',
//     'color': '#fff',
//     'border-radius': '4px',
//     'border': 'none',
//     'cursor': 'pointer',
//   },
//   onImageSelected: (files) {
//     print("User picked: ${files.first.name}");
//     // You can generate a Blob URL or base64 if needed
//   },
// )