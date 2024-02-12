enum ExportFormat { xilog }

List exportFormatTitle = [ExportFormat.xilog];

extension ExportExtension on ExportFormat {
  String get name {
    switch (this) {
      case ExportFormat.xilog:
        return 'Xilog';
      default:
        return "";
    }
  }

  String get extension {
    switch (this) {
      case ExportFormat.xilog:
        return 'xxl';
      default:
        return "";
    }
  }
}
