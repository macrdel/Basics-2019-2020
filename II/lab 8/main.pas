program Sort;
uses UnitLab8;
var
  a, b: array of TElem;
  na: integer;
  fin, fout: TextFile;
  start, finish: System.DateTime;
  ts: System.TimeSpan;
begin
  if ParamCount < 2 then
  begin
    writeln('Недостаточно параметров');
    exit;
  end;
  try
    AssignFile(fin, ParamStr(1));
    Reset(fin);
  except
    writeln('Невозможно открыть файл ''', Paramstr(1), ''' для чтения');
    exit;
  end;
  try
    AssignFile(fout, ParamStr(2));
    Append(fout);
  except
    writeln('Невозможно открыть файл ''', Paramstr(2), ''' для записи');
    exit;
  end;
 
 Get(a, na, fin);
 CloseFile(fin);
 writeln(fout, 'Вид исходного массива из ', na:4, ' элементов : ');
 writeln(fout);
 Put(a, na, fout);
 
 SetLength(b, na);
 b:=a;
 
 writeln(fout, 'Сортировка обменами ');
 start:= System.DateTime.Now;
 BubbleSort(a, na);
 finish:= System.DateTime.Now;
 ts:= finish - start;
 writeln(fout, 'Время Сортировка обменами: ', ts.Minutes, ':', ts.Seconds, '.', ts.Milliseconds);
 writeln(fout, 'Отсортированный Массив метод Сортировки Обменами: ');
 writeln(fout);
 Put(a, na, fout);
 writeln(fout);
 
 writeln(fout, 'Сортировка выбором ');
 a:=b;
 start:= System.DateTime.Now;
 SelectSort(a, na);
 finish:= System.DateTime.Now;
 ts:= finish - start;
 writeln(fout, 'Время Сортировка выбором: ', ts.Minutes, ':', ts.Seconds, '.', ts.Milliseconds);
 writeln(fout, 'Отсортированный Массив метод Сортировки выбором: ');
 writeln(fout);
 Put(a, na, fout);
 writeln(fout);
 
 writeln(fout, 'Сортировка вставками ');
 a:=b;
 start:= System.DateTime.Now;
 InsertSort(a, na);
 finish:= System.DateTime.Now;
 ts:= finish - start;
 writeln(fout, 'Время Сортировка вставками: ', ts.Minutes, ':', ts.Seconds, '.', ts.Milliseconds);
 writeln(fout, 'Отсортированный Массив метод Сортировки вставками: ');
 writeln(fout);
 Put(a, na, fout);
 writeln(fout);
 
 writeln(fout, 'Быстрая Сортировка ');
 a:=b;
 start:= System.DateTime.Now;
 SelectSort(a, na);
 finish:= System.DateTime.Now;
 ts:= finish - start;
 writeln(fout, 'Время Быстрая Сортировка ', ts.Minutes, ':', ts.Seconds, '.', ts.Milliseconds);
 writeln(fout, 'Отсортированный Массив метод Быстрой Сортировки: ');
 writeln(fout);
 Put(a, na, fout);
 writeln(fout);
 
 Writeln(fout);
 CloseFile(fout);
 
end.  