{Даны три одномерных массива a, b и c разного размера.  
Какой из массивов имеет наибольшую сумму элементов, 
абсолютное значение которых находится в заданном интервале? }

program Lab12;

const
  nmax = 20;

type
  mas = array [1..nmax] of real;

var
  { Входные данные }
  a, b, c:    mas;                         { Исходные массивы }
  na, nb, nc: integer;                     { Количество элементов массивов a, b, c соответственно }
  al, ar, bl, br, cl, cr: real;            { Концы интервалов для отбора элементов массивов a, b, c соответственно }
  
  { Выходные данные }
  sa, sb, sc: real;         { Сумма элементов, абсолютное значение которых лежит на заданном интервале }
  
  { Промежуточные данные }
  ka, kb, kc: integer;                 { Количество элементов, абсолютное значение которых лежит на заданном интервале }
  fin, fout: TextFile;                 { Файловые переменные }

  
{ Процедура ввода одномерного массива из файла }
procedure Get(var x: mas; var n: integer; var f: TextFile);
begin
  n := 0;
 while not eoln(f) do
  begin
   n := n + 1;
   read(f, x[n]);
  end;
 readln(f);
end;

{ Процедура вывода одномерного массива в файл }
procedure Put(const x: mas; n: integer; name: string; var f: TextFile);
var
  i: integer;
begin
  writeln(f, 'The array ', name, ' of ', n:2, ' elements');
  for i := 1 to n do
    write(f, x[i]:8);
   end;
  writeln(f); writeln(f);
end;

{ Функция поиска суммы элементов массива, абсолютное значение которых лежит на заданном интервале }
function SumAbs(const x: mas; n: integer; dl: real; dr: real; var k: integer): real;
var
 i: integer;
begin
  result := 0;
  for i := 1 to n do
    if (abs(x[i]) > dl) and (abs(x[i]) < dr) then
    begin
      k := k + 1;
      result := result + x[i];
    end;
end;

begin

      { Ввод исходных данных }
      AssignFile(fin, 'input.txt');	         
      Reset(fin);
      Get(a, na, fin);
      Get(b, nb, fin);
      Get(c, nc, fin);
      readln(fin, al, ar, bl, br, cl, cr);
      CloseFile(fin); 	                         

      { Поиск количества элементов, больших заданного числа, в каждом из трёх массивов }
      ka := 0;
      kb := 0;
      kc := 0;
      sa := SumAbs(a, na, al, ar, ka);
      sb := SumAbs(b, nb, bl, br, kb);
      sc := SumAbs(c, nc, cl, cr, kc);
      
      { Вывод результатов }
      AssignFile(fout, 'output.txt');
      Rewrite(fout);
      Put(a, na, 'A', fout);
      writeln(fout, 'Заданный интервал для А : ', al:8:2, ar:8:2); writeln(fout);
      Put(b, nb, 'B', fout);
      writeln(fout, 'Заданный интервал для B : ', bl:8:2, br:8:2); writeln(fout);
      Put(c, nc, 'C', fout);
      writeln(fout, 'Заданный интервал для C : ', cl:8:2, cr:8:2); writeln(fout);
      if (ka <> 0) or (kb <> 0) or (kc <> 0) then
      if (sa = sb) and (sb = sc) then
        writeln(fout, 'Сумма элементов, абсолютное значение которых принадлежит заданному интервалу, совпадает во всех трёх массивах и равно ', sa:2)
      else if (sa = sb) and (sa > sc) then
        writeln(fout, 'Сумма элементов, абсолютное значение которых принадлежит заданному интервалу, максимально в массивах A и B и равно ', sa:2)
      else if (sa = sc) and (sa > sb) then
        writeln(fout, 'Сумма элементов, абсолютное значение которых принадлежит заданному интервалу, максимально в массивах A и C и равно ', sa:2)
      else if (sb = sc) and (sb > sa) then
        writeln(fout, 'Сумма элементов, абсолютное значение которых принадлежит заданному интервалу, максимально в массивах B и C и равно ', sb:2)
      else if (sa > sb) and (sa > sc) then
        writeln(fout, 'Сумма элементов, абсолютное значение которых принадлежит заданному интервалу, максимально в массиве A и равно ', sa:2)
      else if (sb > sa) and (sb > sc) then
        writeln(fout, 'Сумма элементов, абсолютное значение которых принадлежит заданному интервалу, максимально в массиве B и равно ', sb:2)
      else
        writeln(fout, 'Сумма элементов, абсолютное значение которых принадлежит заданному интервалу, максимально в массиве C и равно ', sc:2);
      CloseFile(fout); 
end.


