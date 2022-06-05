class Crime {
  final int title;
  final String location;
  final String time;
  final String description;
  final int imageURL;
  final int report_to;
  final int status;
  final int reporter;

  Crime({ required this.title, required this.location, required this.time, required this.description, required this.imageURL, required this.report_to, required this.status, required this.reporter, });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'location': location,
      'time': time,
      'description': description,
      'imageURL': imageURL,
      'report_to':report_to,
      'status': status,
      'reporter': reporter,
    };
  }

  @override
  String toString() {
    return 'Crime{title: $title, location: $location, time: $time, description: $description,imageURL :$imageURL, report_to: $report_to , status: $status , reporter: $reporter}';
  }

}