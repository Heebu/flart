import 'package:flartdart/flartdart.dart';
import '../widgets/showcase_card.dart';

class InteractiveShowcase extends StatefulWidget {
  @override
  State<InteractiveShowcase> createState() => _InteractiveShowcaseState();
}

class _InteractiveShowcaseState extends State<InteractiveShowcase> {
  bool _switchValue = false;
  DateTimeRange? _dateRange;

  @override
  Widget build(BuildContext context) {
    return FDColumn(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FDText(
          'Interactive Widgets',
          style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: FlartColor('#1e293b')),
        ),
        FDSizedBox(height: 8),
        FDText(
          'Advanced form inputs and pickers.',
          style: TextStyle(fontSize: 16, color: FlartColor('#64748b')),
        ),
        FDSizedBox(height: 32),
        ShowcaseCard(
          title: 'FDSwitch',
          description: 'A custom toggle switch.',
          child: FDSwitch(
            value: _switchValue,
            onChanged: (val) {
              setState(() {
                _switchValue = val;
              });
            },
            activeColor: FlartColors.blue,
          ),
        ),
        ShowcaseCard(
          title: 'FDDateRangePicker',
          description: 'A picker for selecting a start and end date.',
          child: FDDateRangePicker(
            label: 'Select Event Range',
            startDate: _dateRange?.start,
            endDate: _dateRange?.end,
            onChanged: (val) {
              setState(() {
                _dateRange = val;
              });
            },
          ),
        ),
        ShowcaseCard(
          title: 'DateTimePicker',
          description: 'A native datetime-local input.',
          child: DateTimePicker(
            label: 'Schedule Meeting',
            helperText: 'Pick a time for the meeting',
          ),
        ),
        ShowcaseCard(
          title: 'RangePicker',
          description: 'A dual slider for picking a number range.',
          child: RangePicker(
            min: 0,
            max: 100,
            startValue: 20,
            endValue: 80,
            label: 'Price Range (\$)',
          ),
        ),
      ],
    );
  }
}
