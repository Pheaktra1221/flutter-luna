# Patch 1: Build method - remove SingleChildScrollView in wide mode, use stretch grid
# Patch 2: _CalendarGrid - use LayoutBuilder to fill height evenly

path = r'D:\Calender\khmer_lunar_app\lib\main.dart'
with open(path, encoding='utf-8') as f:
    src = f.read()

# ── Patch 1: wide layout - remove scroll, let grid fill ─────────────────────
old_wide = (
    "            Expanded(child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [\n"
    "              Expanded(flex: 55, child: Column(children: [\n"
    "                _MonthNav(\n"
    "                  year: _month.year, month: _month.month,\n"
    "                  onPrev: () => setState(() => _month = DateTime(_month.year, _month.month - 1)),\n"
    "                  onNext: () => setState(() => _month = DateTime(_month.year, _month.month + 1)),\n"
    "                ),\n"
    "                const _DayHeaderRow(),\n"
    "                Expanded(child: SingleChildScrollView(child: _CalendarGrid(\n"
    "                  displayMonth: _month, selectedDay: _selected,\n"
    "                  onDayTap: (d) => setState(() => _selected = d),\n"
    "                ))),\n"
    "              ])),\n"
    "              VerticalDivider(width: 1, color: Colors.green.shade200),\n"
    "              Expanded(flex: 45, child: _RightPanel(selectedDay: _selected)),\n"
    "            ])),\n"
    "          ]);"
)
new_wide = (
    "            Expanded(child: Row(children: [\n"
    "              Expanded(flex: 55, child: Column(children: [\n"
    "                _MonthNav(\n"
    "                  year: _month.year, month: _month.month,\n"
    "                  onPrev: () => setState(() => _month = DateTime(_month.year, _month.month - 1)),\n"
    "                  onNext: () => setState(() => _month = DateTime(_month.year, _month.month + 1)),\n"
    "                ),\n"
    "                const _DayHeaderRow(),\n"
    "                Expanded(child: _CalendarGrid(\n"
    "                  displayMonth: _month, selectedDay: _selected,\n"
    "                  onDayTap: (d) => setState(() => _selected = d),\n"
    "                )),\n"
    "              ])),\n"
    "              VerticalDivider(width: 1, color: Colors.green.shade200),\n"
    "              Expanded(flex: 45, child: _RightPanel(selectedDay: _selected)),\n"
    "            ])),\n"
    "          ]);"
)
if old_wide in src:
    src = src.replace(old_wide, new_wide)
    print("Patch 1 applied: wide layout updated")
else:
    print("Patch 1 NOT found")

# ── Patch 2: _CalendarGrid return - use LayoutBuilder for equal-height rows ──
old_return = (
    "    return Container(\n"
    "      color: const Color(0xFFFFFBF5),\n"
    "      child: Column(children: rows),\n"
    "    );\n"
    "  }\n"
    "}\n"
    "\n"
    "// \u2500\u2500 Day cell"
)
new_return = (
    "    return LayoutBuilder(builder: (context, constraints) {\n"
    "      // Distribute available height equally across all rows\n"
    "      final rowH = constraints.maxHeight.isFinite && rows.isNotEmpty\n"
    "          ? constraints.maxHeight / rows.length\n"
    "          : 72.0;\n"
    "      return Container(\n"
    "        color: const Color(0xFFFFFBF5),\n"
    "        child: Column(\n"
    "          children: rows.map((r) => SizedBox(height: rowH, child: r)).toList(),\n"
    "        ),\n"
    "      );\n"
    "    });\n"
    "  }\n"
    "}\n"
    "\n"
    "// \u2500\u2500 Day cell"
)
if old_return in src:
    src = src.replace(old_return, new_return)
    print("Patch 2 applied: grid uses LayoutBuilder for equal-height rows")
else:
    print("Patch 2 NOT found - trying simpler match")
    # Try without the comment
    old2 = (
        "    return Container(\n"
        "      color: const Color(0xFFFFFBF5),\n"
        "      child: Column(children: rows),\n"
        "    );\n"
        "  }\n"
        "}"
    )
    new2 = (
        "    return LayoutBuilder(builder: (context, constraints) {\n"
        "      final rowH = constraints.maxHeight.isFinite && rows.isNotEmpty\n"
        "          ? constraints.maxHeight / rows.length\n"
        "          : 72.0;\n"
        "      return Container(\n"
        "        color: const Color(0xFFFFFBF5),\n"
        "        child: Column(\n"
        "          children: rows.map((r) => SizedBox(height: rowH, child: r)).toList(),\n"
        "        ),\n"
        "      );\n"
        "    });\n"
        "  }\n"
        "}"
    )
    idx = src.find(old2)
    if idx != -1:
        src = src[:idx] + new2 + src[idx + len(old2):]
        print("Patch 2 applied via fallback")
    else:
        print("ERROR: Patch 2 not applied")

# ── Patch 3: _DayCell - remove minHeight constraint (LayoutBuilder controls height now) ──
old_min = "        constraints: const BoxConstraints(minHeight: 56),"
new_min = "        // height controlled by parent LayoutBuilder"
if old_min in src:
    src = src.replace(old_min, new_min)
    print("Patch 3 applied: removed minHeight from DayCell")

with open(path, 'w', encoding='utf-8') as f:
    f.write(src)
print("File saved")
