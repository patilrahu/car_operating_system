String formatTime(String time) {
  final dateTime = DateTime.parse(time);
  final hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
  final paddedHour = hour == 0 ? 12 : hour.toString().padLeft(2, '0');
  final minute = dateTime.minute.toString().padLeft(2, '0');
  final period = dateTime.hour >= 12 ? 'PM' : 'AM';
  return '$paddedHour:$minute $period';
}
