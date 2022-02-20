{Даны три одномерных массива a, b и c разного размера. Для каждого из этих массивов сформировать массив, 
содержащий элементы исходного массива, ЦЕЛАЯ ЧАСТЬ которых равна заданному числу. 
Для формирования массива из элементов, ЦЕЛАЯ ЧАСТЬ которых равна заданному числу, использовать процедуру. 
Для ввода и вывода массивов также использовать процедуры. }

program Lab11;

const
  nmax = 20;

type
  mas = array [1..nmax] of real;

var
  { Входные данные }
  a, b, c:    mas;             { Исходные массивы }
  na, nb, nc: integer;         { Количество элементов массивов a, b, c соответственно }
  ta, tb, tc: integer;         { Заданные число }
  
  { Выходные данные }
  d, e, f:    mas;             { Формируемые массивы }
  nd, ne, nf: integer;         { Количество элементов массивов d, e, f соответственно }
  
  { Промежуточные данные }
  fin, fout: TextFile;         { Файловые переменные }


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
  if n=0 then
    writeln(f, 'No elements in the array ', name)
    else 
   begin
  writeln(f, 'The array ', name, ' of ', n:2, ' elements');
  for i := 1 to n do
    write(f, x[i]:8);
   end;
  writeln(f); writeln(f);
end;

{ Процедура поиска элементов исходного массива, целая часть которых равна заданному числу, и формирования
из них новых массивов }
procedure Form(const x: mas; n: integer; w: integer; var z: mas; var k: integer);
  var
  i: integer;
  
begin
  k := 0;
  for i := 1 to n do
    if floor(x[i]) = w  then
    begin
      k := k+1;
      z[k] := x[i];
    end;
end;


begin

      { Ввод исходных данных }
      AssignFile(fin, 'input.txt');	       
      Reset(fin);
      Get(a, na, fin);
      Get(b, nb, fin);
      Get(c, nc, fin);
      readln(fin, ta, tb, tc);
      CloseFile(fin); 	                       

      { Формирование массивов }
      Form(a, na, ta, d, nd);
      Form(b, nb, tb, e, ne);
      Form(c, nc, tc, f, nf);

      { Вывод результатов }
      AssignFile(fout, 'output.txt');
      Rewrite(fout);
      Put(a, na, 'A ', fout);
      Put(b, nb, 'B ', fout);
      Put(c, nc, 'C ', fout);
      Put(d, nd, 'D intA ', fout);
      Put(e, ne, 'E intB ', fout);
      Put(f, nf, 'F intC ', fout);
      CloseFile(fout); 

end.