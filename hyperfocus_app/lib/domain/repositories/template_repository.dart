import '../models/task_template.dart';

abstract class TemplateRepository {
  Future<List<TaskTemplate>> getAllTemplates();
  Future<List<TaskTemplate>> getTemplatesByCategory(String category);
  Future<List<TaskTemplate>> searchTemplates(String query);
  Future<TaskTemplate?> getTemplateById(String id);
  Future<void> insertCustomTemplate(TaskTemplate template);
  Future<void> updateCustomTemplate(TaskTemplate template);
  Future<void> deleteCustomTemplate(String id);
  Future<List<TaskTemplate>> getCustomTemplates();
}
