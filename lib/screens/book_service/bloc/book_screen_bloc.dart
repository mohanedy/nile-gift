import 'dart:io';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:gift_of_the_nile/models/book_ref.dart';
import 'package:gift_of_the_nile/services/data_service_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';

class BookScreenBloc {
  final _provider = DataServiceProvider();
  final _downloadState = BehaviorSubject<DownloadTaskStatus>();
  final _progressValue = BehaviorSubject<int>();

  ValueStream<DownloadTaskStatus> get downloadState => _downloadState.stream;

  ValueStream<int> get progressValue => _progressValue.stream;
  Book _currentBook;
  String _currentTaskId;

  BookScreenBloc(this._currentBook) {
    init();
    FlutterDownloader.registerCallback((taskId, status, progress) async {
      if (status == DownloadTaskStatus.complete) {
        final tasks = await FlutterDownloader.loadTasks();
        final task = tasks.firstWhere((task) => task.taskId == _currentTaskId);
        print('completed ' + localPath + '/' + task.filename);
        await _provider.saveDownloadedBook(
            _currentBook, localPath + '/' + task.filename);
      }
      _downloadState.sink.add(status);

      print(progress);
      _progressValue.sink.add(progress);
    });
  }

  init() async {
    final value = await _provider.isDownloadedBook(_currentBook);
    if (value == null || value.isEmpty) {
      _downloadState.sink.add(DownloadTaskStatus.undefined);
    } else {
      print(value);
      localPath = value;
      _downloadState.sink.add(DownloadTaskStatus.complete);
    }
  }

  String localPath = "";

  changeDownloadState() async {
    if (_downloadState.value == DownloadTaskStatus.undefined) {
      final dir = await getExternalStorageDirectory();
      localPath = (dir.path) + '/NileGift';

      final savedDir = Directory(localPath);
      bool hasExisted = await savedDir.exists();
      if (!hasExisted) {
        await savedDir.create();
      }

      _currentTaskId = await FlutterDownloader.enqueue(
        url: _currentBook.downloadLink,
        savedDir: localPath,
        showNotification: true,
        openFileFromNotification: true,
      );
    } else if (_downloadState.value == DownloadTaskStatus.running) {
      FlutterDownloader.cancel(taskId: _currentTaskId);
    } else {
      print(_downloadState.value);
      _downloadState.sink.add(DownloadTaskStatus.undefined);
    }
  }

  dispose() async {
    FlutterDownloader.registerCallback(null);
    await _downloadState.drain();
    _downloadState.close();
    await _progressValue.drain();
    _progressValue.close();
  }
}

enum DownloadingState { downloading, canceled, error, none, completed }
