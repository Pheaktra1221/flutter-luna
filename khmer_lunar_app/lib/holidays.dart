// Official Cambodian Public Holidays - ថ្ងៃឈប់សម្រាក់ជាតិ
// Only days where government offices, banks and schools are closed
class KhmerHolidays {
  static const Map<String, String> fixed = {
    // January
    '01-01': 'ទិវាចូលឆ្នាំសកល (International New Year)',
    '01-07': 'ទិវាជ័យជម្នះ (Victory over Genocide Day)',

    // March - Women's Day is a public holiday in Cambodia
    '03-08': 'ទិវានារីអន្តរជាតិ (International Women\'s Day)',

    // April - Khmer New Year (3 days, sometimes 4)
    '04-13': 'ចូលឆ្នាំខ្មែរ - មហាសង្ក្រាន្ត (Khmer New Year Day 1)',
    '04-14': 'ចូលឆ្នាំខ្មែរ - វ័នបត (Khmer New Year Day 2)',
    '04-15': 'ចូលឆ្នាំខ្មែរ - ឡើងស័ក (Khmer New Year Day 3)',

    // May
    '05-01': 'ទិវាពលករអន្តរជាតិ (International Labour Day)',
    '05-14': 'ព្រះរាជពិធីបុណ្យចម្រើនព្រះជន្ម ព្រះបាទសម្តេចព្រះ នរោត្តម សីហមុនី',
    // Visakha Bochea - lunar, not fixed date

    // June
    '06-18':
        'ព្រះរាជពិធីបុណ្យចម្រើនព្រះជន្ម សម្តេចព្រះមហាក្សត្រី នរោត្តម មុនិនាថ សីហនុ',

    // August
    '08-24': 'ទិវាធម្មនុញ្ញ (Constitutional Day)',

    // September
    '09-24': 'ទិវារដ្ឋធម្មនុញ្ញ (Constitution Day)',

    // October
    '10-23': 'ទិវាសន្តិភាពកម្ពុជា (Paris Peace Agreement Day)',
    '10-29': 'ព្រះរាជពិធីគ្រងរាជ្យ (Coronation Day)',
    // Pchum Ben - lunar, not fixed date

    // November
    '11-09': 'ទិវាឯករាជ្យជាតិ (National Independence Day)',
    // Water Festival (Bon Om Touk) - lunar, not fixed date
  };

  static bool isHoliday(DateTime date) {
    final key =
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.day.toString().padLeft(2, '0')}';
    return fixed.containsKey(key);
  }

  static String? getHolidayName(DateTime date) {
    final key =
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.day.toString().padLeft(2, '0')}';
    return fixed[key];
  }
}
