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


/** This is an auto generated class representing the CheckPointScore type in your schema. */
class CheckPointScore {
  final int? _checkPointNumber;
  final int? _tilesPassed;
  final int? _totalLOP;
  final int? _gapsPassed;
  final int? _obstaclesPassed;
  final int? _intersectionsPassed;
  final int? _rampsPassed;
  final int? _speedBumpsPassed;
  final int? _seesawsPassed;

  int get checkPointNumber {
    try {
      return _checkPointNumber!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  int get tilesPassed {
    try {
      return _tilesPassed!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  int get totalLOP {
    try {
      return _totalLOP!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  int get gapsPassed {
    try {
      return _gapsPassed!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  int get obstaclesPassed {
    try {
      return _obstaclesPassed!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  int get intersectionsPassed {
    try {
      return _intersectionsPassed!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  int get rampsPassed {
    try {
      return _rampsPassed!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  int get speedBumpsPassed {
    try {
      return _speedBumpsPassed!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  int get seesawsPassed {
    try {
      return _seesawsPassed!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  const CheckPointScore._internal({required checkPointNumber, required tilesPassed, required totalLOP, required gapsPassed, required obstaclesPassed, required intersectionsPassed, required rampsPassed, required speedBumpsPassed, required seesawsPassed}): _checkPointNumber = checkPointNumber, _tilesPassed = tilesPassed, _totalLOP = totalLOP, _gapsPassed = gapsPassed, _obstaclesPassed = obstaclesPassed, _intersectionsPassed = intersectionsPassed, _rampsPassed = rampsPassed, _speedBumpsPassed = speedBumpsPassed, _seesawsPassed = seesawsPassed;
  
  factory CheckPointScore({required int checkPointNumber, required int tilesPassed, required int totalLOP, required int gapsPassed, required int obstaclesPassed, required int intersectionsPassed, required int rampsPassed, required int speedBumpsPassed, required int seesawsPassed}) {
    return CheckPointScore._internal(
      checkPointNumber: checkPointNumber,
      tilesPassed: tilesPassed,
      totalLOP: totalLOP,
      gapsPassed: gapsPassed,
      obstaclesPassed: obstaclesPassed,
      intersectionsPassed: intersectionsPassed,
      rampsPassed: rampsPassed,
      speedBumpsPassed: speedBumpsPassed,
      seesawsPassed: seesawsPassed);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CheckPointScore &&
      _checkPointNumber == other._checkPointNumber &&
      _tilesPassed == other._tilesPassed &&
      _totalLOP == other._totalLOP &&
      _gapsPassed == other._gapsPassed &&
      _obstaclesPassed == other._obstaclesPassed &&
      _intersectionsPassed == other._intersectionsPassed &&
      _rampsPassed == other._rampsPassed &&
      _speedBumpsPassed == other._speedBumpsPassed &&
      _seesawsPassed == other._seesawsPassed;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("CheckPointScore {");
    buffer.write("checkPointNumber=" + (_checkPointNumber != null ? _checkPointNumber!.toString() : "null") + ", ");
    buffer.write("tilesPassed=" + (_tilesPassed != null ? _tilesPassed!.toString() : "null") + ", ");
    buffer.write("totalLOP=" + (_totalLOP != null ? _totalLOP!.toString() : "null") + ", ");
    buffer.write("gapsPassed=" + (_gapsPassed != null ? _gapsPassed!.toString() : "null") + ", ");
    buffer.write("obstaclesPassed=" + (_obstaclesPassed != null ? _obstaclesPassed!.toString() : "null") + ", ");
    buffer.write("intersectionsPassed=" + (_intersectionsPassed != null ? _intersectionsPassed!.toString() : "null") + ", ");
    buffer.write("rampsPassed=" + (_rampsPassed != null ? _rampsPassed!.toString() : "null") + ", ");
    buffer.write("speedBumpsPassed=" + (_speedBumpsPassed != null ? _speedBumpsPassed!.toString() : "null") + ", ");
    buffer.write("seesawsPassed=" + (_seesawsPassed != null ? _seesawsPassed!.toString() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  CheckPointScore copyWith({int? checkPointNumber, int? tilesPassed, int? totalLOP, int? gapsPassed, int? obstaclesPassed, int? intersectionsPassed, int? rampsPassed, int? speedBumpsPassed, int? seesawsPassed}) {
    return CheckPointScore._internal(
      checkPointNumber: checkPointNumber ?? this.checkPointNumber,
      tilesPassed: tilesPassed ?? this.tilesPassed,
      totalLOP: totalLOP ?? this.totalLOP,
      gapsPassed: gapsPassed ?? this.gapsPassed,
      obstaclesPassed: obstaclesPassed ?? this.obstaclesPassed,
      intersectionsPassed: intersectionsPassed ?? this.intersectionsPassed,
      rampsPassed: rampsPassed ?? this.rampsPassed,
      speedBumpsPassed: speedBumpsPassed ?? this.speedBumpsPassed,
      seesawsPassed: seesawsPassed ?? this.seesawsPassed);
  }
  
  CheckPointScore copyWithModelFieldValues({
    ModelFieldValue<int>? checkPointNumber,
    ModelFieldValue<int>? tilesPassed,
    ModelFieldValue<int>? totalLOP,
    ModelFieldValue<int>? gapsPassed,
    ModelFieldValue<int>? obstaclesPassed,
    ModelFieldValue<int>? intersectionsPassed,
    ModelFieldValue<int>? rampsPassed,
    ModelFieldValue<int>? speedBumpsPassed,
    ModelFieldValue<int>? seesawsPassed
  }) {
    return CheckPointScore._internal(
      checkPointNumber: checkPointNumber == null ? this.checkPointNumber : checkPointNumber.value,
      tilesPassed: tilesPassed == null ? this.tilesPassed : tilesPassed.value,
      totalLOP: totalLOP == null ? this.totalLOP : totalLOP.value,
      gapsPassed: gapsPassed == null ? this.gapsPassed : gapsPassed.value,
      obstaclesPassed: obstaclesPassed == null ? this.obstaclesPassed : obstaclesPassed.value,
      intersectionsPassed: intersectionsPassed == null ? this.intersectionsPassed : intersectionsPassed.value,
      rampsPassed: rampsPassed == null ? this.rampsPassed : rampsPassed.value,
      speedBumpsPassed: speedBumpsPassed == null ? this.speedBumpsPassed : speedBumpsPassed.value,
      seesawsPassed: seesawsPassed == null ? this.seesawsPassed : seesawsPassed.value
    );
  }
  
  CheckPointScore.fromJson(Map<String, dynamic> json)  
    : _checkPointNumber = (json['checkPointNumber'] as num?)?.toInt(),
      _tilesPassed = (json['tilesPassed'] as num?)?.toInt(),
      _totalLOP = (json['totalLOP'] as num?)?.toInt(),
      _gapsPassed = (json['gapsPassed'] as num?)?.toInt(),
      _obstaclesPassed = (json['obstaclesPassed'] as num?)?.toInt(),
      _intersectionsPassed = (json['intersectionsPassed'] as num?)?.toInt(),
      _rampsPassed = (json['rampsPassed'] as num?)?.toInt(),
      _speedBumpsPassed = (json['speedBumpsPassed'] as num?)?.toInt(),
      _seesawsPassed = (json['seesawsPassed'] as num?)?.toInt();
  
  Map<String, dynamic> toJson() => {
    'checkPointNumber': _checkPointNumber, 'tilesPassed': _tilesPassed, 'totalLOP': _totalLOP, 'gapsPassed': _gapsPassed, 'obstaclesPassed': _obstaclesPassed, 'intersectionsPassed': _intersectionsPassed, 'rampsPassed': _rampsPassed, 'speedBumpsPassed': _speedBumpsPassed, 'seesawsPassed': _seesawsPassed
  };
  
  Map<String, Object?> toMap() => {
    'checkPointNumber': _checkPointNumber,
    'tilesPassed': _tilesPassed,
    'totalLOP': _totalLOP,
    'gapsPassed': _gapsPassed,
    'obstaclesPassed': _obstaclesPassed,
    'intersectionsPassed': _intersectionsPassed,
    'rampsPassed': _rampsPassed,
    'speedBumpsPassed': _speedBumpsPassed,
    'seesawsPassed': _seesawsPassed
  };

  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "CheckPointScore";
    modelSchemaDefinition.pluralName = "CheckPointScores";
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'checkPointNumber',
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'tilesPassed',
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'totalLOP',
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'gapsPassed',
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'obstaclesPassed',
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'intersectionsPassed',
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'rampsPassed',
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'speedBumpsPassed',
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'seesawsPassed',
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
  });
}