// Cambodian public holidays (month, day) - fixed annual holidays
// Plus dynamic ones computed separately
class KhmerHolidays {
  static const Map<String, String> fixed = {
    '01-01': 'ទិវាចូលឆ្នាំសកល (International New Year)',
    '01-07': 'ទិវាជ័យជម្នះលើរបបប្រល័យពូជសាសន៍ (Victory Day)',
    '03-08': 'ទិវានារីអន្តរជាតិ (International Women\'s Day)',
    '04-13': 'ពិធីបុណ្យចូលឆ្នាំខ្មែរ - មហាសង្ក្រាន្ត (Khmer New Year Day 1)',
    '04-14': 'ពិធីបុណ្យចូលឆ្នាំខ្មែរ - វ័នបត (Khmer New Year Day 2)',
    '04-15': 'ពិធីបុណ្យចូលឆ្នាំខ្មែរ - ឡើងស័ក (Khmer New Year Day 3)',
    '04-16': 'ថ្ងៃបន្ថែម (Khmer New Year Extra Day)',
    '05-01': 'ទិវាពលករអន្តរជាតិ (International Labour Day)',
    '05-14': 'ព្រះរាជពិធីបុណ្យចម្រើនព្រះជន្ម (Royal Birthday)',
    '06-01': 'ទិវាការពារកុមារអន្តរជាតិ (International Children\'s Day)',
    '06-18': 'ថ្ងៃគោរពព្រះមាតា (Queen Mother\'s Birthday)',
    '06-19': 'ស្ដេចថ្ងៃបង (Father\'s Day)',
    '06-21': 'ទិវាឪពុក (Father\'s Day International)',
    '08-24': 'ទិវាធម្មនុញ្ញ (Constitutional Day)',
    '09-24': 'ទិវារដ្ឋធម្មនុញ្ញ (Constitution Day)',
    '10-23': 'ទិវាសន្តិភាព (Paris Peace Agreement Day)',
    '10-29': 'ព្រះរាជពិធីគ្រងរាជ្យ (Coronation Day)',
    '11-09': 'ទិវាឯករាជ្យ (Independence Day)',
    '11-15': 'បុណ្យអុំទូក (Water Festival / Bon Om Touk)',
    '12-10': 'ទិវាសិទ្ធិមនុស្ស (Human Rights Day)',
  };

  static bool isHoliday(DateTime date) {
    final key =
        '${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    return fixed.containsKey(key);
  }

  static String? getHolidayName(DateTime date) {
    final key =
        '${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    return fixed[key];
  }
}
