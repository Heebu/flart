import '../../../flartdart.dart';

class FDDataTable<T> extends Widget {
  final List<FDDataColumn> columns;
  final List<FDDataRow> rows;
  final double columnSpacing;
  final double dataRowHeight;
  final double headingRowHeight;
  final double horizontalMargin;
  final bool showCheckboxColumn;
  final Map<String, String>? cssStyle;
  final String? rawCss;

  const FDDataTable({
    required this.columns,
    required this.rows,
    this.columnSpacing = 24.0,
    this.dataRowHeight = 48.0,
    this.headingRowHeight = 56.0,
    this.horizontalMargin = 24.0,
    this.showCheckboxColumn = false,
    this.cssStyle,
    this.rawCss,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final theme = Theme.of(context);

    final containerStyles = <String, String>{
      'width': '100%',
      'overflow-x': 'auto',
      'background-color': theme.cardColor.toString(),
      'border-radius': '4px',
      'box-shadow': '0 1px 3px rgba(0,0,0,0.12)',
      ...?cssStyle,
    };

    if (rawCss != null && rawCss!.isNotEmpty) {
      final pairs = rawCss!.split(';');
      for (var pair in pairs) {
        if (pair.trim().isEmpty) continue;
        final parts = pair.split(':');
        if (parts.length >= 2) {
          containerStyles[parts[0].trim()] = parts.sublist(1).join(':').trim();
        }
      }
    }

    // Header cells
    final headerCells = <FlartNode>[];
    for (var i = 0; i < columns.length; i++) {
      final col = columns[i];
      final isFirst = i == 0;
      final isLast = i == columns.length - 1;

      headerCells.add(FlartElementNode(
        'th',
        attributes: {
          if (col.tooltip != null) 'title': col.tooltip!,
        },
        styles: {
          'padding': '0 ${columnSpacing / 2}px',
          if (isFirst) 'padding-left': '${horizontalMargin}px',
          if (isLast) 'padding-right': '${horizontalMargin}px',
          'color': theme.textStyle.color.toString(),
          'font-weight': '600',
          if (col.numeric) 'text-align': 'right' else 'text-align': 'left',
        },
        children: [col.label.buildNode(context)],
      ));
    }

    final theadNode = FlartElementNode(
      'thead',
      children: [
        FlartElementNode(
          'tr',
          styles: {
            'height': '${headingRowHeight}px',
            'border-bottom': '2px solid ${theme.dividerColor}',
          },
          children: headerCells,
        ),
      ],
    );

    // Body rows
    final bodyRows = <FlartNode>[];
    for (var row in rows) {
      final cells = <FlartNode>[];
      for (var i = 0; i < row.cells.length && i < columns.length; i++) {
        final cell = row.cells[i];
        final col = columns[i];
        final isFirst = i == 0;
        final isLast = i == row.cells.length - 1;

        cells.add(FlartElementNode(
          'td',
          styles: {
            'padding': '0 ${columnSpacing / 2}px',
            if (isFirst) 'padding-left': '${horizontalMargin}px',
            if (isLast) 'padding-right': '${horizontalMargin}px',
            'color': theme.textStyle.color.toString(),
            if (col.numeric) 'text-align': 'right' else 'text-align': 'left',
          },
          children: [cell.child.buildNode(context)],
        ));
      }

      bodyRows.add(FlartElementNode(
        'tr',
        styles: {
          'height': '${dataRowHeight}px',
          'border-bottom': '1px solid ${theme.dividerColor}',
          'background-color': row.selected ? 'rgba(0,0,0,0.05)' : 'transparent',
        },
        children: cells,
      ));
    }

    final tbodyNode = FlartElementNode(
      'tbody',
      children: bodyRows,
    );

    final tableNode = FlartElementNode(
      'table',
      styles: {
        'width': '100%',
        'border-collapse': 'collapse',
        'font-family': 'inherit',
        'font-size': '14px',
      },
      children: [theadNode, tbodyNode],
    );

    return FlartElementNode(
      'div',
      id: key?.toString(),
      attributes: {'class': 'flart-datatable-container'},
      styles: containerStyles,
      children: [tableNode],
    );
  }
}

class FDDataColumn {
  final Widget label;
  final bool numeric;
  final String? tooltip;

  const FDDataColumn({
    required this.label,
    this.numeric = false,
    this.tooltip,
  });
}

class FDDataRow {
  final List<FDDataCell> cells;
  final bool selected;
  final ValueChanged<bool?>? onSelectChanged;

  const FDDataRow({
    required this.cells,
    this.selected = false,
    this.onSelectChanged,
  });
}

class FDDataCell {
  final Widget child;
  final bool placeholder;

  const FDDataCell(
    this.child, {
    this.placeholder = false,
  });
}

typedef DataTable<T> = FDDataTable<T>;
typedef DataColumn = FDDataColumn;
typedef DataRow = FDDataRow;
typedef DataCell = FDDataCell;
