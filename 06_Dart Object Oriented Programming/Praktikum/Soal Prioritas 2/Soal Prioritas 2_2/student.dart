import 'course.dart';

class Student {
  String name;
  String className;
  List<Course> courses = [];

  Student(this.name, this.className);

  void addCourse(Course course) {
    courses.add(course);
    print("Course '${course.title}' ditambahkan untuk '$name'");
  }

  void removeCourse(Course course) {
    courses.remove(course);
    print("Course '${course.title}' dihapus dari daftar '$name'");
  }

  void viewCourses() {
    if (courses.isEmpty) {
      print("$name tidak memiliki course saat ini.");
    } else {
      print("Daftar course milik '$name'");
      for (var course in courses) {
        print("- ${course.title}: ${course.description}");
      }
    }
  }
}
