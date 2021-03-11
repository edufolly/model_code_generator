import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_consumer.dart';
import 'package:folly_fields/crud/abstract_model.dart';

///
///
///
abstract class BaseConsumerMock<A, T extends AbstractModel<A>>
    extends AbstractConsumer<A, T> {
  ///
  ///
  ///
  @override
  Future<ConsumerPermission> checkPermission(
    BuildContext context,
    List<String> paths,
  ) =>
      Future<ConsumerPermission>.value(
        ConsumerPermission(
          name: 'mock',
          iconName: 'question',
          view: true,
          insert: true,
          update: true,
          delete: true,
          menu: true,
        ),
      );

  ///
  ///
  ///
  @override
  Future<List<T>> list(
    BuildContext context,
    Map<String, String> qsParam,
    bool forceOffline,
  ) async =>
      <T>[];

  ///
  ///
  ///
  @override
  Future<Map<T, String>> dropdownMap(
    BuildContext context,
    Map<String, String> qsParam,
  ) async =>
      <T, String>{};

  ///
  ///
  ///
  @override
  Future<T> getById(
    BuildContext context,
    T model,
  ) async =>
      Future<T>.value(model);

  ///
  ///
  ///
  @override
  Future<bool> saveOrUpdate(
    BuildContext context,
    T model,
  ) =>
      Future<bool>.value(true);

  ///
  ///
  ///
  @override
  Future<bool> delete(
    BuildContext context,
    T model,
  ) async =>
      Future<bool>.value(true);
}
