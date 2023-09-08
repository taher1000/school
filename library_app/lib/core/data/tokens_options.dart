import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:dio/dio.dart';

enum TokenOptionsType {
  idm,
  sanad,
  none,
}

extension TokenOptionsTypeExt on TokenOptionsType {
  Options get asOptions => Options(extra: toExtra(this));

  static Map<String, dynamic> toExtra(TokenOptionsType type) =>
      <String, dynamic>{type.name: true};

  static TokenOptionsType valueOf(String? data) {
    for (final TokenOptionsType value in TokenOptionsType.values) {
      if (value.name == data) {
        return value;
      }
    }
    log('$data is not valid type of TokenOptionsType');
    return TokenOptionsType.none;
  }

  static TokenOptionsType typeFrom(RequestOptions request) {
    final tokenKey = request.extra.keys.firstWhereOrNull(
      (extraKey) =>
          TokenOptionsType.values
              .firstWhereOrNull((it) => it.name == extraKey) !=
          null,
    );

    if (tokenKey != null) {
      return valueOf(tokenKey);
    }

    return TokenOptionsType.idm;
  }
}
