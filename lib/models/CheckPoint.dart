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


/** This is an auto generated class representing the CheckPoint type in your schema. */
class CheckPoint extends amplify_core.Model {
  static const classType = const _CheckPointModelType();
  final String id;
  final String? _linetrackingmapID;
  final int? _tiles;
  final int? _gaps;
  final int? _obstacles;
  final int? _intersections;
  final int? _ramps;
  final int? _speedBumps;
  final int? _seesaws;
  final int? _number;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  CheckPointModelIdentifier get modelIdentifier {
      return CheckPointModelIdentifier(
        id: id
      );
  }
  
  String get linetrackingmapID {
    try {
      return _linetrackingmapID!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  int get tiles {
    try {
      return _tiles!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  int? get gaps {
    return _gaps;
  }
  
  int? get obstacles {
    return _obstacles;
  }
  
  int? get intersections {
    return _intersections;
  }
  
  int? get ramps {
    return _ramps;
  }
  
  int get speedBumps {
    try {
      return _speedBumps!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  int? get seesaws {
    return _seesaws;
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
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const CheckPoint._internal({required this.id, required linetrackingmapID, required tiles, gaps, obstacles, intersections, ramps, required speedBumps, seesaws, required number, createdAt, updatedAt}): _linetrackingmapID = linetrackingmapID, _tiles = tiles, _gaps = gaps, _obstacles = obstacles, _intersections = intersections, _ramps = ramps, _speedBumps = speedBumps, _seesaws = seesaws, _number = number, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory CheckPoint({String? id, required String linetrackingmapID, required int tiles, int? gaps, int? obstacles, int? intersections, int? ramps, required int speedBumps, int? seesaws, required int number}) {
    return CheckPoint._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      linetrackingmapID: linetrackingmapID,
      tiles: tiles,
      gaps: gaps,
      obstacles: obstacles,
      intersections: intersections,
      ramps: ramps,
      speedBumps: speedBumps,
      seesaws: seesaws,
      number: number);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CheckPoint &&
      id == other.id &&
      _linetrackingmapID == other._linetrackingmapID &&
      _tiles == other._tiles &&
      _gaps == other._gaps &&
      _obstacles == other._obstacles &&
      _intersections == other._intersections &&
      _ramps == other._ramps &&
      _speedBumps == other._speedBumps &&
      _seesaws == other._seesaws &&
      _number == other._number;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("CheckPoint {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("linetrackingmapID=" + "$_linetrackingmapID" + ", ");
    buffer.write("tiles=" + (_tiles != null ? _tiles!.toString() : "null") + ", ");
    buffer.write("gaps=" + (_gaps != null ? _gaps!.toString() : "null") + ", ");
    buffer.write("obstacles=" + (_obstacles != null ? _obstacles!.toString() : "null") + ", ");
    buffer.write("intersections=" + (_intersections != null ? _intersections!.toString() : "null") + ", ");
    buffer.write("ramps=" + (_ramps != null ? _ramps!.toString() : "null") + ", ");
    buffer.write("speedBumps=" + (_speedBumps != null ? _speedBumps!.toString() : "null") + ", ");
    buffer.write("seesaws=" + (_seesaws != null ? _seesaws!.toString() : "null") + ", ");
    buffer.write("number=" + (_number != null ? _number!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  CheckPoint copyWith({String? linetrackingmapID, int? tiles, int? gaps, int? obstacles, int? intersections, int? ramps, int? speedBumps, int? seesaws, int? number}) {
    return CheckPoint._internal(
      id: id,
      linetrackingmapID: linetrackingmapID ?? this.linetrackingmapID,
      tiles: tiles ?? this.tiles,
      gaps: gaps ?? this.gaps,
      obstacles: obstacles ?? this.obstacles,
      intersections: intersections ?? this.intersections,
      ramps: ramps ?? this.ramps,
      speedBumps: speedBumps ?? this.speedBumps,
      seesaws: seesaws ?? this.seesaws,
      number: number ?? this.number);
  }
  
  CheckPoint copyWithModelFieldValues({
    ModelFieldValue<String>? linetrackingmapID,
    ModelFieldValue<int>? tiles,
    ModelFieldValue<int?>? gaps,
    ModelFieldValue<int?>? obstacles,
    ModelFieldValue<int?>? intersections,
    ModelFieldValue<int?>? ramps,
    ModelFieldValue<int>? speedBumps,
    ModelFieldValue<int?>? seesaws,
    ModelFieldValue<int>? number
  }) {
    return CheckPoint._internal(
      id: id,
      linetrackingmapID: linetrackingmapID == null ? this.linetrackingmapID : linetrackingmapID.value,
      tiles: tiles == null ? this.tiles : tiles.value,
      gaps: gaps == null ? this.gaps : gaps.value,
      obstacles: obstacles == null ? this.obstacles : obstacles.value,
      intersections: intersections == null ? this.intersections : intersections.value,
      ramps: ramps == null ? this.ramps : ramps.value,
      speedBumps: speedBumps == null ? this.speedBumps : speedBumps.value,
      seesaws: seesaws == null ? this.seesaws : seesaws.value,
      number: number == null ? this.number : number.value
    );
  }
  
  CheckPoint.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _linetrackingmapID = json['linetrackingmapID'],
      _tiles = (json['tiles'] as num?)?.toInt(),
      _gaps = (json['gaps'] as num?)?.toInt(),
      _obstacles = (json['obstacles'] as num?)?.toInt(),
      _intersections = (json['intersections'] as num?)?.toInt(),
      _ramps = (json['ramps'] as num?)?.toInt(),
      _speedBumps = (json['speedBumps'] as num?)?.toInt(),
      _seesaws = (json['seesaws'] as num?)?.toInt(),
      _number = (json['number'] as num?)?.toInt(),
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'linetrackingmapID': _linetrackingmapID, 'tiles': _tiles, 'gaps': _gaps, 'obstacles': _obstacles, 'intersections': _intersections, 'ramps': _ramps, 'speedBumps': _speedBumps, 'seesaws': _seesaws, 'number': _number, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'linetrackingmapID': _linetrackingmapID,
    'tiles': _tiles,
    'gaps': _gaps,
    'obstacles': _obstacles,
    'intersections': _intersections,
    'ramps': _ramps,
    'speedBumps': _speedBumps,
    'seesaws': _seesaws,
    'number': _number,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<CheckPointModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<CheckPointModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final LINETRACKINGMAPID = amplify_core.QueryField(fieldName: "linetrackingmapID");
  static final TILES = amplify_core.QueryField(fieldName: "tiles");
  static final GAPS = amplify_core.QueryField(fieldName: "gaps");
  static final OBSTACLES = amplify_core.QueryField(fieldName: "obstacles");
  static final INTERSECTIONS = amplify_core.QueryField(fieldName: "intersections");
  static final RAMPS = amplify_core.QueryField(fieldName: "ramps");
  static final SPEEDBUMPS = amplify_core.QueryField(fieldName: "speedBumps");
  static final SEESAWS = amplify_core.QueryField(fieldName: "seesaws");
  static final NUMBER = amplify_core.QueryField(fieldName: "number");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "CheckPoint";
    modelSchemaDefinition.pluralName = "CheckPoints";
    
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
      amplify_core.ModelIndex(fields: const ["linetrackingmapID"], name: "byLineTrackingMap")
    ];
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: CheckPoint.LINETRACKINGMAPID,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: CheckPoint.TILES,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: CheckPoint.GAPS,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: CheckPoint.OBSTACLES,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: CheckPoint.INTERSECTIONS,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: CheckPoint.RAMPS,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: CheckPoint.SPEEDBUMPS,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: CheckPoint.SEESAWS,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: CheckPoint.NUMBER,
      isRequired: true,
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
  });
}

class _CheckPointModelType extends amplify_core.ModelType<CheckPoint> {
  const _CheckPointModelType();
  
  @override
  CheckPoint fromJson(Map<String, dynamic> jsonData) {
    return CheckPoint.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'CheckPoint';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [CheckPoint] in your schema.
 */
class CheckPointModelIdentifier implements amplify_core.ModelIdentifier<CheckPoint> {
  final String id;

  /** Create an instance of CheckPointModelIdentifier using [id] the primary key. */
  const CheckPointModelIdentifier({
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
  String toString() => 'CheckPointModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is CheckPointModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}