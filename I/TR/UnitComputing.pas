unit UnitComputing;

interface

uses 
  UnitTypes;

function f1(x: real): real;
function f2(x: real): real;
function Otr(const x: matrix; m, n: integer): integer;
function OtrFunc(const x: matrix; m, n: integer; f: func): integer;
function Poryadok(const x: matrix; m, n: integer): integer; 

implementation

function f1(x: real): real;
begin
  f1:= x;
end;

function f2(x: real): real;
begin
  f2:= power(x + 5, 2 / 3) - x;
end;

function Otr(const x: matrix; m, n: integer): integer;
var
  i, j: integer;
begin
 result:= 0;
  for i:= 1 to m do
    for j:= 1 to n do
      if x[i,j] < 0 then
        result:= result + 1;
end;

function OtrFunc(const x: matrix; m, n: integer; f: func): integer;
var
  i, j: integer;
begin
  result:= 0;
  for i:= 1 to m do
    for j:= 1 to n do
      if f(x[i,j]) < 0 then
        result:= result + 1;
end;

function Poryadok(const x: matrix; m, n: integer): integer;
var
  i, j: integer;
  order: boolean;
begin
  result:= 0;
  for i:= 1 to m do
  begin
    order:= true;
    j:= 2;
    while (j <= n) and order do
      if x[i,j] <= x[i,j-1] then
        order:= false
      else
        j:= j + 1;
    if order then
      result:= result + 1;
  end;
end;

end.