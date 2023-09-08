class StudentParameters {
  final int? sectionID;
  final int classYearID;
  final int pageNumber;
  final int pageSize;
  StudentParameters(
      {this.sectionID,
      required this.classYearID,
      required this.pageNumber,
      required this.pageSize});
}
