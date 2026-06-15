# Hex confirmed: ព=0x1796, ស=0x179f
# Pattern: lunarEra} 0x1796 . 0x179f . 0x20 ${lunar.lunarYear}
# Fix: remove the 0x20 (space) before ${
path = r'D:\Calender\khmer_lunar_app\lib\main.dart'
with open(path, encoding='utf-8') as f:
    src = f.read()

old = '\u1796.\u179f. ${lunar.lunarYear}'
new = '\u1796.\u179f.${lunar.lunarYear}'
count = src.count(old)
src = src.replace(old, new)

with open(path, 'w', encoding='utf-8') as f:
    f.write(src)
print(f'Replaced {count} instances of ព.ស. space fix')
