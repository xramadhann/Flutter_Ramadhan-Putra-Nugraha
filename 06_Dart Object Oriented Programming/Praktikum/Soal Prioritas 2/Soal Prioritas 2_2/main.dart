import 'course.dart';
import 'student.dart';

void main() {
  final course1 = Course("Flutter", "Introduction Flutter and Flutter widget");
  final course2 = Course("React", "React Fundamental");
  final course3 = Course("Golang", "Problem Solving Paradigm");

  final student1 = Student("Ramadhan", "Kelas A");
  final student2 = Student("Putra", "Kelas B");
  final student3 = Student("Nugraha", "Kelas c");

  student1.addCourse(course1);
  student1.addCourse(course3);
  student2.addCourse(course1);
  student2.addCourse(course2);
  student3.addCourse(course1);
  student3.addCourse(course2);
  student3.addCourse(course3);

  print("\nDaftar course saat ini:");
  student1.viewCourses();
  student2.viewCourses();
  student3.viewCourses();

  print("\nCourse yang dihapus:");
  student1.removeCourse(course1);
  student3.removeCourse(course2);
  student3.removeCourse(course3);

  print("\nDaftar course setelah penghapusan:");
  student1.viewCourses();
  student2.viewCourses();
  student3.viewCourses();
}
