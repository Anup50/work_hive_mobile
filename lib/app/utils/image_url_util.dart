String getImageUrl(String? backendImagePath) {
  if (backendImagePath == null) return '';
  return backendImagePath.replaceFirst(
    'localhost:3000',
    '192.168.18.11:3000',
  );
}
