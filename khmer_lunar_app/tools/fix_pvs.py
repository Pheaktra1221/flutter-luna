# Fix ព.ស. space issue
path = r'D:\Calender\khmer_lunar_app\lib\main.dart'
with open(path, encoding='utf-8') as f:
    src = f.read()

before = src.count('\u17e1.\u179f. ${lunar.lunarYear}')
src = src.replace('\u17e1.\u179f. ${lunar.lunarYear}', '\u17e1.\u179f.${lunar.lunarYear}')
after = src.count('\u17e1.\u179f.${lunar.lunarYear}')

with open(path, 'w', encoding='utf-8') as f:
    f.write(src)
print(f'Replaced {before} instances, now {after} without space')
