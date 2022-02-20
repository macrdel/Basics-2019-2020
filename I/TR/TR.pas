﻿{ Разработать программу для обработки двух матриц разного размера с использованием процедур и функций, 
реализованных в отдельном модуле. Кроме процедур ввода/вывода при разработке программы необходимо выделить 
две подпрограммы и выбрать подходящий тип этих подпрограмм – процедура или функция. 
Ввод осуществляется из файла, вывод – в файл. Для передачи имён файлов должны использоваться параметры программы.
Функция f, применяемая к элементам матриц, передаётся в подпрограмму с помощью функционального типа. 
Задание необходимо выполнить для двух вариантов функции f – в качестве первого варианта берём f(x) = x для того, 
чтобы было легко проверить правильность работы программы, в качестве второго – любую другую функцию одного аргумента. 
В случае равенства вычисленных значений, выводить соответствующее сообщение и не осуществлять никакой обработки.
16. Для той из матриц, в которой больше количество элементов, для которых значение f(xij) отрицательно, 
подсчитать число таких её строк, элементы каждой из которых упорядочены по возрастанию.
Типовой расчёт 
Сначала разработайте обший алгоритм решения задачи и выделите в нём абстракции.
Реализуйте выделенные абстракции с помощью подпрограмм.
Определите тип подпрограмма – процедура или функция.
Продумайте состав параметров подпрограмм и категории параметров.
Функция, упоминающаяся в задании, должна применяться к элементу матрицы и, соответственно, должна получать один параметр.
Используйте параметры программы.
Не забывайте проверять наличие параметров программы и существование файла с исходными данными.
Разрабатывайте как можно более полный набор тестовых примеров.
Для удобства выводите исходные данные в выходной файл.
Если матрица была изменена, также выводите её в выходной файл.
При проверках наличия/отсутствия каких-либо элементов не забывайте использовать досроный выход из цикла.
При необходимости найти что-то в каждом столбце, поменяйте местами циклы for.
Если проверка условия для строки не требует использования цикла 
(например, нужно обработать строки, в которых отрицателен первый элемент), проверяйте это условие до внутреннего цикла. }

program TR;

uses
  UnitTypes, UnitInputOutput, UnitComputing;

var
  a, b:                   matrix;         
  ma, na, mb, nb:         integer;         
  k1_a, k2_a, k3_a:       integer;            
  k1_b, k2_b, k3_b:       integer;            
  p:                      integer;            
begin

    Get(a, ma, na, fin);
    Get(b, mb, nb, fin);
    Put(a, ma, na, 'A', fout);
    Put(b, mb, nb, 'B', fout);
    k1_a:= Otr(a, ma, na);
    k1_b:= Otr(b, mb, nb);
    k2_a:= OtrFunc(a, ma, na, f1);
    k2_b:= OtrFunc(b, mb, nb, f1);
    if (k1_a = k2_a) and (k1_b = k2_b) then
      begin
    writeln(fout, 'Программа работает корректно');
    k3_a:= OtrFunc(a, ma, na, f2);
    k3_b:= OtrFunc(b, mb, nb, f2);
    if k3_a = k3_b then
      writeln(fout, 'Kоличество элементов, для которых значение f(xij) отрицательно, в обеих матрицах равно')
      else 
        if k3_a > k3_b then
      begin
        writeln(fout, 'Kоличество элементов, для которых значение f(xij) отрицательно, в матрице А больше и = ', k3_a);
        p:= Poryadok(a, ma, na);
        writeln(fout, 'Число строк матрицы А, элементы которых упорядочены по возрастанию, = ', p);
      end
        else
          begin
             writeln(fout, 'Kоличество элементов, для которых значение f(xij) отрицательно, в матрице B больше и = ', k3_b);
             p:= Poryadok(b, mb, nb);
             writeln(fout, 'Число строк матрицы B, элементы которых упорядочены по возрастанию, = ', p);
          end
       end
     else
      writeln(fout, 'Программа работает некорректно');   
end.