class Module {
  Module(
      {this.id,
      required this.name,
      required this.grade,
      required this.credits,
      required this.workload,
      required this.difficulty,
      required this.ays,
      required this.su,
      required this.done});

  final String? id;
  final String name;
  final double grade;
  final int credits;
  final int workload;
  final int difficulty;
  final Map ays;
  bool su;
  bool done;

  // Module toggleDone() {
  //   if (this.done) {
  //     return new Module(
  //         name: this.name,
  //         grade: this.grade,
  //         credits: this.credits,
  //         workload: this.workload,
  //         difficulty: this.difficulty,
  //         ays: this.ays,
  //         done: false);
  //   } else {
  //     return new Module(
  //         name: this.name,
  //         grade: this.grade,
  //         credits: this.credits,
  //         workload: this.workload,
  //         difficulty: this.difficulty,
  //         ays: this.ays,
  //         done: true);
  //   }
  // }

  bool isDone() {
    return this.done;
  }

  @override
  String toString() {
    return 'Module{id: $id, name: $name, grade: $grade, credits: $credits,'
        ' workload: $workload, difficulty: $difficulty, done: $done, su: $su}';
  }
}
