class MathHelpers {
  static int findNearestFactorFromInt(int no, [int prmNo = 3]) {
    if (no.remainder(prmNo) == 0) return no;
    bool isDone = false;
    while (!isDone) {
      no = no + 1;
      if (no.remainder(prmNo) == 0) isDone = true;
    }
    return no;
  }

  static int convertRowColToIndex(
      int row, int col, int totalRow, int totalCol) {
    int currentIndex;
    if (col == 1)
      currentIndex = (totalCol * (col - 1) + row);
    else
      currentIndex = (totalCol * (col - 1) + row);
    return currentIndex;
  }
}
