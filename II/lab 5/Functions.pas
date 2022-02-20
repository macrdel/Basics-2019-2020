unit Functions;
interface
type
mtx = array [,] of integer;
procedure Get (var x: mtx; var m, n: byte; var f: TextFile);
procedure Put (const x: mtx; m, n: byte; name: string; var f: TextFile);
function Sum1 (const x: mtx; m, n: byte; var k: byte): integer;
function Sum2 (const x: mtx; m, n: byte; var l: byte): integer;

implementation

procedure Get (var x: mtx; var m, n: byte; var f: TextFile);
var 
   i, j: byte;
begin
   readln(f, m, n);
   SetLength(x, m, n);
   for i:= 0 to m-1 do
   begin
     for j:= 0 to n-1 do
       read(f, x[i, j]);
    readln(f);   
   end;
end;

procedure Put (const x: mtx; m, n: byte; name: string; var f: TextFile);
var
  i, j: byte;
begin
  writeln(f, 'Двумерный динамический массив ', name, ' размером ', m:2, ' на ', n:2);
  for i := 0 to m-1 do
  begin
    for j := 0 to n-1 do
      write(f, x[i, j]:8);
    writeln(f);
  end;
  writeln(f);
end;

function SumStr (const x: mtx; i, n: byte): integer;
var
   j: byte;
begin
   result:= 0;
   for j:=0 to n-1 do
     result:= result + x[i,j];
end;
 
function NoOrder (const x: mtx; i, n: byte): boolean;
 var 
    j: byte;
begin
   j:= 1;
   result:= false;
   while (j < n) and not result do
     if x[i,j] >= x[i,j-1] then
       result := true
     else
       j:= j + 1;
end;

function Sum1 (const x: mtx; m, n: byte; var k: byte): integer;
var
   i, j: byte;
begin
  k:= 0;
  for i:= 0 to m-1 do
    begin
    result:= 0;
    for j:= 0 to n-1 do
    if (NoOrder(x, i, n)) and (x[i, j] > 0) then
     begin
    k:= k + 1;
    result:= result + x[i, j];
     end;
    end;
end;

function Sum2 (const x: mtx; m, n: byte; var l: byte): integer;
var
  i: byte;
begin
  l:= 0;
  result:= 0;
  for i:= 0 to m-1 do
    if x[i, 1] < 0 then
      begin
      result:= result + SumStr (x, i, n);
      l:= l + 1;
      end;
end;

end.
