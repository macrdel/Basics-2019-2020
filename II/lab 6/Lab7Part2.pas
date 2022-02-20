program Lab7Part2;
var
a: array of integer;
n: integer;
y: boolean;
s: integer;
t: integer;
i: integer;
f: TextFile;
function Condition (const x: array of integer; n1, n2: integer; m: integer): boolean;
begin
  if n1 = n2 then
    result:= x[n1] mod m = 0
    else
    result:= (x[n1] mod m = 0) or (Condition(x, n1 + 1, n2, m));   
end;

function Product (const x: array of integer; n1, n2: integer; m: integer): integer;
begin
 if n1 = n2 then     
   if x[n1] mod m = 0 then 
     Result:= x[n1]     
     else 
     Result:= 0   
  else     
    Result:= Product(x, n1, (n1+n2) div 2, m) + Product(x,(n1+n2) div 2 + 1, n2, m);
end;
         
begin
  
  if ParamCount < 2 then
  begin
    writeln('Недостаточно параметров!');
    exit;
  end;
  try
    AssignFile(f, ParamStr(1));
    Reset(f);
  except 
    on System.IO.IOException do
    begin
      writeln('Невозможно открыть файл ''', Paramstr(1), ''' для чтения');
      exit;
    end;
    on System.FormatException do
    begin
      writeln('Файл ''', Paramstr(1), ''' содержит неверные данные');
      exit;
    end;
  end;
  Readln(f, n, t);
  SetLength(a, n);
  for i:= 0 to n-1 do
    read(f, a[i]);
  CloseFile(f);
  
  try
    AssignFile(f, ParamStr(2));
    Append(f);
  except
    writeln('Невозможно открыть файл ''', Paramstr(2), ''' для записи');
    exit;
  end;
  for i:= 0 to n-1 do
    write(f, a[i]:3);
  writeln(f);
  y:= Condition(a, 0, n-1, t);
  if y then
    begin
    writeln(f, 'В массиве есть элементы, кратные  ', t);
    s:= Product(a, 0, n-1, t);
    writeln(f, 'Сумма таких элементов = ', s);
    end
    else
      writeln(f, 'В массиве нет элементов, кратных  ', t);
    writeln(f); writeln(f);
    CloseFile(f);
    
end.


