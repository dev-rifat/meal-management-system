/// Formats [date] as `YYYY-MM-DD` — the plain, sortable form used for date
/// input fields across the app (not a display-friendly format).
String formatDateYmd(DateTime date) =>
    "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
