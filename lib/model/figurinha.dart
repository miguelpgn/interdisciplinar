import 'dart:convert';

final String tableFigurinha = 'figurinha';

class FigurinhaFields {
  static final List<String> values = [
    id, name, imagem
  ];

  static final String id = '_id';
  static final String name = '_name';
  static final String imagem = '_imagem';
  static final String username = "_username";
  static final String contato = "_contato";
}

class Figurinha {
  final int? id;
  final String name;
  final String imagem;
  final String username;
  final String contato;


  const Figurinha({
    this.id,
    required this.name,
    required this.imagem,
    required this.username,
    required this.contato
  });

  Figurinha copy({
    int? id,
    String? name,
    String? imagem,
    String? username,
    String? contato
  }) => 
  Figurinha(
    id: id ?? this.id,
    name: name ?? this.name,
    imagem: imagem ?? this.imagem,
    username: username ?? this.username,
    contato: contato ?? this.contato);
    
  static Figurinha fromJson(Map<String, Object?> json) => Figurinha(
    id: json[FigurinhaFields.id] as int?,
    name: json[FigurinhaFields.name] as String,
    imagem: json[FigurinhaFields.imagem] as String,
    username: json[FigurinhaFields.username] as String,
    contato: json[FigurinhaFields.contato] as String,
  );

  Map<String, Object?> toJson() => {
    FigurinhaFields.id : id,
    FigurinhaFields.name : name,
    FigurinhaFields.imagem : imagem,
    FigurinhaFields.username : username,
    FigurinhaFields.contato : contato
  };
}