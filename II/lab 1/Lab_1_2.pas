program Sets2;

uses UnitSetOnBooleanArray;

var
  a, b, c, r: TCharSet;
  f: TextFile;
  ch: char;

begin
  if ParamCount < 2 then
  begin
    writeln('Недостаточно параметров');
    exit;
  end;
  try
    AssignFile(f, ParamStr(1));
    Reset(f);
  except
    writeln('Невозможно открыть файл ''', Paramstr(1), ''' для чтения');
    exit;
  end;
  Init(a);
  while not eoln(f) do
  begin
    read(f, ch);
    Add(a, ch);
  end;
  readln(f);
  Init(b);
  while not eoln(f) do
  begin
    read(f, ch);
    Add(b, ch);
  end;
  readln(f);
  Init(c);
  while not eoln(f) do
  begin
    read(f, ch);
    Add(c, ch);
  end;
  CloseFile(f);

  try
    AssignFile(f, ParamStr(2));
    Rewrite(f);
  except
    writeln('Невозможно открыть файл ''', Paramstr(2), ''' для записи');
    exit;
  end;
  write(f, 'Объединение: [');
  r := Union(a, b);
  for ch := chr(0) to chr(255) do
   if IsInSet(ch, r) then
     write(f, ch);
  writeln(f, ']');
  write(f, 'Пересечение: [');
  r := Intersection(a, b);
  for ch := chr(0) to chr(255) do
   if IsInSet(ch, r) then
     write(f, ch);
  writeln(f, ']');
  write(f, 'Разность:    [');
  r := Difference(a, b);
  for ch := chr(0) to chr(255) do
   if IsInSet(ch, r) then
     write(f, ch);
  writeln(f, ']');
  write(f, 'Выражение:   [');
  r := Intersection(Intersection(a, b),Difference(c, b));
  for ch := chr(0) to chr(255) do
   if IsInSet(ch, r) then
     write(f, ch);
  writeln(f, ']');
  CloseFile(f);
end.
