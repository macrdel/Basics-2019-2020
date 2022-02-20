program Lab7;

const
  nmax = 20;

var
  { Входные данные }
  x:  array[1..nmax] of real;            { вещ x[1..n] – исходный массив }
  n:  integer;        { цел n – количество элементов массива }
  
  { Выходные данные }
  exists: boolean;        { лог exists – признак наличия отрицательного элемента }
  k:      integer;        { цел k – номер отрицательного элемента }
  
  { Промежуточные данные }
  i: integer;        { цел i – параметр цикла }
  f: text;       { файловая переменная }
  
begin
    if not FileExists('input.txt') then	      { Проверяем существование файла }
      writeln('Невозможно открыть файл для чтения')
    else
    begin
      { Ввод исходных данных }
      Assign(f,'input.txt');	       { Открываем файл }
      Reset(f);
      n := 0;
      while not eof(f) do
      begin
        n := n + 1;
        read(f, x[n]);
      end;
      Close(f); 	                       { Закрываем файл }

      { Проверка наличия отрицательного элемента и нахождение его номера }
      exists := false;
      i := 1;
      while (i <= n) and (exists = false) do
      begin
        if x[i] < 0 then
        begin
          exists := true;
          k := i;
        end;
        i := i + 1;
      end;
      
      { Вывод результатов }
      Assign(f, 'output.txt');
      Rewrite(f);
      writeln(f, 'Массив X из ', n, ' элементов');
      for i := 1 to n do
        writeln(f, x[i]);
      writeln(f); writeln(f);
      if exists = true then
        writeln(f, 'Отрицательный элемент есть, его номер = ', k)
      else
        writeln(f, 'Отрицательных элементов в массиве нет');
      Close(f); 
    end;
  end.
  
  
    

