program Lab5;
uses Functions;
var 
   a: mtx;
   m, n: byte;
   k, l: byte;
   scond1, scond2: integer;
   fin, fout: TextFile;
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
  writeln('Невозможно открыть файл для чтения');
  exit;
  end;
  try
  Get(a, m, n, fin);
  except
  writeln(' Плохой формат ');
  CloseFile(fin);
  exit;
  end;
  CloseFile(fin);
  try
  AssignFile(fout, ParamStr(2));
  Rewrite(fout);
  except
  writeln('Ошибка записи');
  CloseFile(fout);
  exit;
  end;
  
Put(a, m, n, 'A', fout);
scond1:= Sum1(a, m, n, k);
if k > 0 then 
  writeln(fout, 'Сумма положительных элементов последней строки матрицы A, не упорядоченной по убыванию: ', scond1)
else
begin
  scond2:= Sum2(a, m, n, l);
  if l > 0 then
    writeln(fout, 'Общая сумма элементов тех строк матрицы A, в которых отрицателен первый элемент: ', scond2)
    else
      writeln(fout, 'Нет строк, в которых отрицателен первый элемент');
end;
CloseFile(fout);
end.   