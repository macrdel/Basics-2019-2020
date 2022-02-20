program Lab8;

const
  nmax = 20;

var
  { Входные данные }
  a:    array [1..nmax] of integer;           { цел a[1..n] – исходный массив }
  n:    integer;        { цел n – количество элементов массива }
  
  { Выходные данные }
  imin: integer;        { цел imin – номер первого минимального элемента среди положительных элементов, расположенных после первого элемента, равного нулю }
  
  { Промежуточные данные }
  nt, np: integer;      { цел nt – номер первого элемента, равного нулю; цел np – номер первого положительного элемента }
  t_exists, p_exists: boolean;    { лог t_exists, p_exists – признак наличия элемента, равного нулю, и положительных элементов }
  min: integer;           { цел min - минимальный положительный элемент} 
  i: integer;           { цел i – параметр цикла }
  f: text;          { файловая переменная }
  
  
begin


    if not FileExists('input.txt') then	      { Проверяем существование файла }
      writeln('Невозможно открыть файл для чтения')
    else
    begin
      { Ввод исходных данных }
      writeln('Количество элементов массива: ');
      readln(n);
      Assign(f, 'input.txt');	       { Открываем файл }
      Reset(f);
      for i := 1 to n do
        readln(f, a[i]);
      Close(f); 	                       { Закрываем файл }

      { Нахождение номера первого минимального положительного элемента, стоящего после первого элемента, равного нулю }
      { Первый этап: поиск элемента, равного нулю }
      t_exists:=false;
      p_exists:=false;
      i:=0;
      while (i<n) and (t_exists=false) do
      begin
        i:=i+1;
        if a[i]=0 then
          t_exists:=true;  
      end;
      if t_exists=false then                  { Если элемента, равного нулю, нет, }
        nt := 0                               { начинаем поиск с начала массива }
      else 
        nt := i;  
      { Второй этап: поиск положительного элемента }
      i := nt;
      while (i<n) and (p_exists=false) do
      begin
        i:=i+1;
        if a[i]>0 then
          begin
         p_exists:=true;
         np:=i;
          end;
      end;
      { Третий этап: поиск номера первого минимального положительного элемента }
      if p_exists=true then
      begin
        i:=np;
        min:=a[i];
        imin:=i;
        while i<=n do
        begin
          if (a[i]< min) and (a[i]>0) then
            begin
            min:=a[i];
            imin:=i;
            end;
          i:=i+1;  
        end;
      end;
      
      { Вывод результатов }
      Assign(f, 'output.txt');
      if FileExists('output.txt') then
        Append(f)
      else
        Rewrite(f);
      writeln(f, 'Массив A из ', n, ' элементов');
      for i := 1 to n do
        write(f, a[i], ' ');
      writeln(f); writeln(f);      
      if t_exists = true then
        writeln(f, 'Номер первого элемента, равного нулю ', nt)
      else
        writeln(f, 'Нет элементов, равных нулю - поиск с начала массива');
      if p_exists = true then
      begin
        writeln(f, 'Номер первого положительного элемента после элемента с номером ' , nt, ' = ', np);
        writeln(f, 'Номер первого минимального положительного элемента после элемента с номером ' , nt, ' = ', imin);
      end
      else
        writeln(f, 'В массиве нет положительных элементов после ', nt, 'номера');
      Close(f); 
    end;
  end.
