path = r'D:\Calender\khmer_lunar_app\lib\main.dart'
with open(path, encoding='utf-8') as f:
    src = f.read()

old = 'lunarEra} \u17e1.\u179f. ${lunar.lunarYear}'
new = 'lunarEra} \u17e1.\u179f.${lunar.lunarYear}'
count = src.count(old)
src = src.replace(old, new)

with open(path, 'w', encoding='utf-8') as f:
    f.write(src)
print(f'Replaced {count} instances')
