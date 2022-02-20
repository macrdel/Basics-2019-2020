program Lab9;

const
  nmax = 20;
type
   matrix =  array [1..nmax,1..nmax] of real;

var
  { Входные данные }
  a:    matrix;           { вещ a[1..n,1..m] – исходный массив }
  n:    integer;        { цел n – количество строк матрицы }
  
  c, d: real;           { вещ c,d - заданные значения, c < d}
  { Выходные данные }
  k: integer;        { цел k – количество элементов матрицы, удовлетворяющих условию }
  p: real;           { вещ p – произведение элементов матрицы, удовлетворяющих условию }
  { Промежуточные данные } 
  i: integer;           { цел i – параметр цикла }
  j: integer;           { цел j – параметр цикла }
  f: text;          { файловая переменная }
  
  
begin


    if not FileExists('input.txt') then	      { Проверяем существование файла }
      writeln('Невозможно открыть файл для чтения')
    else
    begin
      { Ввод исходных данных }
      writeln ('Ввод границ поиска с и d (c<d): ');
      readln (c, d);
      AssignFile(f, 'input.txt');	       { Открываем файл }
      Reset(f);
      n:=0;
      while not eoln (f) do 
        n:=n+1;
      for i := 1 to n do
        for j:= 1 to n do
        read(f, a[i,j]);
      CloseFile(f); 	                       { Закрываем файл }

    
 

 k:=0;
 p:=1;
 for i:= 1 to n do
   for j:= 1 to n do
   if (a[i,j]>c) and (a[i,j]<d) then
   begin
     k:=k+1;
     p:=p*a[i,j];
   end;
   
 
 
  { Вывод результатов }
      AssignFile(f, 'output.txt');
      if FileExists('output.txt') then
        Append(f)
      else
        Rewrite(f);
      writeln(f, 'Матрица A');
      for i := 1 to n do
        begin
        for j:= 1 to n do
        write(f, a[i,j]:8); 
        writeln(f);
        end;
      writeln(f);      
      if k=0 then
        writeln(f, 'В матрице нет элементов элементов, больших ', c, ' и меньших ', d)
      else
        writeln(f, 'Количество элементов матрицы, больших ', c, ' и меньших ', d ,', = ', k, ', их произведение = ', p);
      CloseFile(f);
    end;
end.    

 