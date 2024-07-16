
import '../../models/task.dart';
import 'task_mock_service.dart';

abstract class TaskService {
  Stream<List<Task>> tasksStream();
  Future<Task> save(String title, DateTime deliveryDate);

  removeTask(String id);

  factory TaskService() {
    return TaskMockService();
  }
}