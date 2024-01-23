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


/** This is an auto generated class representing the LineTrackingMap type in your schema. */
class LineTrackingMap extends amplify_core.Model {
  static const classType = const _LineTrackingMapModelType();
  final String id;
  final int? _day;
  final List<CheckPoint>? _checkpoints;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  LineTrackingMapModelIdentifier get modelIdentifier {
      return LineTrackingMapModelIdentifier(
        id: id
      );
  }
  
  int get day {
    try {
      return _day!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  List<CheckPoint>? get checkpoints {
    return _checkpoints;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const LineTrackingMap._internal({required this.id, required day, checkpoints, createdAt, updatedAt}): _day = day, _checkpoints = checkpoints, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory LineTrackingMap({String? id, required int day, List<CheckPoint>? checkpoints}) {
    return LineTrackingMap._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      day: day,
      checkpoints: checkpoints != null ? List<CheckPoint>.unmodifiable(checkpoints) : checkpoints);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LineTrackingMap &&
      id == other.id &&
      _day == other._day &&
      DeepCollectionEquality().equals(_checkpoints, other._checkpoints);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("LineTrackingMap {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("day=" + (_day != null ? _day!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  LineTrackingMap copyWith({int? day, List<CheckPoint>? checkpoints}) {
    return LineTrackingMap._internal(
      id: id,
      day: day ?? this.day,
      checkpoints: checkpoints ?? this.checkpoints);
  }
  
  LineTrackingMap copyWithModelFieldValues({
    ModelFieldValue<int>? day,
    ModelFieldValue<List<CheckPoint>?>? checkpoints
  }) {
    return LineTrackingMap._internal(
      id: id,
      day: day == null ? this.day : day.value,
      checkpoints: checkpoints == null ? this.checkpoints : checkpoints.value
    );
  }
  
  LineTrackingMap.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _day = (json['day'] as num?)?.toInt(),
      _checkpoints = json['checkpoints'] is List
        ? (json['checkpoints'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => CheckPoint.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'day': _day, 'checkpoints': _checkpoints?.map((CheckPoint? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'day': _day,
    'checkpoints': _checkpoints,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<LineTrackingMapModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<LineTrackingMapModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final DAY = amplify_core.QueryField(fieldName: "day");
  static final CHECKPOINTS = amplify_core.QueryField(
    fieldName: "checkpoints",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'CheckPoint'));
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "LineTrackingMap";
    modelSchemaDefinition.pluralName = "LineTrackingMaps";
    
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
      key: LineTrackingMap.DAY,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: LineTrackingMap.CHECKPOINTS,
      isRequired: false,
      ofModelName: 'CheckPoint',
      associatedKey: CheckPoint.LINETRACKINGMAPID
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

class _LineTrackingMapModelType extends amplify_core.ModelType<LineTrackingMap> {
  const _LineTrackingMapModelType();
  
  @override
  LineTrackingMap fromJson(Map<String, dynamic> jsonData) {
    return LineTrackingMap.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'LineTrackingMap';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [LineTrackingMap] in your schema.
 */
class LineTrackingMapModelIdentifier implements amplify_core.ModelIdentifier<LineTrackingMap> {
  final String id;

  /** Create an instance of LineTrackingMapModelIdentifier using [id] the primary key. */
  const LineTrackingMapModelIdentifier({
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
  String toString() => 'LineTrackingMapModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is LineTrackingMapModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}