class GovernorateModel {
  const GovernorateModel(this.id, this.name);
  final int id;
  final String name;
}

const List<GovernorateModel> egyptGovernoratesList = [
  GovernorateModel(1, 'القاهرة'),
  GovernorateModel(2, 'الجيزة'),
  GovernorateModel(3, 'الإسكندرية'),
  GovernorateModel(4, 'الدقهلية'),
  GovernorateModel(5, 'البحر الأحمر'),
  GovernorateModel(6, 'البحيرة'),
  GovernorateModel(7, 'الفيوم'),
  GovernorateModel(8, 'الغربية'),
  GovernorateModel(9, 'الإسماعيلية'),
  GovernorateModel(10, 'المنوفية'),
  GovernorateModel(11, 'المنيا'),
  GovernorateModel(12, 'القليوبية'),
  GovernorateModel(13, 'الوادي الجديد'),
  GovernorateModel(14, 'السويس'),
  GovernorateModel(15, 'اسوان'),
  GovernorateModel(16, 'اسيوط'),
  GovernorateModel(17, 'بني سويف'),
  GovernorateModel(18, 'بورسعيد'),
  GovernorateModel(19, 'دمياط'),
  GovernorateModel(20, 'الشرقية'),
  GovernorateModel(21, 'جنوب سيناء'),
  GovernorateModel(22, 'كفر الشيخ'),
  GovernorateModel(23, 'مطروح'),
  GovernorateModel(24, 'الأقصر'),
  GovernorateModel(25, 'قنا'),
  GovernorateModel(26, 'شمال سيناء'),
  GovernorateModel(27, 'سوهاج'),
];

int? getGovernorateIdByName(String name) {
  try {
    return egyptGovernoratesList.firstWhere((e) => e.name == name).id;
  } on Object catch (_) {
    return null;
  }
}
