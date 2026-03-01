import '../../../flartdart.dart';

class FDDataTable<T> extends Widget {
  final List<FDDataColumn> columns;
  final List<FDDataRow> rows;
  final double? columnSpacing;
  final double? dataRowHeight;
  final double? headingRowHeight;
  final double? horizontalMargin;
  final bool showCheckboxColumn;
  final String? rawCss;

  FDDataTable({
    required this.columns,
    required this.rows,
    this.columnSpacing = 24.0,
    this.dataRowHeight = 48.0,
    this.headingRowHeight = 56.0,
    this.horizontalMargin = 24.0,
    this.showCheckboxColumn = false,
    this.rawCss,
  });

  @override
  String render(BuildContext context) {
    final theme = Theme.of(context);
    final id = 'datatable_${DateTime.now().microsecondsSinceEpoch}';

    final buffer = StringBuffer();
    buffer.writeln('''
      <div class="flart-datatable-container" style="
        width: 100%;
        overflow-x: auto;
        background-color: ${theme.cardColor};
        border-radius: 4px;
        box-shadow: 0 1px 3px rgba(0,0,0,0.12);
        ${rawCss ?? ''}
      ">
        <table id="$id" style="
          width: 100%;
          border-collapse: collapse;
          font-family: inherit;
          font-size: 14px;
        ">
          <thead>
            <tr style="
              height: ${headingRowHeight}px;
              border-bottom: 2px solid ${theme.dividerColor};
              text-align: left;
            ">
    ''');

    for (var col in columns) {
      buffer.writeln('''
        <th style="
          padding: 0 ${columnSpacing! / 2}px;
          color: ${theme.textStyle.color};
          font-weight: 600;
          ${col.numeric ? 'text-align: right;' : ''}
          ${col == columns.first ? 'padding-left: ${horizontalMargin}px;' : ''}
          ${col == columns.last ? 'padding-right: ${horizontalMargin}px;' : ''}
        ">
          ${col.label.render(context)}
        </th>
      ''');
    }

    buffer.writeln('</tr></thead><tbody>');

    for (var row in rows) {
      buffer.writeln('''
        <tr style="
          height: ${dataRowHeight}px;
          border-bottom: 1px solid ${theme.dividerColor};
          transition: background-color 0.2s;
        " onmouseover="this.style.backgroundColor='rgba(0,0,0,0.02)'" onmouseout="this.style.backgroundColor='transparent'">
      ''');

      for (var i = 0; i < row.cells.length; i++) {
        final cell = row.cells[i];
        final col = columns[i];
        buffer.writeln('''
          <td style="
            padding: 0 ${columnSpacing! / 2}px;
            color: ${theme.textStyle.color};
            ${col.numeric ? 'text-align: right;' : ''}
            ${i == 0 ? 'padding-left: ${horizontalMargin}px;' : ''}
            ${i == row.cells.length - 1 ? 'padding-right: ${horizontalMargin}px;' : ''}
          ">
            ${cell.child.render(context)}
          </td>
        ''');
      }
      buffer.writeln('</tr>');
    }

    buffer.writeln('</tbody></table></div>');

    return buffer.toString();
  }
}

class FDDataColumn {
  final Widget label;
  final bool numeric;
  final String? tooltip;

  FDDataColumn({
    required this.label,
    this.numeric = false,
    this.tooltip,
  });
}

class FDDataRow {
  final List<FDDataCell> cells;
  final bool selected;
  final ValueChanged<bool?>? onSelectChanged;

  FDDataRow({
    required this.cells,
    this.selected = false,
    this.onSelectChanged,
  });
}

class FDDataCell {
  final Widget child;
  final bool placeholder;

  FDDataCell({
    required this.child,
    this.placeholder = false,
  });
}
