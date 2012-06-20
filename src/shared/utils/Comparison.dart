#library('utils');

class Comparison {
  static int asc(Comparable a, Comparable b) => a.compareTo(b);
  
  static int desc(Comparable a, Comparable b) => b.compareTo(a);
}
