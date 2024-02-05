/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart' as amplify_core;
import 'package:collection/collection.dart';


/** This is an auto generated class representing the LineTrackingTeam type in your schema. */
class LineTrackingTeam extends amplify_core.Model {
  static const classType = const _LineTrackingTeamModelType();
  final String id;
  final String? _name;
  final List<LineTrackingRound>? _lineTrackingRounds;
  final String? _robocupID;
  final Category? _category;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  LineTrackingTeamModelIdentifier get modelIdentifier {
      return LineTrackingTeamModelIdentifier(
        id: id
      );
  }
  
  String get name {
    try {
      return _name!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  List<LineTrackingRound>? get lineTrackingRounds {
    return _lineTrackingRounds;
  }
  
  String? get robocupID {
    return _robocupID;
  }
  
  Category get category {
    try {
      return _category!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const LineTrackingTeam._internal({required this.id, required name, lineTrackingRounds, robocupID, required category, createdAt, updatedAt}): _name = name, _lineTrackingRounds = lineTrackingRounds, _robocupID = robocupID, _category = category, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory LineTrackingTeam({String? id, required String name, List<LineTrackingRound>? lineTrackingRounds, String? robocupID, required Category category}) {
    return LineTrackingTeam._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      name: name,
      lineTrackingRounds: lineTrackingRounds != null ? List<LineTrackingRound>.unmodifiable(lineTrackingRounds) : lineTrackingRounds,
      robocupID: robocupID,
      category: category);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LineTrackingTeam &&
      id == other.id &&
      _name == other._name &&
      DeepCollectionEquality().equals(_lineTrackingRounds, other._lineTrackingRounds) &&
      _robocupID == other._robocupID &&
      _category == other._category;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("LineTrackingTeam {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("robocupID=" + "$_robocupID" + ", ");
    buffer.write("category=" + (_category != null ? amplify_core.enumToString(_category)! : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  LineTrackingTeam copyWith({String? name, List<LineTrackingRound>? lineTrackingRounds, String? robocupID, Category? category}) {
    return LineTrackingTeam._internal(
      id: id,
      name: name ?? this.name,
      lineTrackingRounds: lineTrackingRounds ?? this.lineTrackingRounds,
      robocupID: robocupID ?? this.robocupID,
      category: category ?? this.category);
  }
  
  LineTrackingTeam copyWithModelFieldValues({
    ModelFieldValue<String>? name,
    ModelFieldValue<List<LineTrackingRound>?>? lineTrackingRounds,
    ModelFieldValue<String?>? robocupID,
    ModelFieldValue<Category>? category
  }) {
    return LineTrackingTeam._internal(
      id: id,
      name: name == null ? this.name : name.value,
      lineTrackingRounds: lineTrackingRounds == null ? this.lineTrackingRounds : lineTrackingRounds.value,
      robocupID: robocupID == null ? this.robocupID : robocupID.value,
      category: category == null ? this.category : category.value
    );
  }
  
  LineTrackingTeam.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _lineTrackingRounds = json['lineTrackingRounds'] is List
        ? (json['lineTrackingRounds'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => LineTrackingRound.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _robocupID = json['robocupID'],
      _category = amplify_core.enumFromString<Category>(json['category'], Category.values),
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'lineTrackingRounds': _lineTrackingRounds?.map((LineTrackingRound? e) => e?.toJson()).toList(), 'robocupID': _robocupID, 'category': amplify_core.enumToString(_category), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'name': _name,
    'lineTrackingRounds': _lineTrackingRounds,
    'robocupID': _robocupID,
    'category': _category,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<LineTrackingTeamModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<LineTrackingTeamModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final NAME = amplify_core.QueryField(fieldName: "name");
  static final LINETRACKINGROUNDS = amplify_core.QueryField(
    fieldName: "lineTrackingRounds",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'LineTrackingRound'));
  static final ROBOCUPID = amplify_core.QueryField(fieldName: "robocupID");
  static final CATEGORY = amplify_core.QueryField(fieldName: "category");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "LineTrackingTeam";
    modelSchemaDefinition.pluralName = "LineTrackingTeams";
    
    modelSchemaDefinition.authRules = [
      amplify_core.AuthRule(
        authStrategy: amplify_core.AuthStrategy.PRIVATE,
        operations: const [
          amplify_core.ModelOperation.CREATE,
          amplify_core.ModelOperation.UPDATE,
          amplify_core.ModelOperation.DELETE,
          amplify_core.ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: LineTrackingTeam.NAME,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: LineTrackingTeam.LINETRACKINGROUNDS,
      isRequired: false,
      ofModelName: 'LineTrackingRound',
      associatedKey: LineTrackingRound.LINETRACKINGTEAMID
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: LineTrackingTeam.ROBOCUPID,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: LineTrackingTeam.CATEGORY,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.enumeration)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _LineTrackingTeamModelType extends amplify_core.ModelType<LineTrackingTeam> {
  const _LineTrackingTeamModelType();
  
  @override
  LineTrackingTeam fromJson(Map<String, dynamic> jsonData) {
    return LineTrackingTeam.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'LineTrackingTeam';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [LineTrackingTeam] in your schema.
 */
class LineTrackingTeamModelIdentifier implements amplify_core.ModelIdentifier<LineTrackingTeam> {
  final String id;

  /** Create an instance of LineTrackingTeamModelIdentifier using [id] the primary key. */
  const LineTrackingTeamModelIdentifier({
    required this.id});
  
  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{
    'id': id
  });
  
  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
    .entries
    .map((entry) => (<String, dynamic>{ entry.key: entry.value }))
    .toList();
  
  @override
  String serializeAsString() => serializeAsMap().values.join('#');
  
  @override
  String toString() => 'LineTrackingTeamModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is LineTrackingTeamModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}