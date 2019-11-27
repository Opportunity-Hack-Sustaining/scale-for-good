import 'dart:math';

List<double> goodValues = [];
List<double> badValues = [];

double getRNGNum(){
  var rng = new Random();
  var decimals = rng.nextDouble().toStringAsFixed(1);
  var wholeNum = rng.nextInt(50);
  var completeVal = wholeNum + double.parse(decimals);
  return completeVal;
}

void putGoodNum(double d){
  goodValues.add(d);
  goodValues.sort((a, b) => a.compareTo(b));
}
void putBadNum(double d){
  print(d);
  badValues.add(d);
  badValues.sort((a, b) => a.compareTo(b));
}

List<double> getGoodList(int size){
  for (var i =0;i<size;i++){
    putGoodNum(getRNGNum());
  }
  return goodValues;
}

List<double> getBadList(int size){
  for (var i =0;i<size;i++){
    putBadNum(getRNGNum()*-1);
  }
  return badValues;
}