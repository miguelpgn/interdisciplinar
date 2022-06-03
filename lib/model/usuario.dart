import 'dart:convert';

final String tableUsuario = 'usuario';

class UsuarioFields {
  static final List<String> values = [
    id, name, telefone, senha
  ];

  static final String id = '_id';
  static final String name = '_name';
  static final String telefone = '_telefone';
  static final String senha = '_senha'; //Criptografar
}

class Usuario {
  final int? id;
  final String name;
  final String telefone;
  final String senha;


  const Usuario({
    this.id,
    required this.name,
    required this.telefone,
    required this.senha,
  });

  Usuario copy({
    int? id,
    String? name,
    String? telefone,
    String? senha,
  }) => 
  Usuario(
    id: id ?? this.id,
    name: name ?? this.name,
    telefone: telefone ?? this.telefone,
    senha: senha ?? this.senha);
    
  static Usuario fromJson(Map<String, Object?> json) => Usuario(
    id: json[UsuarioFields.id] as int?,
    name: json[UsuarioFields.name] as String,
    telefone: json[UsuarioFields.telefone] as String,
    senha: json[UsuarioFields.senha] as String,
  );

  Map<String, Object?> toJson() => {
    UsuarioFields.id : id,
    UsuarioFields.name : name,
    UsuarioFields.telefone : telefone,
    UsuarioFields.senha : senha
  };
}