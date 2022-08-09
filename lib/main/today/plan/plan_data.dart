class Plan_Data {
  // تحديد نوع المحتوى
  static String plan_type_data(int type) {
    if (type == 1) {
      return "كتاب";
    } else if (type == 2) {
      return "بحث";
    } else if (type == 3) {
      return "مقال";
    } else if (type == 4) {
      return "اختصار كتاب";
    } else {
      return "اخرى";
    }
  }

  // تحديد الحالة
  static String plan_done_data(int done) {
    if (done == 0) {
      return "قيد الانجاز";
    } else {
      return "تم الانجاز";
    }
  }
}
