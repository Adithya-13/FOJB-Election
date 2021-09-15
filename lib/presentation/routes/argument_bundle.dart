class ArgumentBundle {

  final int id;
  final dynamic extras;
  final String identifier;

  ArgumentBundle({
    int? id,
    dynamic? extras,
    String? identifier,
  })  : id = id ?? 0,
        extras = extras ?? null,
        identifier = identifier ?? 'unknown';
}

