unit UnitLab8;
interface
type
  TElem = string;

procedure Get(var x: array of TElem; var n: integer; var f: TextFile);
procedure Put(const x: array of TElem; n: integer; var f: TextFile);
procedure BubbleSort(var x: array of TElem; n: integer);
procedure SelectSort(var x: array of TElem; n: integer);
procedure InsertSort(var x: array of TElem; n: integer);
procedure QuickSort(var x: array of TElem; n1, n2: integer);

implementation

procedure Get;
var 
   i: integer;
begin
   readln(f, n);
   SetLength(x, n);
   for i:= 0 to n-1 do
       readln(f, x[i]);  
end;

procedure Put;
var
  i: integer;
begin
  for i := 0 to n-1 do
      write(f, x[i]:4);
  writeln(f);
end;

procedure BubbleSort;
var
 i, k: integer;
 y: TElem;
 f: boolean;
begin
 k:= 1;
    repeat
     f:= true;
       for i:= 0 to n - 1 - k do
        if x[i] > x[i + 1] then
         begin
         y:= x[i];
         x[i]:= x[i + 1];
         x[i + 1]:= y;
         f:= false;
         end;
      k:= k + 1;
    until f;
end;

procedure SelectSort;
var
 i, j, imin: integer;
 min: TElem;
begin
   for i:= 0 to n - 2 do
    begin
     min:= x[i];
     imin:= i;
      for j:= i + 1 to n - 1 do
       if x[j] < min then
        begin
        min:= x[j];
        imin:= j;
        end;
    x[imin]:= x[i];
    x[i]:= min;
    end;
end;

procedure InsertSort;
var
 i, j: integer;
 y: TElem;
begin
    for i:= 1 to n - 1 do
     begin
     y:= x[i];
     j:= i - 1;
      while (j >= 0) and (x[j] > y) do
       begin
       x[j + 1]:= x[j];
       j:= j - 1;
       end;
     x[j + 1]:= y;
     end;
end;

procedure QuickSort;
var
 i, j: integer;
 y, k: TElem;
begin
    if n2 - n1 = 1 then
    begin
     if x[n1] > x[n2] then
     begin
     y:= x[n1];
     x[n1]:= x[n2];
     x[n2]:= y;
     end;
    exit;
    end;
      k:= x[(n1 + n2) div 2];
      i:= n1;
      j:= n2;
    repeat
      while (x[i] < k) do 
        i:= i + 1;
      while (x[j] > k) do 
        j:= j - 1;
         if i < j then
         begin
         y:= x[i];
         x[i]:= x[j];
         x[j]:= y;
         i:= i + 1;
         j:= j - 1;
         end
         else
           if (i = j) then 
             begin
          i:= i + 1;
          j:= j - 1;
             end;
    until i > j;
     if n1 < j then
      QuickSort(x, n1, j);
     if i < n2 then
      QuickSort(x, i, n2);
end;

end.


