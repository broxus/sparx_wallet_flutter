import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:uuid/uuid.dart';

enum MessageType {
  /// Just a regular message
  info(SnackbarType.info, defaultInfoMessageDebounceDuration),

  /// Message that informs about error
  error(SnackbarType.error, defaultErrorMessageDebounceDuration),

  /// Message that informs that user made some correct action
  successful(SnackbarType.successful, defaultSuccessfulMessageDebounceDuration);

  const MessageType(this.snackbarType, this.debounceTime);

  final SnackbarType snackbarType;
  final Duration debounceTime;
}

class Message {
  Message({
    required this.type,
    required this.message,
    this.duration = defaultMessageDisplayDuration,
    this.debounceTime = defaultInfoMessageDebounceDuration,
    this.actionText,
    this.onAction,
    this.topMargin,
    String? id,
  })  : hashString = '${type.name}_${sha256.convert(utf8.encode('message'))}',
        id = id ?? const Uuid().v4();

  factory Message.error({
    required String message,
    Duration duration = defaultMessageDisplayDuration,
    Duration debounceTime = defaultErrorMessageDebounceDuration,
    String? actionText,
    VoidCallback? onAction,
  }) =>
      Message(
        type: MessageType.error,
        message: message,
        duration: duration,
        debounceTime: debounceTime,
        actionText: actionText,
        onAction: onAction,
      );

  factory Message.info({
    required String message,
    Duration duration = defaultMessageDisplayDuration,
    Duration debounceTime = defaultInfoMessageDebounceDuration,
    String? actionText,
    VoidCallback? onAction,
    double? topMargin,
  }) =>
      Message(
        type: MessageType.info,
        message: message,
        duration: duration,
        debounceTime: debounceTime,
        actionText: actionText,
        onAction: onAction,
        topMargin: topMargin,
      );

  factory Message.successful({
    required String message,
    Duration duration = defaultMessageDisplayDuration,
    Duration debounceTime = defaultInfoMessageDebounceDuration,
    String? actionText,
    VoidCallback? onAction,
  }) =>
      Message(
        type: MessageType.successful,
        message: message,
        duration: duration,
        debounceTime: debounceTime,
        actionText: actionText,
        onAction: onAction,
      );

  final MessageType type;
  final String message;
  final Duration duration;
  final String? actionText;
  final VoidCallback? onAction;
  final Duration debounceTime;

  final String hashString;
  final double? topMargin;
  final String id;
}
