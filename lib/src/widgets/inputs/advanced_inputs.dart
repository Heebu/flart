import 'package:web/web.dart' as web;
import '../../../flartdart.dart';

/// A multi-line FDText input widget
class TextArea extends StatefulWidget {
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
  final String? rawCss;

  const TextArea({
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
    this.rawCss,
    super.key,
  });

  @override
  State<TextArea> createState() => _TextAreaState();
}

class _TextAreaState extends State<TextArea> {
  late String _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.controller?.text ?? widget.initialValue ?? '';
    widget.controller?.addListener(_handleControllerChange);
  }

  void _handleControllerChange() {
    if (widget.controller != null && widget.controller!.text != _currentValue) {
      setState(() {
        _currentValue = widget.controller!.text;
      });
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = widget.backgroundColor?.toString() ?? '#ffffff';
    final border = widget.borderColor?.toString() ?? '#cccccc';
    final radius = widget.borderRadius ?? 4.0;
    final pad = widget.padding ?? const EdgeInsets.all(12);
    final hasError = widget.errorText != null;

    final styles = <String, String>{
      'width': '100%',
      'padding': pad.toCss(),
      'background-color': widget.readOnly ? '#f5f5f5' : bgColor,
      'border': '1px solid ${hasError ? '#dc3545' : border}',
      'border-radius': '${radius}px',
      'font-size': '14px',
      'font-family': 'inherit',
      'outline': 'none',
      'resize': 'vertical',
      'box-sizing': 'border-box',
      if (!widget.enabled) ...{
        'opacity': '0.6',
        'cursor': 'not-allowed',
      },
      ...?widget.cssStyle,
    };

    if (widget.rawCss != null && widget.rawCss!.isNotEmpty) {
      final pairs = widget.rawCss!.split(';');
      for (var pair in pairs) {
        if (pair.trim().isEmpty) continue;
        final parts = pair.split(':');
        if (parts.length >= 2) {
          styles[parts[0].trim()] = parts.sublist(1).join(':').trim();
        }
      }
    }

    final children = <FlartNode>[
      if (widget.label != null)
        FlartElementNode(
          'label',
          styles: {
            'font-size': '14px',
            'font-weight': '500',
            'color': '#333',
          },
          children: [FlartTextNode(widget.label!)],
        ),
      FlartElementNode(
        'textarea',
        attributes: {
          'rows': widget.rows.toString(),
          if (widget.placeholder != null) 'placeholder': widget.placeholder!,
          if (!widget.enabled) 'disabled': 'true',
          if (widget.readOnly) 'readonly': 'true',
          if (widget.maxLength != null) 'maxlength': widget.maxLength.toString(),
        },
        styles: styles,
        events: {
          'input': (web.Event e) {
            final target = e.target as web.HTMLTextAreaElement?;
            if (target != null) {
              _currentValue = target.value;
              if (widget.controller != null && widget.controller!.text != target.value) {
                widget.controller!.text = target.value;
              }
              widget.onChanged?.call(target.value);
            }
          },
        },
        children: [FlartTextNode(_currentValue)],
      ),
      if (widget.errorText != null)
        FlartElementNode(
          'span',
          styles: {'font-size': '12px', 'color': '#dc3545'},
          children: [FlartTextNode(widget.errorText!)],
        ),
      if (widget.helperText != null && widget.errorText == null)
        FlartElementNode(
          'span',
          styles: {'font-size': '12px', 'color': '#666'},
          children: [FlartTextNode(widget.helperText!)],
        ),
      if (widget.maxLength != null)
        FlartElementNode(
          'span',
          styles: {
            'font-size': '12px',
            'color': '#999',
            'text-align': 'right',
          },
          children: [FlartTextNode('${_currentValue.length}/${widget.maxLength}')],
        ),
    ];

    return _RawFlartNodeWidget(
      FlartElementNode(
        'div',
        id: widget.key?.toString(),
        styles: {
          'display': 'flex',
          'flex-direction': 'column',
          'gap': '4px',
        },
        children: children,
      ),
    );
  }
}

class _RawFlartNodeWidget extends Widget {
  final FlartNode node;
  const _RawFlartNodeWidget(this.node);

  @override
  FlartNode buildNode(BuildContext context) => node;
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
  final String? rawCss;

  const AutocompleteField({
    this.placeholder,
    this.label,
    required this.suggestions,
    this.onSelected,
    this.onChanged,
    this.prefixIcon,
    this.cssStyle,
    this.rawCss,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final listId = 'autocomplete_list_${key?.toString() ?? hashCode}';

    final styles = <String, String>{
      'width': '100%',
      'padding': '8px 12px',
      if (prefixIcon != null) 'padding-left': '40px',
      'background-color': '#ffffff',
      'border': '1px solid #cccccc',
      'border-radius': '4px',
      'font-size': '14px',
      'outline': 'none',
      'box-sizing': 'border-box',
      ...?cssStyle,
    };

    if (rawCss != null && rawCss!.isNotEmpty) {
      final pairs = rawCss!.split(';');
      for (var pair in pairs) {
        if (pair.trim().isEmpty) continue;
        final parts = pair.split(':');
        if (parts.length >= 2) {
          styles[parts[0].trim()] = parts.sublist(1).join(':').trim();
        }
      }
    }

    final inputChildren = <FlartNode>[
      if (prefixIcon != null)
        FlartElementNode(
          'div',
          styles: {
            'position': 'absolute',
            'left': '8px',
            'top': '50%',
            'transform': 'translateY(-50%)',
            'display': 'flex',
            'align-items': 'center',
          },
          children: [prefixIcon!.buildNode(context)],
        ),
      FlartElementNode(
        'input',
        attributes: {
          'type': 'text',
          'list': listId,
          if (placeholder != null) 'placeholder': placeholder!,
        },
        styles: styles,
        events: {
          'input': (web.Event e) {
            final target = e.target as web.HTMLInputElement?;
            if (target != null) {
              onChanged?.call(target.value);
            }
          },
          'change': (web.Event e) {
            final target = e.target as web.HTMLInputElement?;
            if (target != null) {
              onSelected?.call(target.value);
            }
          },
        },
      ),
      FlartElementNode(
        'datalist',
        id: listId,
        children: suggestions.map((s) => FlartElementNode('option', attributes: {'value': s})).toList(),
      ),
    ];

    final children = <FlartNode>[
      if (label != null)
        FlartElementNode(
          'label',
          styles: {
            'font-size': '14px',
            'font-weight': '500',
            'color': '#333',
          },
          children: [FlartTextNode(label!)],
        ),
      FlartElementNode(
        'div',
        styles: {'position': 'relative'},
        children: inputChildren,
      ),
    ];

    return FlartElementNode(
      'div',
      id: key?.toString(),
      styles: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '4px',
        'position': 'relative',
      },
      children: children,
    );
  }
}

/// A color picker input
class ColorPicker extends Widget {
  final FlartColor? initialColor;
  final ValueChanged<FlartColor>? onChanged;
  final String? label;
  final String? rawCss;

  const ColorPicker({
    this.initialColor,
    this.onChanged,
    this.label,
    this.rawCss,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final colorHex = initialColor?.toString() ?? '#000000';

    final styles = <String, String>{
      'width': '60px',
      'height': '40px',
      'border': '1px solid #cccccc',
      'border-radius': '4px',
      'cursor': 'pointer',
    };

    if (rawCss != null && rawCss!.isNotEmpty) {
      final pairs = rawCss!.split(';');
      for (var pair in pairs) {
        if (pair.trim().isEmpty) continue;
        final parts = pair.split(':');
        if (parts.length >= 2) {
          styles[parts[0].trim()] = parts.sublist(1).join(':').trim();
        }
      }
    }

    final children = <FlartNode>[
      if (label != null)
        FlartElementNode(
          'label',
          styles: {
            'font-size': '14px',
            'font-weight': '500',
            'color': '#333',
          },
          children: [FlartTextNode(label!)],
        ),
      FlartElementNode(
        'input',
        attributes: {
          'type': 'color',
          'value': colorHex,
        },
        styles: styles,
        events: {
          'input': (web.Event e) {
            final target = e.target as web.HTMLInputElement?;
            if (target != null && target.value.isNotEmpty) {
              onChanged?.call(FlartColor.fromHex(target.value));
            }
          },
        },
      ),
    ];

    return FlartElementNode(
      'div',
      id: key?.toString(),
      styles: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '4px',
      },
      children: children,
    );
  }
}

/// A file upload input
class FileUpload extends StatefulWidget {
  final String? label;
  final bool multiple;
  final String? accept;
  final ValueChanged<List<String>>? onChanged;
  final String buttonText;
  final String? rawCss;

  const FileUpload({
    this.label,
    this.multiple = false,
    this.accept,
    this.onChanged,
    this.buttonText = 'Choose File',
    this.rawCss,
    super.key,
  });

  @override
  State<FileUpload> createState() => _FileUploadState();
}

class _FileUploadState extends State<FileUpload> {
  String _selectedNames = '';

  @override
  Widget build(BuildContext context) {
    final inputId = 'fileupload_${widget.key?.toString() ?? hashCode}';

    final children = <FlartNode>[
      if (widget.label != null)
        FlartElementNode(
          'label',
          styles: {
            'font-size': '14px',
            'font-weight': '500',
            'color': '#333',
          },
          children: [FlartTextNode(widget.label!)],
        ),
      FlartElementNode(
        'div',
        styles: {
          'display': 'flex',
          'align-items': 'center',
          'gap': '12px',
        },
        children: [
          FlartElementNode(
            'input',
            id: inputId,
            attributes: {
              'type': 'file',
              if (widget.multiple) 'multiple': 'true',
              if (widget.accept != null) 'accept': widget.accept!,
            },
            styles: {'display': 'none'},
            events: {
              'change': (e) {
                final target = e.target as web.HTMLInputElement?;
                if (target != null && target.files != null) {
                  final files = target.files!;
                  final names = <String>[];
                  for (var i = 0; i < files.length; i++) {
                    final f = files.item(i);
                    if (f != null) names.add(f.name);
                  }
                  setState(() {
                    _selectedNames = names.join(', ');
                  });
                  widget.onChanged?.call(names);
                }
              },
            },
          ),
          FlartElementNode(
            'button',
            attributes: {'type': 'button'},
            styles: {
              'padding': '8px 16px',
              'background-color': '#007bff',
              'color': 'white',
              'border': 'none',
              'border-radius': '4px',
              'cursor': 'pointer',
              'font-size': '14px',
            },
            events: {
              'click': (e) {
                final fileInput = web.document.getElementById(inputId) as web.HTMLInputElement?;
                fileInput?.click();
              },
            },
            children: [FlartTextNode(widget.buttonText)],
          ),
          if (_selectedNames.isNotEmpty)
            FlartElementNode(
              'span',
              styles: {'font-size': '14px', 'color': '#666'},
              children: [FlartTextNode(_selectedNames)],
            ),
        ],
      ),
    ];

    return _RawFlartNodeWidget(
      FlartElementNode(
        'div',
        id: widget.key?.toString(),
        styles: {
          'display': 'flex',
          'flex-direction': 'column',
          'gap': '4px',
        },
        children: children,
      ),
    );
  }
}
