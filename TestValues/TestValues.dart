import 'dart:math';

List<double> goodValues = [];

double getRNGNum(){
  var rng = new Random();
  var decimals = rng.nextDouble().toStringAsFixed(1);
  var wholeNum = rng.nextInt(50);
  var completeVal = wholeNum + double.parse(decimals);
  return completeVal;
}

void putNum(double d){
  goodValues.add(d);
  goodValues.sort((a, b) => a.compareTo(b));
}


//This is the main call used when getting good values
//Example: goodValueList = getGoodList(50);
List<double> getGoodList(int size){
  for (var i =0;i<size;i++){
    putNum(getRNGNum());
  }
  return goodValues;
}