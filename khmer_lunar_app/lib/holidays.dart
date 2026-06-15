// Cambodian holidays split by type:
// - national: official government public holidays (shown RED)
// - other: commemorative/observance days (shown GREEN)
class KhmerHolidays {
  // ── Official public holidays – offices/schools CLOSED ───────────────────────
  static const Map<String, String> national = {
    '01-01': 'ទិវាចូលឆ្នាំសកល (International New Year)',
    '01-07': 'ទិវាជ័យជម្នះ (Victory over Genocide Day)',
    '03-08': 'ទិវានារីអន្តរជាតិ (International Women\'s Day)',
    '04-13': 'ចូលឆ្នាំខ្មែរ - មហាសង្ក្រាន្ត (Khmer New Year Day 1)',
    '04-14': 'ចូលឆ្នាំខ្មែរ - វ័នបត (Khmer New Year Day 2)',
    '04-15': 'ចូលឆ្នាំខ្មែរ - ឡើងស័ក (Khmer New Year Day 3)',
    '05-01': 'ទិវាពលករអន្តរជាតិ (International Labour Day)',
    '05-14': 'ព្រះរាជពិធីបុណ្យចម្រើនព្រះជន្ម ព្រះបាទ នរោត្តម សីហមុនី',
    '06-18':
        'ព្រះរាជពិធីបុណ្យចម្រើនព្រះជន្ម សម្តេចព្រះមហាក្សត្រី នរោត្តម មុនិនាថ សីហនុ',
    '08-24': 'ទិវាធម្មនុញ្ញ (Constitutional Day)',
    '09-24': 'ទិវារដ្ឋធម្មនុញ្ញ (Constitution Day)',
    '10-23': 'ទិវាសន្តិភាពកម្ពុជា (Paris Peace Agreement Day)',
    '10-29': 'ព្រះរាជពិធីគ្រងរាជ្យ (Coronation Day)',
    '11-09': 'ទិវាឯករាជ្យជាតិ (National Independence Day)',
  };

  // ── Observance / commemorative days – shown GREEN ────────────────────────────
  static const Map<String, String> other = {
    '02-14': 'ទិវាបេះដូង (Valentine\'s Day)',
    '05-09': 'ទិវាប្រឆាំងអំពើប្រល័យពូជសាសន៍ (Genocide Day)',
    '06-01': 'ទិវាការពារកុមារអន្តរជាតិ (International Children\'s Day)',
    '06-19': 'ទិវាឪពុក (Father\'s Day)',
    '10-31': 'ហាឡូវីន (Halloween)',
    '12-10': 'ទិវាសិទ្ធិមនុស្ស (Human Rights Day)',
    '12-25': 'បុណ្យណូអែល (Christmas)',
  };

  static bool isNationalHoliday(DateTime date) =>
      national.containsKey(_key(date));

  static bool isOtherDay(DateTime date) => other.containsKey(_key(date));

  // Keep isHoliday for backward compat — true for either type
  static bool isHoliday(DateTime date) =>
      isNationalHoliday(date) || isOtherDay(date);

  static String? getHolidayName(DateTime date) =>
      national[_key(date)] ?? other[_key(date)];

  static String _key(DateTime date) =>
      '${date.month.toString().padLeft(2, '0')}-'
      '${date.day.toString().padLeft(2, '0')}';
}
