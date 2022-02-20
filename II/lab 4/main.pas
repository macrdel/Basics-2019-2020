program Strings;

var 
 d: string;
 r: string;
 fin: TextFile;

procedure StigWordsTogether (str: string; var newstr: string);
var 
   words: array of string;
   n, p, i: integer;
begin
  n:= 0;
  newstr:= ' ';
  while str <> '' do
  begin
    n:= n+1;
    SetLength(words, n);
    p:= Pos(' ',str);
    if p > 0 then
    begin
      words[n-1]:= Copy(str, 1, p-1);
      Delete(str, 1, p);
    end
    else
    begin
      words[n-1]:= str;
      str:= ' ';
    end;
    str:= TrimLeft(str);
  end;
  for i:=0 to (n div 2 - 1) do
    newstr:= newstr + words[i] + ' ';
  if n mod 2 = 1 then
    newstr:= newstr + words[n div 2] + ' ';
  for i:=0 to (n div 2 - 1) do
    newstr:= newstr + words[(n+1) div 2 + i] + words[i] + ' ';
end;

begin
  
  try
  AssignFile(fin, Paramstr(1));
  reset(fin);
  except
  writeln('Невозможно открыть файл для чтения!');
  exit;
  end;
  readln(fin, d);
  CloseFile(fin);
  
  StigWordsTogether(d, r);
  
  try
  AssignFile(fin, Paramstr(4));
  rewrite(fin);
  except
  writeln('Невозможно открыть файл для чтения!');
  exit;
  end;
  writeln(fin, 'Заданная строка: ', d);
  writeln(fin, 'Полученная строка: ', r);
  CloseFile(fin);

end.