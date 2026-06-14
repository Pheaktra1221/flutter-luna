# Features Guide - Khmer Lunar Calendar App

## Overview
This app displays Khmer lunar calendar dates with full support for traditional Khmer date formats, Buddhist calendar, and important religious days.

---

## Main Features

### 1. Current Date Display

The app automatically shows:
- **Khmer Format:**
  ```
  ថ្ងៃអាទិត្យ ១០ កើត ខែបុស្ស ឆ្នាំរោង ឆស័ក ពុទ្ធសករាជ ២៥៦៨
  ត្រូវនឹងថ្ងៃទី០៨ ខែមករា ឆ្នាំ២០២៥
  ```

- **English Format:**
  ```
  Sunday 10 Waxing month of Boss year of Dragon Chor Sak BE 2568
  Equivalent to 8 January 2025
  ```

### 2. Date Picker

Click "Select Date" button to choose any date from:
- **Range**: 1900 - 2100
- **Calendar**: Standard Gregorian calendar
- **Conversion**: Automatic conversion to Khmer lunar date

### 3. Language Toggle

Switch between Khmer (ខ្មែរ) and English:
- Click the language icon in top-right
- All text updates instantly
- Setting applies to all information cards

### 4. Detailed Information Card

Shows complete lunar date breakdown:

| Khmer | English | Example |
|-------|---------|---------|
| ថ្ងៃ | Day of Week | អាទិត្យ / Sunday |
| ថ្ងៃទី (ចន្ទគតិ) | Lunar Day | ១០ កើត / 10 Waxing |
| ខែ | Lunar Month | បុស្ស / Boss |
| ឆ្នាំ | Zodiac Year | រោង / Dragon |
| សក័ | Era | ឆស័ក / Chor Sak |
| ពុទ្ធសករាជ | Buddhist Era | ២៥៦៨ / 2568 |

### 5. Special Days Indicator

**Orange Card** appears on:

#### Full Moon Day (ពេញបូណ៌មី)
- Day: 15កើត (15th day of waxing moon)
- Significance: Important Buddhist holy day
- Activities: Temple visits, meditation

#### Sila Days (ថ្ងៃសីល)
Buddhist holy days occurring on:
- **8កើត** - 8th day waxing
- **15កើត** - 15th day waxing (Full Moon)
- **8រោច** - 8th day waning
- **14រោច or 15រោច** - 14th or 15th day waning (New Moon)

On these days, Buddhists:
- Observe Eight Precepts
- Visit temples
- Practice meditation
- Make offerings

### 6. Khmer New Year Information

**Green Card** displays:

#### Current Year
```
ឆ្នាំ 2025 / Year 2025
កាលបរិច្ឆេទ: April 14, 2025
រយៈពេល: 3 ថ្ងៃ / 3 days
```

#### Next Year
Automatically shows next year's dates

#### Leap Year Detection
```
រយៈពេល: 4 ថ្ងៃ (ឆ្នាំអធិកមាស)
Duration: 4 days (Leap Year)
```

**3-Day Celebration (Normal Years):**
1. **Moha Songkran** (មហាសង្ក្រាន្ត) - New Year's Day
2. **Vanabat** (វ័នបត) - Second Day
3. **Lerng Sak** (ឡើងស័ក) - New Era Begins

**4-Day Celebration (Leap Years):**
- Extra Vanabat day between days 2 and 3

---

## Lunar Calendar Components

### Moon Phases

#### Kaeut (កើត) - Waxing Moon
- Days 1-15
- Moon growing to full
- Example: ១ កើត, ៨ កើត, ១៥ កើត

#### Roch (រោច) - Waning Moon
- Days 1-14/15
- Moon shrinking to new
- Example: ១ រោច, ៨ រោច, ១៤ រោច

### Lunar Months (ខែចន្ទគតិ)

| Index | Khmer | Pronunciation | Special Notes |
|-------|-------|---------------|---------------|
| 0 | មិគសិរ | Migasir | First month of lunar year |
| 1 | បុស្ស | Boss | |
| 2 | មាឃ | Meak | |
| 3 | ផល្គុន | Phalkun | |
| 4 | ចេត្រ | Cheit | Contains Khmer New Year |
| 5 | ពិសាខ | Pisakh | Contains Visakha Bochea (១៥កើត) |
| 6 | ជេស្ឋ | Jesth | Can have leap day (30 days) |
| 7 | អាសាឍ | Asadh | |
| 8 | ស្រាពណ៍ | Srap | |
| 9 | ភទ្របទ | Phatrabot | |
| 10 | អស្សុជ | Assoch | Contains Pchum Ben (១៥រោច) |
| 11 | កត្ដិក | Kadeuk | Contains Water Festival (១៥កើត) |
| 12 | បឋមាសាឍ | Pathamasadh | Leap month years only |
| 13 | ទុតិយាសាឍ | Tutiyasadh | Leap month years only |

### Zodiac Animals (រាសី)

12-year cycle:

| Khmer | English | Year Examples |
|-------|---------|---------------|
| ជូត | Rat | 2020, 2032 |
| ឆ្លូវ | Ox | 2021, 2033 |
| ខាល | Tiger | 2022, 2034 |
| ថោះ | Rabbit | 2023, 2035 |
| រោង | Dragon | 2024, 2036 |
| មសាញ់ | Snake | 2025, 2037 |
| មមី | Horse | 2026, 2038 |
| មមែ | Goat | 2027, 2039 |
| វក | Monkey | 2028, 2040 |
| រកា | Rooster | 2029, 2041 |
| ច | Dog | 2030, 2042 |
| កុរ | Pig | 2031, 2043 |

### Era Names (សក័)

10-year cycle:

| Khmer | Pronunciation | Years Ending In |
|-------|---------------|-----------------|
| ឆស័ក | Chor Sak | 0, 2, 4, 6, 8 |
| ឯកស័ក | Aek Sak | 1, 3, 5, 7, 9 |

---

## Important Buddhist Days

### Annual Celebrations

1. **Khmer New Year** (បុណ្យចូលឆ្នាំខ្មែរ)
   - Month: ចេត្រ (Cheit)
   - Date: Usually April 13-16
   - Duration: 3-4 days

2. **Visakha Bochea** (វិសាខបូជា)
   - Month: ពិសាខ (Pisakh)
   - Date: ១៥កើត (15th waxing)
   - Significance: Buddha's birth, enlightenment, death

3. **Pchum Ben** (បុណ្យភ្ជុំបិណ្ឌ)
   - Month: អស្សុជ (Assoch)
   - Date: ១-១៥រោច (1st-15th waning)
   - Significance: Ancestor commemoration

4. **Water Festival** (បុណ្យអុំទូក)
   - Month: កត្ដិក (Kadeuk)
   - Date: ១៥កើត (15th waxing)
   - Significance: Reversing of Tonle Sap flow

---

## Usage Tips

### Finding Special Days

1. Open the app
2. Select date range of interest
3. Look for orange special days card
4. Check if it's a Sila day or full moon

### Planning Temple Visits

1. Note the upcoming Sila days:
   - 8កើត and 15កើត
   - 8រោច and 14/15រោច
2. These occur 4 times per lunar month

### Checking New Year Dates

1. Scroll to green "Khmer New Year" card
2. View current and next year dates
3. Check if leap year (4 days) or normal (3 days)

### Converting Dates

1. Know a Gregorian date
2. Click "Select Date"
3. Choose the date
4. View instant Khmer lunar equivalent

---

## Technical Details

### Date Calculation
- Based on traditional Khmer astronomical calculations
- Accounts for lunar month variations
- Handles leap months (Athikameas)
- Supports Buddhist Era (BE) calendar

### Accuracy
- Calculations verified against traditional calendars
- Leap year rules properly implemented
- New Year timing follows official standards

### Date Range
- Supported: 1900-2100 (Gregorian)
- Buddhist Era: 2444-2644 BE approximately

---

## Frequently Asked Questions

**Q: Why does the lunar month sometimes have 29 days and sometimes 30?**  
A: The lunar cycle is ~29.5 days, so months alternate between 29 and 30 days to stay synchronized with the moon.

**Q: What is a leap month (Athikameas)?**  
A: Extra month added every ~3 years to realign lunar calendar with solar year. The month អាសាឍ (Asadh) can be doubled.

**Q: Why does Khmer New Year date change each year?**  
A: It's based on solar calculations, falling when the sun enters Aries, typically April 13-14.

**Q: How do I know if today is a Sila day?**  
A: The orange "Special Day" card will appear automatically on Sila days.

---

## Credits

**Calendar Calculations:** `flutter_khmer_chankitec` package  
**UI Framework:** Flutter  
**Date Formatting:** `intl` package
