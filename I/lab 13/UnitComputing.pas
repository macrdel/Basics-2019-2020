unit UnitComputing;

interface

uses 
  UnitTypes;

function AmountLin(const x: matrix; m, n: integer; t: real): integer;
function AmountEl(const x: matrix; m, n: integer; t: real): integer;

implementation

function AmountLin(const x: matrix; m, n: integer; t: real): integer;
var  
   i, j: integer;
   avail: boolean;
begin
   result:= 0;
   for i:= 1 to m do
   begin
     avail:= false;
     j:= 1;
     while (j <= n) and not avail do
       if x[i,j] = t then
         avail := true
       else
         j:=j+1;
      if avail then
        result:= result + 1;   
   end;
end;

function AmountEl(const x: matrix; m, n: integer; t: real): integer;
var 
   i, j: integer;
begin
  result:= 0;
  for i:= 1 to m do
    for j:= 1 to n do
      if x[i,j] = t then
        result:= result + 1;
end;
end.
