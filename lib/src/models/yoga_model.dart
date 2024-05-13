class YogaCourse {
  String courseId;
  String courseName;
  String gender;
  String courseImage;
  String bodyShape;
  List<Level> levels;
  double progress;

  YogaCourse({
    required this.courseId,
    required this.courseName,
    required this.gender,
    required this.bodyShape,
    required this.courseImage,
    required this.levels,
    this.progress = 0.0,
  });

// void calculateCompletionPercentage() {
//   int totalLevels = levels.length;
//   int completedLevels =
//       levels.where((level) => level.progress == 100.0).length;
//   completionPercentage = (completedLevels / totalLevels) * 100;
// }
}

class Level {
  String levelName;
  String levelImage; // Added field for level image URL
  List<Day> days;
  double progress;

  Level({
    required this.levelName,
    required this.levelImage,
    required this.days,
    this.progress = 0.0,
  });
}

class Day {
  String dayName;
  List<Video> videos;
  double progress;

  Day({
    required this.dayName,
    required this.videos,
    this.progress = 0.0,
  });
}

class Video {
  String videoId;
  String videoUrl;
  double progress;

  Video({
    required this.videoId,
    required this.videoUrl,
    this.progress = 0.0,
  });
}
