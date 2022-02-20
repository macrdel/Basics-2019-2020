unit Functions1;
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
       read(f, x[i,j]);
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
      write(f, x[i,j]:5);
    writeln(f);
  end;
  writeln(f);
end;

function Sum1 (const x: mtx; m, n: byte; var k: byte): integer;
var
   i, j: byte;
   flag: boolean;
begin
  k:= 0;
  for i:= 0 to m-1 do
  begin
    flag:= false;
    j:= 1;
    while (j < n) and not flag do
      if x[i, j] >= x[i,j-1] then
       flag := true
     else
       j:= j + 1;
       if flag then
         begin
         k:= k + 1;
         j:= 0;
         result:= 0;
         while (j < n) do
         begin
           if x[i, j] > 0 then
          result:= result + x[i,j]; 
          j:= j + 1;        
           end;
          end;
end;
end;


function Sum2 (const x: mtx; m, n: byte; var l: byte): integer;
var
  i, j: byte;
begin
  l:= 0;
  result:= 0;
  for i:= 0 to m-1 do
   for j:= 0 to n-1 do
     if x[i,0] < 0 then
       begin
        l:= l + 1;
        result:= result + x[i, j];
        end;
end;

end.
