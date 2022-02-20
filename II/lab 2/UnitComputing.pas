unit UnitComputing;

interface
uses
 UnitTypes;

const
 nmax = 100;


function f1(x: real): real;
function f2(x: real): real;
procedure EasyIterations (f: func; x0: real; e: real; var x: real; var n: integer); 
procedure Secant (f: func; x1, x2: real; e: real; var x: real; var n: integer);
procedure Newton (f: func; x0: real; e: real; var x: real; var n: integer);

implementation

function f1: real;
begin
  f1:= (power(x, 1/7) + ln(x + 0.3)) / (power(x + 1, 0.5)) - x;
end;

function f2: real;
begin
  f2:= sqr(sin(x) + cos(x)) / (power(33.5, 2 / 3)) + sqrt(3 / 7) - x;
end;

procedure EasyIterations;
var 
   x1: real;
begin
  n:=0;   
 repeat
  x1:= x0;
  x0:= f(x1)+ x1;
  n:= n + 1;
 until (abs(x1-x0)<e) or (n>nmax);
  x:= (x0+x1)/2;
end;

procedure Secant;
var 
   x0: real;
begin
  n:=0;
 repeat
   x0:= x2;
   x2:= x2 - (f(x2)*(x2-x1))/(f(x2)-f(x1));
   x1:= x0;
   n:= n + 1;
 until (abs(x2-x1)<e) or (n>nmax); 
   x:= (x1+x2)/2;
end;

procedure Newton;
var
  x1: real;
begin
  n:=0;   
 repeat
  x1:= x0;
  x0:= x1 - (e*f(x1))/(f(x1+e/2)-f(x1-e/2));
  n:= n + 1;
 until (abs(x1-x0)<e) or (n>nmax);
  x:= (x0+x1)/2;
end;

end.
