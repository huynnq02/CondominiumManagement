import 'package:flutter/material.dart';
import 'package:untitled/repository/base/base_repository.dart';

abstract class BaseProvider<T extends BaseRepository> {
  @protected
  late T repository;

  BaseProvider() {
    repository = initRepository();
  }

  T initRepository();
}
