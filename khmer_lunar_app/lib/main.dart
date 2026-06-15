import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_khmer_chankitec/flutter_khmer_chankitec.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'holidays.dart';

void main() {
  runApp(const KhmerLunarApp());
}

// ── Font ─────────────────────────────────────────────────────────────────────
const kFont = 'KhmerOSSiemreap';
TextStyle kStyle(
  double size, {
  FontWeight weight = FontWeight.normal,
  Color color = Colors.black87,
  double height = 1.5,
}) => TextStyle(
  fontFamily: kFont,
  fontSize: size,
  fontWeight: weight,
  color: color,
  height: height,
);

// ── Palette ──────────────────────────────────────────────────────────────────
const kGreenDark = Color(0xFF1B5E20);
const kGreenMid = Color(0xFF2E7D32);
const kGreenAccent = Color(0xFF4CAF50);
const kBgCream = Color(0xFFFAF3EB);
const kOrange = Color(0xFFB45309);
const kOrangeBtn = Color(0xFFC2610A);
const kHolidayRed = Color(0xFFB71C1C);
const kOtherGreen = Color(0xFF1B5E20);
const kSundayBlue = Color(0xFF1565C0);
const kSilaColor = Color(0xFF6A1B9A);

// Background tints for distinct day types
const kNationalBg = Color(0xFFFFEBEE); // light red
const kOtherBg = Color(0xFFE8F5E9); // light green
const kSilaBg = Color(0xFFF3E5F5); // light purple

// ── Labels ───────────────────────────────────────────────────────────────────
const kDayHeaders = ['អាទិ', 'ចន្ទ', 'អង្គារ', 'ពុធ', 'ព្រហ', 'សុក្រ', 'សៅរ៍'];
const kKhmerMonths = [
  'មករា',
  'កុម្ភៈ',
  'មីនា',
  'មេសា',
  'ឧសភា',
  'មិថុនា',
  'កក្កដា',
  'សីហា',
  'កញ្ញា',
  'តុលា',
  'វិច្ឆិកា',
  'ធ្នូ',
];

enum FmtMode { banth, soriya, twoRow, tak }

const _fmtLabels = {
  FmtMode.banth: 'ចន្ទគតិ',
  FmtMode.soriya: 'សុរយគតិ',
  FmtMode.twoRow: '២ជួរ',
  FmtMode.tak: 'ដាក់ឈ្មោះ',
};
const _takSuggestions = ['ផ្អែមស', 'ការិរោល័យ', 'ផ្នោល', 'អនុស្សរៈ'];

// ── App ───────────────────────────────────────────────────────────────────────
class KhmerLunarApp extends StatelessWidget {
  const KhmerLunarApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'ប្រតិទិនខ្មែរ',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: kGreenMid),
      fontFamily: kFont,
      useMaterial3: true,
      scaffoldBackgroundColor: kBgCream,
    ),
    home: const CalendarPage(),
  );
}

// ── Calendar page ─────────────────────────────────────────────────────────────
class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});
  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late DateTime _month, _selected;

  @override
  void initState() {
    super.initState();
    final n = DateTime.now();
    _month = DateTime(n.year, n.month);
    _selected = DateTime(n.year, n.month, n.day);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgCream,
      body: LayoutBuilder(
        builder: (ctx, constraints) {
          final wide = constraints.maxWidth > 820;
          return Column(
            children: [
              const _AppHeader(),
              Expanded(
                child: wide
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex: 55, child: _leftPanel()),
                          VerticalDivider(
                            width: 1,
                            color: Colors.green.shade200,
                          ),
                          Expanded(flex: 45, child: _rightPanel()),
                        ],
                      )
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            _leftPanel(scrollable: false),
                            _rightPanel(),
                          ],
                        ),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _leftPanel({bool scrollable = true}) {
    final cal = Column(
      children: [
        _MonthNav(
          year: _month.year,
          month: _month.month,
          onPrev: () =>
              setState(() => _month = DateTime(_month.year, _month.month - 1)),
          onNext: () =>
              setState(() => _month = DateTime(_month.year, _month.month + 1)),
        ),
        const _DayHeaderRow(),
        _CalendarGrid(
          displayMonth: _month,
          selectedDay: _selected,
          onDayTap: (d) => setState(() => _selected = d),
        ),
      ],
    );
    if (!scrollable) return cal;
    return Column(
      children: [
        _MonthNav(
          year: _month.year,
          month: _month.month,
          onPrev: () =>
              setState(() => _month = DateTime(_month.year, _month.month - 1)),
          onNext: () =>
              setState(() => _month = DateTime(_month.year, _month.month + 1)),
        ),
        const _DayHeaderRow(),
        Expanded(
          child: SingleChildScrollView(
            child: _CalendarGrid(
              displayMonth: _month,
              selectedDay: _selected,
              onDayTap: (d) => setState(() => _selected = d),
            ),
          ),
        ),
      ],
    );
  }

  Widget _rightPanel() => _RightPanel(selectedDay: _selected);
}

// ── App header ────────────────────────────────────────────────────────────────
class _AppHeader extends StatelessWidget {
  const _AppHeader();
  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    color: kGreenDark,
    padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipOval(
          child: Image.asset(
            'assets/images/app_icon.png',
            width: 36,
            height: 36,
            errorBuilder: (_, __, ___) =>
                const Icon(Icons.calendar_month, color: Colors.white, size: 36),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          'ប្រតិទិនខ្មែរ',
          style: kStyle(22, weight: FontWeight.bold, color: Colors.white),
        ),
      ],
    ),
  );
}

// ── Month nav ─────────────────────────────────────────────────────────────────
class _MonthNav extends StatelessWidget {
  final int year, month;
  final VoidCallback onPrev, onNext;
  const _MonthNav({
    required this.year,
    required this.month,
    required this.onPrev,
    required this.onNext,
  });
  @override
  Widget build(BuildContext context) => Container(
    color: kGreenMid,
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: onPrev,
          icon: const Icon(Icons.chevron_left, color: Colors.white),
          splashRadius: 18,
        ),
        Text(
          '${kKhmerMonths[month - 1]} $year',
          style: kStyle(17, weight: FontWeight.bold, color: Colors.white),
        ),
        IconButton(
          onPressed: onNext,
          icon: const Icon(Icons.chevron_right, color: Colors.white),
          splashRadius: 18,
        ),
      ],
    ),
  );
}

// ── Day header row ────────────────────────────────────────────────────────────
class _DayHeaderRow extends StatelessWidget {
  const _DayHeaderRow();
  @override
  Widget build(BuildContext context) => Container(
    color: kGreenAccent,
    child: Row(
      children: [
        SizedBox(
          width: 30,
          child: Center(
            child: Text(
              '#',
              style: kStyle(10, weight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ),
        ...List.generate(
          7,
          (i) => Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 6),
              alignment: Alignment.center,
              child: Text(
                kDayHeaders[i],
                style: kStyle(
                  11,
                  weight: FontWeight.w700,
                  color: (i == 0 || i == 6)
                      ? Colors.red.shade200
                      : Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// ── Calendar grid ─────────────────────────────────────────────────────────────
class _CalendarGrid extends StatelessWidget {
  final DateTime displayMonth, selectedDay;
  final ValueChanged<DateTime> onDayTap;
  const _CalendarGrid({
    required this.displayMonth,
    required this.selectedDay,
    required this.onDayTap,
  });

  static int _isoWeek(DateTime d) {
    final doy = d.difference(DateTime(d.year, 1, 1)).inDays + 1;
    return ((doy - d.weekday + 10) / 7).floor();
  }

  @override
  Widget build(BuildContext context) {
    final firstDay = DateTime(displayMonth.year, displayMonth.month, 1);
    final daysInMonth = DateTime(
      displayMonth.year,
      displayMonth.month + 1,
      0,
    ).day;
    final startOffset = firstDay.weekday % 7;
    final today = DateTime.now();
    final rows = <Widget>[];
    int day = 1 - startOffset;

    while (day <= daysInMonth) {
      final rowDate = day >= 1
          ? DateTime(displayMonth.year, displayMonth.month, day)
          : firstDay;
      final weekNum = _isoWeek(rowDate);
      final cells = <Widget>[];

      for (int col = 0; col < 7; col++, day++) {
        if (day < 1 || day > daysInMonth) {
          cells.add(const Expanded(child: SizedBox()));
          continue;
        }
        final date = DateTime(displayMonth.year, displayMonth.month, day);
        final lunar = Chhankitek.fromDate(date);
        final isToday =
            date.year == today.year &&
            date.month == today.month &&
            date.day == today.day;
        final isSel =
            date.year == selectedDay.year &&
            date.month == selectedDay.month &&
            date.day == selectedDay.day;
        cells.add(
          Expanded(
            child: _DayCell(
              date: date,
              lunarLabel: lunar.lunarDay.toString(),
              holidayName: KhmerHolidays.getHolidayName(date),
              isToday: isToday,
              isSelected: isSel,
              isSunday: date.weekday == DateTime.sunday,
              isSaturday: date.weekday == DateTime.saturday,
              isSila: lunar.isSilaDay,
              isFullMoon: lunar.isFullMoon,
              onTap: () => onDayTap(date),
            ),
          ),
        );
      }

      rows.add(
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 30,
                color: kGreenDark,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text(
                  '$weekNum',
                  style: kStyle(9, color: Colors.white70),
                ),
              ),
              ...cells,
            ],
          ),
        ),
      );
    }

    return Container(
      color: const Color(0xFFFFFBF5),
      child: Column(children: rows),
    );
  }
}

// ── Day cell ──────────────────────────────────────────────────────────────────
class _DayCell extends StatelessWidget {
  final DateTime date;
  final String lunarLabel;
  final String? holidayName;
  final bool isToday, isSelected, isSunday, isSaturday, isSila, isFullMoon;
  final VoidCallback onTap;

  const _DayCell({
    required this.date,
    required this.lunarLabel,
    required this.holidayName,
    required this.isToday,
    required this.isSelected,
    required this.isSunday,
    required this.isSaturday,
    required this.isSila,
    required this.isFullMoon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isNational = KhmerHolidays.isNationalHoliday(date);
    final isOther = KhmerHolidays.isOtherDay(date);
    final hi = isToday || isSelected;

    // ── Number colour ─────────────────────────────────────────────────────────
    Color numColor;
    if (hi) {
      numColor = Colors.white;
    } else if (isNational) {
      numColor = kHolidayRed;
    } else if (isOther) {
      numColor = kOtherGreen;
    } else if (isSunday) {
      numColor = kSundayBlue;
    } else if (isSaturday) {
      numColor = Colors.teal.shade700;
    } else {
      numColor = Colors.black87;
    }

    // ── Cell background ───────────────────────────────────────────────────────
    Color bgColor;
    if (isToday) {
      bgColor = kGreenMid;
    } else if (isSelected) {
      bgColor = kGreenAccent.withValues(alpha: 0.25);
    } else if (isNational) {
      bgColor = kNationalBg;
    } else if (isOther) {
      bgColor = kOtherBg;
    } else if (isSila) {
      bgColor = kSilaBg;
    } else {
      bgColor = Colors.transparent;
    }

    // ── Left accent bar ───────────────────────────────────────────────────────
    Color? barColor;
    if (!hi && isNational) {
      barColor = kHolidayRed;
    } else if (!hi && isOther) {
      barColor = kOtherGreen;
    } else if (!hi && isSila) {
      barColor = kSilaColor;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minHeight: 56),
        decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(color: Colors.green.shade100, width: 0.5),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Coloured left bar for holiday types
            if (barColor != null) Container(width: 3, color: barColor),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${date.day}',
                          style: kStyle(
                            13,
                            weight: FontWeight.bold,
                            color: numColor,
                          ),
                        ),
                        if (isFullMoon)
                          const Text('🌕', style: TextStyle(fontSize: 8)),
                      ],
                    ),
                    Text(
                      lunarLabel,
                      style: kStyle(
                        9,
                        color: hi ? Colors.white70 : Colors.brown.shade400,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (holidayName != null && !hi)
                      Text(
                        holidayName!.split('(').first.trim(),
                        style: kStyle(
                          7.5,
                          color: isNational ? kHolidayRed : kOtherGreen,
                          height: 1.1,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    if (isSila && !hi && !isNational && !isOther)
                      Text('សីល', style: kStyle(7.5, color: kSilaColor)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Right panel ───────────────────────────────────────────────────────────────
class _RightPanel extends StatefulWidget {
  final DateTime selectedDay;
  const _RightPanel({required this.selectedDay});
  @override
  State<_RightPanel> createState() => _RightPanelState();
}

class _RightPanelState extends State<_RightPanel> {
  FmtMode _mode = FmtMode.banth;
  final _ctrl = TextEditingController();
  final _prefixCtrl = TextEditingController(text: 'ផ្លូវមាស');
  bool _editingPrefix = false;
  String _copyMsg = '';
  static const _prefixKey = 'solar_prefix';

  @override
  void initState() {
    super.initState();
    _loadPrefix();
  }

  Future<void> _loadPrefix() async {
    final p = await SharedPreferences.getInstance();
    final s = p.getString(_prefixKey);
    if (s != null && mounted) setState(() => _prefixCtrl.text = s);
  }

  Future<void> _savePrefix(String v) async {
    final p = await SharedPreferences.getInstance();
    await p.setString(_prefixKey, v);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _prefixCtrl.dispose();
    super.dispose();
  }

  String _output(KhmerLunarDate lunar) {
    switch (_mode) {
      case FmtMode.banth:
        final pre = _prefixCtrl.text.trim();
        return 'ថ្ងៃ${lunar.dayOfWeek} ${lunar.lunarDay} ខែ${lunar.lunarMonth}'
            ' ឆ្នាំ${lunar.lunarZodiac} ${lunar.lunarEra} ព.ស. ${lunar.lunarYear}'
            '\n${pre.isNotEmpty ? "$pre " : ""}${lunar.solarDate}';
      case FmtMode.soriya:
        return lunar.solarDate;
      case FmtMode.twoRow:
        return 'ថ្ងៃ${lunar.dayOfWeek} ${lunar.lunarDay} ខែ${lunar.lunarMonth}'
            ' ឆ្នាំ${lunar.lunarZodiac} ${lunar.lunarEra} ព.ស. ${lunar.lunarYear}'
            '\n${lunar.solarDate}';
      case FmtMode.tak:
        final p = _ctrl.text.trim();
        if (p.isEmpty) return lunar.toString();
        try {
          return lunar.format(p);
        } catch (_) {
          return lunar.toString();
        }
    }
  }

  void _copy(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    setState(() => _copyMsg = 'Copied!');
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _copyMsg = '');
    });
  }

  @override
  Widget build(BuildContext context) {
    final lunar = Chhankitek.fromDate(widget.selectedDay);
    final holiday = KhmerHolidays.getHolidayName(widget.selectedDay);
    final isNat = KhmerHolidays.isNationalHoliday(widget.selectedDay);
    final output = _output(lunar);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Legend ──────────────────────────────────────────────────────────
          _card(
            child: Wrap(
              spacing: 12,
              runSpacing: 6,
              children: [
                _legendItem(kHolidayRed, kNationalBg, 'ថ្ងៃឈប់ជាតិ'),
                _legendItem(kOtherGreen, kOtherBg, 'ថ្ងៃពិសេស'),
                _legendItem(kSilaColor, kSilaBg, 'ថ្ងៃសីល'),
                _legendItem(
                  kGreenMid,
                  kGreenMid,
                  'ថ្ងៃនេះ',
                  textColor: Colors.white,
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // ── Summary ──────────────────────────────────────────────────────────
          _card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: kStyle(14.5, weight: FontWeight.bold, height: 1.7),
                    children: [
                      TextSpan(
                        text:
                            'ថ្ងៃ${lunar.dayOfWeek} ${lunar.lunarDay} ខែ${lunar.lunarMonth}'
                            ' ឆ្នាំ${lunar.lunarZodiac} ${lunar.lunarEra} ព.ស. ${lunar.lunarYear}',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 2),
                _PrefixRow(
                  controller: _prefixCtrl,
                  editing: _editingPrefix,
                  solarDate: lunar.solarDate,
                  onEdit: () => setState(() => _editingPrefix = true),
                  onSave: () {
                    _savePrefix(_prefixCtrl.text.trim());
                    setState(() => _editingPrefix = false);
                  },
                  onChanged: () => setState(() {}),
                ),
                if (holiday != null) ...[
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        size: 7,
                        color: isNat ? kHolidayRed : kOtherGreen,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          holiday,
                          style: kStyle(
                            12,
                            color: isNat ? kHolidayRed : kOtherGreen,
                            weight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
                if (lunar.isFullMoon) ...[
                  const SizedBox(height: 3),
                  Text(
                    '🌕 ថ្ងៃពេញបូណ៌មី',
                    style: kStyle(
                      12,
                      color: kSilaColor,
                      weight: FontWeight.w600,
                    ),
                  ),
                ],
                if (lunar.isSilaDay) ...[
                  const SizedBox(height: 3),
                  Text(
                    '🙏 ថ្ងៃសីល',
                    style: kStyle(
                      12,
                      color: kSilaColor,
                      weight: FontWeight.w600,
                    ),
                  ),
                ],
              ],
            ),
          ),

          const SizedBox(height: 12),

          // ── Detail rows ───────────────────────────────────────────────────────
          _card(
            child: Column(
              children: [
                _row('ថ្ងៃ', '${lunar.dayOfWeek}  (${lunar.dayOfWeekEn})'),
                _row(
                  'ថ្ងៃចន្ទ',
                  '${lunar.lunarDay}  (${lunar.shortLunarDayEn})',
                ),
                _row('ខែ', '${lunar.lunarMonth}  (${lunar.lunarMonthEn})'),
                _row('ឆ្នាំ', '${lunar.lunarZodiac}  (${lunar.lunarZodiacEn})'),
                _row('សក័', '${lunar.lunarEra}  (${lunar.lunarEraEn})'),
                _row('ព.ស.', '${lunar.lunarYear}  (${lunar.lunarYearInt})'),
                _row('ថ្ងៃ (គ.ស.)', lunar.solarDate),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // ── Format ────────────────────────────────────────────────────────────
          _card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Format', style: kStyle(12, color: Colors.black45)),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  children: FmtMode.values.map((m) {
                    final active = _mode == m;
                    return GestureDetector(
                      onTap: () => setState(() => _mode = m),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 140),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: active ? kOrange : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: active ? kOrange : Colors.grey.shade300,
                          ),
                        ),
                        child: Text(
                          _fmtLabels[m]!,
                          style: kStyle(
                            13,
                            weight: FontWeight.w600,
                            color: active ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),

                if (_mode == FmtMode.tak) ...[
                  const SizedBox(height: 12),
                  Text(
                    'ដាក់ឈ្មោះ (អាចផ្លាស់ប្ដូរបាន)',
                    style: kStyle(12, color: Colors.black45),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _ctrl,
                    onChanged: (_) => setState(() {}),
                    style: kStyle(14),
                    decoration: InputDecoration(
                      hintText: 'ដូចជា: W d N m a e b',
                      hintStyle: kStyle(13, color: Colors.black38),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: kOrange),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: kOrange,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      suffixIcon: _ctrl.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear, size: 18),
                              onPressed: () => setState(() => _ctrl.clear()),
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 6,
                    children: _takSuggestions
                        .map(
                          (s) => ActionChip(
                            label: Text(s, style: kStyle(12)),
                            onPressed: () => setState(() => _ctrl.text = s),
                            backgroundColor: Colors.orange.shade50,
                            side: BorderSide(color: Colors.orange.shade200),
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                          ),
                        )
                        .toList(),
                  ),
                ],

                const SizedBox(height: 14),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF8F0),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.orange.shade200),
                  ),
                  child: Text(
                    output,
                    style: kStyle(15, color: kOrange, height: 1.8),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kOrangeBtn,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        onPressed: () => _copy(output),
                        child: Text(
                          _copyMsg.isNotEmpty ? _copyMsg : 'បញ្ចូល',
                          style: kStyle(
                            15,
                            weight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.grey.shade300),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        onPressed: () => _copy(output),
                        child: Text(
                          'Copy',
                          style: kStyle(14, color: Colors.black54),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.grey.shade300),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        onPressed: () => _copy(output.replaceAll('\n', '\t')),
                        child: Text(
                          'Cell',
                          style: kStyle(14, color: Colors.black54),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _legendItem(
    Color color,
    Color bg,
    String label, {
    Color textColor = Colors.black87,
  }) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: color.withValues(alpha: 0.4)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 3,
          height: 14,
          color: color,
          margin: const EdgeInsets.only(right: 5),
        ),
        Text(
          label,
          style: kStyle(
            11,
            color: textColor == Colors.black87 ? color : textColor,
            weight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );

  Widget _card({required Widget child}) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.green.shade100),
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.04),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: child,
  );

  Widget _row(String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 88,
          child: Text(
            label,
            style: kStyle(
              13,
              weight: FontWeight.w600,
              color: Colors.green.shade800,
            ),
          ),
        ),
        Expanded(child: Text(value, style: kStyle(13))),
      ],
    ),
  );
}

// ── Editable prefix row ───────────────────────────────────────────────────────
class _PrefixRow extends StatelessWidget {
  final TextEditingController controller;
  final bool editing;
  final String solarDate;
  final VoidCallback onEdit, onSave, onChanged;
  const _PrefixRow({
    required this.controller,
    required this.editing,
    required this.solarDate,
    required this.onEdit,
    required this.onSave,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (editing) {
      return Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              autofocus: true,
              onChanged: (_) => onChanged(),
              style: kStyle(13, color: Colors.brown.shade700),
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 6,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: kOrange),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: kOrange, width: 1.5),
                ),
                suffixText: '  $solarDate',
                suffixStyle: kStyle(13, color: Colors.brown.shade500),
              ),
            ),
          ),
          const SizedBox(width: 6),
          GestureDetector(
            onTap: onSave,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: kOrangeBtn,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'រក្សាទុក',
                style: kStyle(11, color: Colors.white, weight: FontWeight.bold),
              ),
            ),
          ),
        ],
      );
    }
    return GestureDetector(
      onTap: onEdit,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.orange.shade200),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  controller.text.isNotEmpty ? controller.text : 'ផ្លូវមាស',
                  style: kStyle(13, color: kOrange, weight: FontWeight.w600),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.edit,
                  size: 12,
                  color: kOrange.withValues(alpha: 0.7),
                ),
              ],
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              solarDate,
              style: kStyle(13, color: Colors.brown.shade600),
            ),
          ),
        ],
      ),
    );
  }
}
