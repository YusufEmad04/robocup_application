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


/** This is an auto generated class representing the LineTrackingRound type in your schema. */
class LineTrackingRound extends amplify_core.Model {
  static const classType = const _LineTrackingRoundModelType();
  final String id;
  final int? _number;
  final String? _linetrackingteamID;
  final LineTrackingMap? _lineTrackingMap;
  final int? _score;
  final bool? _hidden;
  final TotalScore? _scoreDetails;
  final Category? _category;
  final int? _time;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;
  final String? _lineTrackingRoundLineTrackingMapId;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  LineTrackingRoundModelIdentifier get modelIdentifier {
      return LineTrackingRoundModelIdentifier(
        id: id
      );
  }
  
  int get number {
    try {
      return _number!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get linetrackingteamID {
    try {
      return _linetrackingteamID!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  LineTrackingMap get lineTrackingMap {
    try {
      return _lineTrackingMap!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  int? get score {
    return _score;
  }
  
  bool? get hidden {
    return _hidden;
  }
  
  TotalScore? get scoreDetails {
    return _scoreDetails;
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
  
  int? get time {
    return _time;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  String get lineTrackingRoundLineTrackingMapId {
    try {
      return _lineTrackingRoundLineTrackingMapId!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  const LineTrackingRound._internal({required this.id, required number, required linetrackingteamID, required lineTrackingMap, score, hidden, scoreDetails, required category, time, createdAt, updatedAt, required lineTrackingRoundLineTrackingMapId}): _number = number, _linetrackingteamID = linetrackingteamID, _lineTrackingMap = lineTrackingMap, _score = score, _hidden = hidden, _scoreDetails = scoreDetails, _category = category, _time = time, _createdAt = createdAt, _updatedAt = updatedAt, _lineTrackingRoundLineTrackingMapId = lineTrackingRoundLineTrackingMapId;
  
  factory LineTrackingRound({String? id, required int number, required String linetrackingteamID, required LineTrackingMap lineTrackingMap, int? score, bool? hidden, TotalScore? scoreDetails, required Category category, int? time, required String lineTrackingRoundLineTrackingMapId}) {
    return LineTrackingRound._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      number: number,
      linetrackingteamID: linetrackingteamID,
      lineTrackingMap: lineTrackingMap,
      score: score,
      hidden: hidden,
      scoreDetails: scoreDetails,
      category: category,
      time: time,
      lineTrackingRoundLineTrackingMapId: lineTrackingRoundLineTrackingMapId);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LineTrackingRound &&
      id == other.id &&
      _number == other._number &&
      _linetrackingteamID == other._linetrackingteamID &&
      _lineTrackingMap == other._lineTrackingMap &&
      _score == other._score &&
      _hidden == other._hidden &&
      _scoreDetails == other._scoreDetails &&
      _category == other._category &&
      _time == other._time &&
      _lineTrackingRoundLineTrackingMapId == other._lineTrackingRoundLineTrackingMapId;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("LineTrackingRound {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("number=" + (_number != null ? _number!.toString() : "null") + ", ");
    buffer.write("linetrackingteamID=" + "$_linetrackingteamID" + ", ");
    buffer.write("score=" + (_score != null ? _score!.toString() : "null") + ", ");
    buffer.write("hidden=" + (_hidden != null ? _hidden!.toString() : "null") + ", ");
    buffer.write("scoreDetails=" + (_scoreDetails != null ? _scoreDetails!.toString() : "null") + ", ");
    buffer.write("category=" + (_category != null ? amplify_core.enumToString(_category)! : "null") + ", ");
    buffer.write("time=" + (_time != null ? _time!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null") + ", ");
    buffer.write("lineTrackingRoundLineTrackingMapId=" + "$_lineTrackingRoundLineTrackingMapId");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  LineTrackingRound copyWith({int? number, String? linetrackingteamID, LineTrackingMap? lineTrackingMap, int? score, bool? hidden, TotalScore? scoreDetails, Category? category, int? time, String? lineTrackingRoundLineTrackingMapId}) {
    return LineTrackingRound._internal(
      id: id,
      number: number ?? this.number,
      linetrackingteamID: linetrackingteamID ?? this.linetrackingteamID,
      lineTrackingMap: lineTrackingMap ?? this.lineTrackingMap,
      score: score ?? this.score,
      hidden: hidden ?? this.hidden,
      scoreDetails: scoreDetails ?? this.scoreDetails,
      category: category ?? this.category,
      time: time ?? this.time,
      lineTrackingRoundLineTrackingMapId: lineTrackingRoundLineTrackingMapId ?? this.lineTrackingRoundLineTrackingMapId);
  }
  
  LineTrackingRound copyWithModelFieldValues({
    ModelFieldValue<int>? number,
    ModelFieldValue<String>? linetrackingteamID,
    ModelFieldValue<LineTrackingMap>? lineTrackingMap,
    ModelFieldValue<int?>? score,
    ModelFieldValue<bool?>? hidden,
    ModelFieldValue<TotalScore?>? scoreDetails,
    ModelFieldValue<Category>? category,
    ModelFieldValue<int?>? time,
    ModelFieldValue<String>? lineTrackingRoundLineTrackingMapId
  }) {
    return LineTrackingRound._internal(
      id: id,
      number: number == null ? this.number : number.value,
      linetrackingteamID: linetrackingteamID == null ? this.linetrackingteamID : linetrackingteamID.value,
      lineTrackingMap: lineTrackingMap == null ? this.lineTrackingMap : lineTrackingMap.value,
      score: score == null ? this.score : score.value,
      hidden: hidden == null ? this.hidden : hidden.value,
      scoreDetails: scoreDetails == null ? this.scoreDetails : scoreDetails.value,
      category: category == null ? this.category : category.value,
      time: time == null ? this.time : time.value,
      lineTrackingRoundLineTrackingMapId: lineTrackingRoundLineTrackingMapId == null ? this.lineTrackingRoundLineTrackingMapId : lineTrackingRoundLineTrackingMapId.value
    );
  }
  
  LineTrackingRound.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _number = (json['number'] as num?)?.toInt(),
      _linetrackingteamID = json['linetrackingteamID'],
      _lineTrackingMap = json['lineTrackingMap']?['serializedData'] != null
        ? LineTrackingMap.fromJson(new Map<String, dynamic>.from(json['lineTrackingMap']['serializedData']))
        : null,
      _score = (json['score'] as num?)?.toInt(),
      _hidden = json['hidden'],
      _scoreDetails = json['scoreDetails']?['serializedData'] != null
        ? TotalScore.fromJson(new Map<String, dynamic>.from(json['scoreDetails']['serializedData']))
        : null,
      _category = amplify_core.enumFromString<Category>(json['category'], Category.values),
      _time = (json['time'] as num?)?.toInt(),
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null,
      _lineTrackingRoundLineTrackingMapId = json['lineTrackingRoundLineTrackingMapId'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'number': _number, 'linetrackingteamID': _linetrackingteamID, 'lineTrackingMap': _lineTrackingMap?.toJson(), 'score': _score, 'hidden': _hidden, 'scoreDetails': _scoreDetails?.toJson(), 'category': amplify_core.enumToString(_category), 'time': _time, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format(), 'lineTrackingRoundLineTrackingMapId': _lineTrackingRoundLineTrackingMapId
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'number': _number,
    'linetrackingteamID': _linetrackingteamID,
    'lineTrackingMap': _lineTrackingMap,
    'score': _score,
    'hidden': _hidden,
    'scoreDetails': _scoreDetails,
    'category': _category,
    'time': _time,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt,
    'lineTrackingRoundLineTrackingMapId': _lineTrackingRoundLineTrackingMapId
  };

  static final amplify_core.QueryModelIdentifier<LineTrackingRoundModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<LineTrackingRoundModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final NUMBER = amplify_core.QueryField(fieldName: "number");
  static final LINETRACKINGTEAMID = amplify_core.QueryField(fieldName: "linetrackingteamID");
  static final LINETRACKINGMAP = amplify_core.QueryField(
    fieldName: "lineTrackingMap",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'LineTrackingMap'));
  static final SCORE = amplify_core.QueryField(fieldName: "score");
  static final HIDDEN = amplify_core.QueryField(fieldName: "hidden");
  static final SCOREDETAILS = amplify_core.QueryField(fieldName: "scoreDetails");
  static final CATEGORY = amplify_core.QueryField(fieldName: "category");
  static final TIME = amplify_core.QueryField(fieldName: "time");
  static final LINETRACKINGROUNDLINETRACKINGMAPID = amplify_core.QueryField(fieldName: "lineTrackingRoundLineTrackingMapId");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "LineTrackingRound";
    modelSchemaDefinition.pluralName = "LineTrackingRounds";
    
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
    
    modelSchemaDefinition.indexes = [
      amplify_core.ModelIndex(fields: const ["linetrackingteamID"], name: "byLineTrackingTeam")
    ];
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: LineTrackingRound.NUMBER,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: LineTrackingRound.LINETRACKINGTEAMID,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasOne(
      key: LineTrackingRound.LINETRACKINGMAP,
      isRequired: true,
      ofModelName: 'LineTrackingMap',
      associatedKey: LineTrackingMap.ID
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: LineTrackingRound.SCORE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: LineTrackingRound.HIDDEN,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.embedded(
      fieldName: 'scoreDetails',
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.embedded, ofCustomTypeName: 'TotalScore')
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: LineTrackingRound.CATEGORY,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.enumeration)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: LineTrackingRound.TIME,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
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
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: LineTrackingRound.LINETRACKINGROUNDLINETRACKINGMAPID,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
  });
}

class _LineTrackingRoundModelType extends amplify_core.ModelType<LineTrackingRound> {
  const _LineTrackingRoundModelType();
  
  @override
  LineTrackingRound fromJson(Map<String, dynamic> jsonData) {
    return LineTrackingRound.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'LineTrackingRound';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [LineTrackingRound] in your schema.
 */
class LineTrackingRoundModelIdentifier implements amplify_core.ModelIdentifier<LineTrackingRound> {
  final String id;

  /** Create an instance of LineTrackingRoundModelIdentifier using [id] the primary key. */
  const LineTrackingRoundModelIdentifier({
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
  String toString() => 'LineTrackingRoundModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is LineTrackingRoundModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}