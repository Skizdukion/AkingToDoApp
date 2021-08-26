String limitString(String string, int maxLen){
  if (string.length > maxLen){
    return string.replaceRange(maxLen - 3, string.length, '...');
  }
  else return string;
}