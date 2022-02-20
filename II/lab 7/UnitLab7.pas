unit UnitLab7;
interface
type 
CharFile = file of char;                                                          //объявление типа символьного файла

procedure Transform (const F: TextFile; var CF: CharFile);                        //процедура преобразования текстового файла в типизированный 
procedure Put (const CF: CharFile; var F: TextFile);                              //процедура вывода типизированного файла в текстовый 
procedure Search (const CF: CharFile; var n: integer; ch0: char);                 //процедура поиска в файле последнего символа ‘b’ и ‘r’ и номера его позиции
procedure Moving (var CF: CharFile; n: integer);                                  //процедура перемещения последнего символа ‘b’ или ‘r’ в начало файла

implementation

procedure Transform (const F: TextFile; var CF: CharFile);
var
  ch: char;
begin
  Reset(F);
  Rewrite(CF);
  while not eof(F) do
  begin
    read(F, ch);
    if (ord('a') <= ord(ch)) and (ord('z') >= ord(ch)) then
      write(CF, ch);
  end;
end;

procedure Put (const CF: CharFile; var F: TextFile);
var
  ch: char;
begin
  Reset(CF);
  while not eof(CF) do
  begin
    read(CF, ch);
    write(F, ch);
  end;
end;

procedure Search (const CF: CharFile; var n: integer; ch0: char);
var 
  i: integer;
  ch: char;
begin
  n:= -1;
  for i:= 0 to FileSize(CF) - 1 do
  begin
    seek(CF, i);
    read(CF, ch);
    if ch = ch0 then
       n:= i; 
  end;
end;

procedure Moving (var CF: CharFile; n: integer);
var
  i: integer;
  ch, cha: char;
begin
  reset(CF);
  seek(CF, n);
  read(CF, ch);
  for i:= n-1 downto 0 do
  begin
    seek(CF, i);
    read(CF, cha);
    seek(CF, i+1);
    write(CF, cha);
  end;
  seek(CF, 0);
  write(CF, ch);
end;

end.
