# -*- coding: utf-8 -*-
"""
Patch main.dart:
1. Remove space in ព.ស. ${lunar.lunarYear}  → ព.ស.${lunar.lunarYear}
2. Replace _leftPanel + build with responsive version (no _leftPanel helper)
"""
import re, sys

path = r'D:\Calender\khmer_lunar_app\lib\main.dart'

with open(path, encoding='utf-8') as f:
    src = f.read()

original = src

# ── Fix 1: ព.ស. <space> → ព.ស. (no space before year) ─────────────────────
# Matches the literal Khmer + ascii pattern in string literals
src = src.replace(
    '\u17e1.\u179f. ${lunar.lunarYear}',
    '\u17e1.\u179f.${lunar.lunarYear}'
)
print(f'Fix 1 applied: {src.count("ព.ស.${") } occurrences of ព.ស.${{')

# ── Fix 2: Replace CalendarPage build + _leftPanel + _rightPanel ────────────
old_block = '''\  @override
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
  }'''

# Use regex to find and replace the entire build method + _leftPanel + _rightPanel
# Find from @override\n  Widget build until Widget _rightPanel() => ... and its closing }
pattern = r'  @override\n  Widget build\(BuildContext context\) \{.*?Widget _rightPanel\(\) => _RightPanel\(selectedDay: _selected\);\n\}'

new_block = '''  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgCream,
      body: LayoutBuilder(builder: (ctx, constraints) {
        final wide = constraints.maxWidth > 820;
        if (wide) {
          return Column(children: [
            const _AppHeader(),
            Expanded(child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(flex: 55, child: Column(children: [
                _MonthNav(
                  year: _month.year, month: _month.month,
                  onPrev: () => setState(() => _month = DateTime(_month.year, _month.month - 1)),
                  onNext: () => setState(() => _month = DateTime(_month.year, _month.month + 1)),
                ),
                const _DayHeaderRow(),
                Expanded(child: SingleChildScrollView(child: _CalendarGrid(
                  displayMonth: _month, selectedDay: _selected,
                  onDayTap: (d) => setState(() => _selected = d),
                ))),
              ])),
              VerticalDivider(width: 1, color: Colors.green.shade200),
              Expanded(flex: 45, child: _RightPanel(selectedDay: _selected)),
            ])),
          ]);
        } else {
          return Column(children: [
            const _AppHeader(),
            _MonthNav(
              year: _month.year, month: _month.month,
              onPrev: () => setState(() => _month = DateTime(_month.year, _month.month - 1)),
              onNext: () => setState(() => _month = DateTime(_month.year, _month.month + 1)),
            ),
            const _DayHeaderRow(),
            Expanded(child: SingleChildScrollView(child: Column(children: [
              _CalendarGrid(displayMonth: _month, selectedDay: _selected, onDayTap: (d) => setState(() => _selected = d)),
              _RightPanel(selectedDay: _selected),
            ]))),
          ]);
        }
      }),
    );
  }'''

match = re.search(pattern, src, re.DOTALL)
if match:
    src = src[:match.start()] + new_block + '\n}' + src[match.end():]
    print('Fix 2 applied: build method replaced')
else:
    print('Fix 2 NOT applied – pattern not found, trying simpler approach')
    # Simpler: just find the _leftPanel and _rightPanel methods and remove them
    # and replace the build body
    # Find start of build method
    build_start = src.find('  @override\n  Widget build(BuildContext context) {')
    # Find end: the closing } of _rightPanel()
    right_panel_marker = '  Widget _rightPanel() => _RightPanel(selectedDay: _selected);\n}'
    right_panel_end = src.find(right_panel_marker)
    if build_start != -1 and right_panel_end != -1:
        end_pos = right_panel_end + len(right_panel_marker)
        src = src[:build_start] + new_block + '\n}\n' + src[end_pos:]
        print('Fix 2 applied via fallback')
    else:
        print(f'ERROR: build_start={build_start}, right_panel_end={right_panel_end}')

if src != original:
    with open(path, 'w', encoding='utf-8') as f:
        f.write(src)
    print('File saved successfully')
else:
    print('WARNING: No changes made')
