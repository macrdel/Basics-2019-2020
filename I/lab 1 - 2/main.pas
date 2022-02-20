program lab2;
var 
    a, r, xs, xc : real;
begin
   
  write ('Введите длину половины стороны квадрата, радиус полукруга: ');
  readln (a,r);
  write ('Введите координату середины лежащей на оси стороны квадрата, центра полукруга: ');
  readln (xs,xc);
     
     if (xs <= xc-r) or (xs >= xc+r) then
          begin
       if (xc-r > xs+a) or (xc+r < xs-a) then
         writeln ('Фигуры не пересекаются')
       else if (xc-r = xs+a) or (xc+r = xs-a) then
              writeln ('Фигуры касаются внешним образом')
            else
               writeln ('Фигуры пересекаются');  
           end
       
     else if (xc-r < xs+a) and (xc+r > xs+a) and (xc-r < xs-a) and (xc+r > xs-a) then
          begin
          if (xs=xc) and (r*r=5*a*a) then
            writeln ('Квадрат вложен в полукруг, двойное внутреннее касание фигур')
          else if (r*r<5*a*a + xs*xs + xc*xc - 2*xs*a + 2*xc*a - 2*xc*xs) or (r*r<5*a*a + xs*xs + xc*xc + 2*xs*a - 2*xc*a - 2*xc*xs) then
                 writeln ('Фигуры пересекаются')
               else if (r*r>5*a*a + xs*xs + xc*xc - 2*xs*a + 2*xc*a - 2*xc*xs) and (r*r>5*a*a + xs*xs + xc*xc + 2*xs*a - 2*xc*a - 2*xc*xs) then
                      writeln ('Квадрат вложен в полукруг, фигуры не пересекаются')
                    else 
                      writeln ('Квадрат вложен в полукруг, одно внутреннее касание фигур');
           end 
           
          else
            writeln ('Полукруг вложен в квадрат, фигуры пересекаются');
       
end.     
