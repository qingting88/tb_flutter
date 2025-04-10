import 'http_util.dart';
import 'task_result.dart';

Future<TaskResult<T>> fetchByPost<T>(String url, [Object? data]) async {
  String errorMsg = "";

  try {
    var result = await HttpUtil.instance.client.post(url, data: data);
    print(result.data);
    if (result.data != null) {
      return TaskResult.success(data: result.data['data']);
    }
  } catch (e) {
    print(e);
    errorMsg = e.toString();
  }

  return TaskResult.error(msg: '请求错误: $errorMsg');
}

Future<TaskResult<T>> fetchByGet<T>(String url, [Object? data]) async {
  String errorMsg = "";

  try {
    var result = await HttpUtil.instance.client.get(url, data: data);
    print(result.data);
    if (result.data != null) {
      return TaskResult.success(data: result.data['data']);
    }
  } catch (e) {
    print(e);
    errorMsg = e.toString();
  }

  return TaskResult.error(msg: '请求错误: $errorMsg');
}
