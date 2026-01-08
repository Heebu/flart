import '../../../flartdart.dart';

/// A multi-line FDText input widget
class TextArea extends Widget {
  final TextEditingController? controller;
  final String? placeholder;
  final String? label;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final int rows;
  final int? maxLength;
  final bool enabled;
  final bool readOnly;
  final EdgeInsets? padding;
  final FlartColor? backgroundColor;
  final FlartColor? borderColor;
  final double? borderRadius;
  final String? errorText;
  final String? helperText;
  final Map<String, String>? cssStyle;

  TextArea({
    this.controller,
    this.placeholder,
    this.label,
    this.initialValue,
    this.onChanged,
    this.rows = 4,
    this.maxLength,
    this.enabled = true,
    this.readOnly = false,
    this.padding,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.errorText,
    this.helperText,
    this.cssStyle,
  });

  @override
  String render(BuildContext context) {
    final id = 'textarea_${DateTime.now().microsecondsSinceEpoch}';
    final value = controller?.text ?? initialValue ?? '';
    final bgColor = backgroundColor?.toString() ?? '#ffffff';
    final border = borderColor?.toString() ?? '#cccccc';
    final radius = borderRadius ?? 4.0;
    final pad = padding ?? EdgeInsets.all(12);
    final hasError = errorText != null;

    return '''
      <div style="display: flex; flex-direction: column; gap: 4px;">
        ${label != null ? '<label for="$id" style="font-size: 14px; font-weight: 500; color: #333;">${label!}</label>' : ''}
        
        <textarea
          id="$id"
          rows="$rows"
          placeholder="${placeholder ?? ''}"
          ${!enabled ? 'disabled' : ''}
          ${readOnly ? 'readonly' : ''}
          ${maxLength != null ? 'maxlength="$maxLength"' : ''}
          style="
            width: 100%;
            padding: ${pad.toCss()};
            background-color: $bgColor;
            border: 1px solid ${hasError ? '#dc3545' : border};
            border-radius: ${radius}px;
            font-size: 14px;
            font-family: inherit;
            outline: none;
            resize: vertical;
            transition: border-color 0.2s;
            ${!enabled ? 'opacity: 0.6; cursor: not-allowed;' : ''}
            ${readOnly ? 'background-color: #f5f5f5;' : ''}
            ${cssStyle?.entries.map((e) => '${e.key}: ${e.value};').join(' ') ?? ''}
          "
        >$value</textarea>
        
        ${errorText != null ? '<span style="font-size: 12px; color: #dc3545;">$errorText</span>' : ''}
        ${helperText != null && errorText == null ? '<span style="font-size: 12px; color: #666;">$helperText</span>' : ''}
        ${maxLength != null ? '<span style="font-size: 12px; color: #999; text-align: right;">${value.length}/$maxLength</span>' : ''}
      </div>
      
      <style>
        #$id:focus {
          border-color: ${hasError ? '#dc3545' : '#007bff'} !important;
          box-shadow: 0 0 0 3px ${hasError ? 'rgba(220, 53, 69, 0.1)' : 'rgba(0, 123, 255, 0.1)'};
        }
      </style>
      
      <script>
        (function() {
          const textarea = document.getElementById('$id');
          ${onChanged != null ? '''
            textarea.addEventListener('input', function(e) {
              console.log('TextArea changed:', e.target.value);
            });
          ''' : ''}
        })();
      </script>
    ''';
  }
}

/// An autocomplete/search input widget
class AutocompleteField extends Widget {
  final String? placeholder;
  final String? label;
  final List<String> suggestions;
  final ValueChanged<String>? onSelected;
  final ValueChanged<String>? onChanged;
  final Widget? prefixIcon;
  final Map<String, String>? cssStyle;

  AutocompleteField({
    this.placeholder,
    this.label,
    required this.suggestions,
    this.onSelected,
    this.onChanged,
    this.prefixIcon,
    this.cssStyle,
  });

  @override
  String render(BuildContext context) {
    final id = 'autocomplete_${DateTime.now().microsecondsSinceEpoch}';
    final listId = '${id}_list';

    return '''
      <div style="display: flex; flex-direction: column; gap: 4px; position: relative;">
        ${label != null ? '<label for="$id" style="font-size: 14px; font-weight: 500; color: #333;">${label!}</label>' : ''}
        
        <div style="position: relative;">
          ${prefixIcon != null ? '<div style="position: absolute; left: 8px; top: 50%; transform: translateY(-50%); display: flex; align-items: center;">${prefixIcon!.render(context)}</div>' : ''}
          
          <input
            type="text"
            id="$id"
            list="$listId"
            placeholder="${placeholder ?? ''}"
            style="
              width: 100%;
              padding: 8px 12px;
              ${prefixIcon != null ? 'padding-left: 40px;' : ''}
              background-color: #ffffff;
              border: 1px solid #cccccc;
              border-radius: 4px;
              font-size: 14px;
              outline: none;
              ${cssStyle?.entries.map((e) => '${e.key}: ${e.value};').join(' ') ?? ''}
            "
          />
          
          <datalist id="$listId">
            ${suggestions.map((s) => '<option value="$s">').join()}
          </datalist>
        </div>
      </div>
      
      <style>
        #$id:focus {
          border-color: #007bff !important;
          box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.1);
        }
      </style>
      
      <script>
        (function() {
          const input = document.getElementById('$id');
          ${onChanged != null ? '''
            input.addEventListener('input', function(e) {
              console.log('Autocomplete changed:', e.target.value);
            });
          ''' : ''}
          ${onSelected != null ? '''
            input.addEventListener('change', function(e) {
              console.log('Autocomplete selected:', e.target.value);
            });
          ''' : ''}
        })();
      </script>
    ''';
  }
}

/// A color picker input
class ColorPicker extends Widget {
  final FlartColor? initialColor;
  final ValueChanged<FlartColor>? onChanged;
  final String? label;

  ColorPicker({
    this.initialColor,
    this.onChanged,
    this.label,
  });

  @override
  String render(BuildContext context) {
    final id = 'colorpicker_${DateTime.now().microsecondsSinceEpoch}';
    final color = initialColor?.toString() ?? '#000000';

    return '''
      <div style="display: flex; flex-direction: column; gap: 4px;">
        ${label != null ? '<label for="$id" style="font-size: 14px; font-weight: 500; color: #333;">${label!}</label>' : ''}
        
        <input
          type="color"
          id="$id"
          value="$color"
          style="
            width: 60px;
            height: 40px;
            border: 1px solid #cccccc;
            border-radius: 4px;
            cursor: pointer;
          "
        />
      </div>
      
      <script>
        (function() {
          const input = document.getElementById('$id');
          ${onChanged != null ? '''
            input.addEventListener('change', function(e) {
              console.log('Color changed:', e.target.value);
            });
          ''' : ''}
        })();
      </script>
    ''';
  }
}

/// A file upload input
class FileUpload extends Widget {
  final String? label;
  final bool multiple;
  final String? accept;
  final ValueChanged<List<String>>? onChanged;
  final String buttonText;

  FileUpload({
    this.label,
    this.multiple = false,
    this.accept,
    this.onChanged,
    this.buttonText = 'Choose File',
  });

  @override
  String render(BuildContext context) {
    final id = 'fileupload_${DateTime.now().microsecondsSinceEpoch}';

    return '''
      <div style="display: flex; flex-direction: column; gap: 4px;">
        ${label != null ? '<label style="font-size: 14px; font-weight: 500; color: #333;">${label!}</label>' : ''}
        
        <div>
          <input
            type="file"
            id="$id"
            ${multiple ? 'multiple' : ''}
            ${accept != null ? 'accept="$accept"' : ''}
            style="display: none;"
          />
          <button
            type="button"
            onclick="document.getElementById('$id').click()"
            style="
              padding: 8px 16px;
              background-color: #007bff;
              color: white;
              border: none;
              border-radius: 4px;
              cursor: pointer;
              font-size: 14px;
            "
          >$buttonText</button>
          <span id="${id}_filename" style="margin-left: 12px; font-size: 14px; color: #666;"></span>
        </div>
      </div>
      
      <script>
        (function() {
          const input = document.getElementById('$id');
          const filename = document.getElementById('${id}_filename');
          
          input.addEventListener('change', function(e) {
            const files = Array.from(e.target.files).map(f => f.name);
            filename.textContent = files.join(', ');
            console.log('Files selected:', files);
          });
        })();
      </script>
    ''';
  }
}
