import 'dart:io';


void main() {
  performTasks();
}

void performTasks() async{
  //print(task2()); // this prints the value type of task2() before it is called,
  // and you can see that it only holds a receipt of what it will return(Future<string>)
  task1();
  String taskinput = await task2();
  task3(taskinput);
  task4();
  task5();
  task6();
  task7();
  task8();
  task9();
  task10();
  multidimensionallist();
}

void task1() {
  String result = 'task 1 data';
  print('Task 1 complete');
}

Future<String>task2() async{
  Duration takesometime = Duration(seconds: 5 );
  late String result;
  await Future.delayed(takesometime, (){
    result = 'task 2 data';
    print('Task 2 complete');
  });
  return result;
}

void task3(String input) {
  Duration sometime = Duration(seconds: 5 );
  String result = 'task 3 data';
  Future.delayed(sometime, (){
    // the difference between this function and the task2 function is that the task2 function has the await keyword on the 'future.delayed'
    // which means that the compiler has to wait because it returns a string that is need in task3.
    // but in this task3, the future.delayed just means skip me and run other function then come back when you are done.
  print('Task 3 complete with $input');
  });
}


void task4() {
  String result = 'task 1 data';
  print('Task 4 complete');
}

void task5() {
  String result = 'task 1 data';
  print('Task 5 complete');
}

void task6() {
  String result = 'task 1 data';
  print('Task 6 complete');
}

void task7() {
  String result = 'task 1 data';
  print('Task 7 complete');
}

void task8() {
  String result = 'task 1 data';
  print('Task 8 complete');
}

void task9() {
  String result = 'task 1 data';
  print('Task 9 complete');
}

void task10() {
  String result = 'task 1 data';
  print('Task 10 complete');
  print(task2());
}

void multidimensionallist(){
  List<List<int>> twoDimList = List.generate(5, (_) => List.filled(5, 0));
  print(twoDimList);
}

