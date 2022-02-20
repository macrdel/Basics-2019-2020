program Lab4;

var
  a0, b0, e, a, b, x, x1, x2: real;


function f(x: real): real;
begin
  f := sqr(sin(x) + cos(x)) / (power(33.5, 2 / 3)) + sqrt(3 / 7) - x;
end;


function g(x: real): real;
begin
  g := sqr(sin(x) + cos(x)) / (power(33.5, 2 / 3)) + sqrt(3 / 7);
end;

begin
   
  write('Введите границы отрезка: ');
  readln(a0, b0);
  write('Введите точность: ');
  readln(e);
  
  a:=a0;
  b:=b0;
  while abs(a-b) > e do
   begin
  x:=(a+b)/2;
  if f(a) * f(x) < 0 then
    b:=x
  else
    a:=x
   end;
  x :=(a+b)/2;
 writeln('Аргумент, при котором f(x)=0, полученный методом деления отрезка пополам: x = ', x);
 writeln('f(x) = ', f(x));
 
 x2:=(a0+b0)/2;
 repeat
  x1:=x2;
  x2:=g(x1);
until abs(x1-x2)<e;
  x:=(x1+x2)/2;
 writeln('Аргумент, при котором f(x)=0, полученный методом простых итераций: x = ', x);
 writeln('f(x) = ', f(x));


end.
