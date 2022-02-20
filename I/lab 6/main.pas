program Lab6;

const
  nmax = 20;

var
  { Входные данные }
  a:    array[1..nmax] of real;         { вещ a[1..n] – исходный массив }
  c:    array[1..nmax] of real;         { вещ c[1..n] – исходный массив }
  n:    integer;     { цел n – количество элементов массива }
  
  { Выходные данные }
  imin: integer;        { цел imin – номер наименьшего из значений a[i]^c[i] }
  z: real;              { вещ z - наименьшее из значений a[i]^c[i] }
  
  { Промежуточные данные }
  i: integer;        { цел i – параметр цикла }
  f: text;           { файловая переменная }
        
begin
 
  
    if not FileExists('input1.txt') or not FileExists('input2.txt') then	      { Проверяем существование файла }
      begin
      writeln('Невозможно открыть файлы для чтения');
      end
    else
    begin
      { Ввод исходных данных }
      writeln('Количество элементов массивов: ');
      readln (n);
      Assign(f, 'input1.txt');	       { Открываем файл }
      Reset(f);
      for i := 1 to n do
        readln(f, a[i]);
      Close(f); 	                       { Закрываем файл }
       Assign(f, 'input2.txt');	       { Открываем файл }
      Reset(f);
      for i := 1 to n do
        readln(f, c[i]);
      Close(f); 	                       { Закрываем файл }


      { Нахождение номера наименьшего из значений a[i]^c[i] – заглушка }
      imin := 1;
      z:=0;
      i:= 1;
      while i<=n do
      begin
        if power(a[i],c[i]) <= power(a[imin],c[imin]) then
          begin
          imin:=i;
          z:=power(a[imin],c[imin]);
          end;
        i:=i+1;  
      end;
      
      { Вывод результатов }
 
      Assign(f, 'output.txt');
      if FileExists('output.txt') then
        Append(f)
      else
        Rewrite(f);
      writeln(f, 'Массив A из ', n, ' элементов');
      for i := 1 to n do
        write(f, a[i]:6);
        writeln(f);
      writeln(f, 'Массив C из ', n, ' элементов');
      for i := 1 to n do
        write(f, c[i]:6);  
      writeln(f); writeln(f);
      writeln(f, 'Номер наименьшего из значений a[i]^c[i] = ', imin, ' наименьшее из значений a[i]^c[i] = ', z);
      Close(f); 
    end;
  end.
