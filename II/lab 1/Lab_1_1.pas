
program Sets1;
var
  A, B, C: set of char;
  f: TextFile;

procedure Get(var f: text; var X: set of char);
var
  l: char;
begin
  while not Eoln(f) do
  begin
    Read(f, l);
    X:= X + [l];
  end;
  Readln(f);
end;


begin
  if ParamCount < 2 then
    Writeln('Недостаточно параметров')
  else 
    begin
    AssignFile(f, ParamStr(1));
    
    if not (FileExists(ParamStr(1))) then
      Writeln('Невозможно открыть файл ''', Paramstr(1), ''' для чтения')
    else
    begin
      Reset(f);
      
      Get(f, A);
      Get(f, B);
      Get(f, C);
      CloseFile(f);
      
      AssignFile(f, ParamStr(2));
      Rewrite(f);
      Write(f, 'Объединение: ');
      Writeln(f, A + B);
      Write(f, 'Пересечение: '); 
      Writeln(f, A * B);
      Write(f, 'Разность: '); 
      Writeln(f, A - B);
      Write(f, 'Выражение: '); 
      Writeln(f, ((A * B ) * (C - B)));
      CloseFile(f);
      
    end;
  end;
end.