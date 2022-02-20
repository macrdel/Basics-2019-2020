program Lab9;

const
  nmax = 20;

var
  { Входные данные }
  a:    array [1..nmax,1..nmax] of integer;           { вещ a[1..n,1..m] – исходный массив }
  n:    integer;        { цел n – количество строк матрицы }
  m:    integer;        { цел m – количество столбцов матрицы }
  t, i, j, l, k, p: integer; 
  f: text;          { файловая переменная }
  
  
begin


    if not FileExists('input.txt') then	      { Проверяем существование файла }
      writeln('Невозможно открыть файл для чтения')
    else
    begin
      { Ввод исходных данных }
      writeln('Количество строк матрицы: ');
      readln(n);
      writeln('Количество столбцов матрицы: ');
      readln(m);
      writeln('Заданное число: ');
      readln(t);
      Assign(f, 'input.txt');	       { Открываем файл }
      Reset(f);
      for i := 1 to n do
        for j:= 1 to m do
        read(f, a[i,j]);
      Close(f); 	                       { Закрываем файл }
      
    
 

 i:=1;
 l:=0;
 while i<=n do
 begin
   j:=1;
   while j<=m do
   begin
     k := 0;
     if (a[i,j] mod t = 0) and (k<1) then
     begin
       k:=k+1;
       l:=l+1;
       p:=i;
     end;
     j:=j+1;
   end;
   i:=i+1;
 end;
 
 
  { Вывод результатов }
      Assign(f, 'output.txt');
      if FileExists('output.txt') then
        Append(f)
      else
        Rewrite(f);
      writeln(f, 'Матрица A');
      for i := 1 to n do
        begin
        for j:= 1 to m do
        write(f, a[i,j]:8); 
        writeln(f);
        end;
      writeln(f);      
      if l=0 then
        writeln(f, 'В матрице нет элементов, кратных ',t)
      else
        writeln(f, 'В матрице есть элементы, кратные ',t);
      writeln(f);
      if l=n then
        writeln(f, 'В каждой строчке матрицы есть элемент, кратный ',t)
      else
        writeln(f, 'Номер последней строки, в которой есть хотя бы один элемент, кратный ',t,' = ',p);
      Close(f); 
    end;
end.    