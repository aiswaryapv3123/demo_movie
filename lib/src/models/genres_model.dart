const String tableGenres = 'genres';

class GenresField {
  static final List<String> values = [
    /// Add all fields
    gid, name
  ];

  static const String gid = '_gid';
  static const String name = 'name';
}

class GenresModel {
  final int? gid;
  final String? name;
  GenresModel({this.gid, this.name});

  GenresModel copy({
    int? gid,
    String? name,
  }) =>
      GenresModel(gid: this.gid, name: this.name);

  static GenresModel fromJson(Map<String, Object?> json) => GenresModel(
        gid: json[GenresField.gid] as int?,
        name: json[GenresField.name] as String?,
      );

  Map<String, Object?> toJson() => {
        GenresField.gid: gid,
        GenresField.name: name,
      };
}
