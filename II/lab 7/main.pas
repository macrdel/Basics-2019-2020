program Lab7;
uses UnitLab7;
var
fin, fout: TextFile;                                                                            //входной и выходной файлы
FC: CharFile;                                                                                   //типизированный файл
nb, nr: integer;                                                                                //номер позиции последнего символа ‘b’ и ‘r’ соответственно                                                                              
begin
  if ParamCount < 3 then	                                                                      //проверяем количество параметров
    writeln('Недостаточно параметров!')
  else
  begin
    if not FileExists(ParamStr(1)) or not FileExists(ParamStr(2)) then	                       //проверяем существование входного и выходного текстовых файлов
      writeln('Невозможно открыть файл для чтения или записи')
    else
    begin
  AssignFile(fin, ParamStr(1));
  AssignFile(fout, ParamStr(2));
  AssignFile(FC, Paramstr(3));
  try
    Transform(fin, FC);                                                                       //записываем данные, попавшие в нужный диапозон, из входного файла в типизированный
  except
    on System.FormatException do                                                              //обрабатываем исключения в случае, когда входной файл содержит неверные данные  
    begin
      writeln('Файл ''', Paramstr(1), ''' содержит неверные данные');
      exit;
    end;
  end;
  CloseFile(fin);
  
  Append(fout);
  writeln(fout, 'Содержимое типизированного файла: ');                                        //выводим содержимое типизированного файла до изменения
  writeln(fout);
  Put(FC, fout);
  writeln(fout);
  
  Search(FC, nb, 'b');                                                                        //находим позицию последнего элемента 'b' и 'r', выводим номер позиции, в случае, когда номер
  writeln(fout, 'Позиция последнего символа ''b'' в файле: ', nb);                            //позиции равен n=-1, нужного элемента нет в последовательности
  Search(FC, nr, 'r');
  writeln(fout, 'Позиция последнего символа ''r'' в файле: ', nr);
  writeln(fout);
  
  if (nb = nr) and (nb = -1) then                                                             //nb=nr=-1, то есть в последовательности нет элементов 'b' и 'r', перестановку не производим
    writeln(fout, 'Среди исходных данных нет нужных элементов.')
    else 
      if ((nb = 0) and (nr = -1)) or ((nr = 0) and (nb = -1)) then                            //последний 'b' или 'r' находится на первой позиции в исходном типизированном файле,                                    
        writeln(fout, 'Искомый элемент уже находиться на первой позиции в файле.')            //перестановку не производим
        else 
          if nb > nr then                                                                     //в случае, когда номер последнего элемента 'b' больше номера последнего элемента 'r', перемещаем
            Moving(FC, nb)                                                                    //'b' с позиции nb на позицию 0 
            else
              Moving(FC, nr);                                                                 //иначе перемещаем 'r' с позиции nr на позицию 0
  
  writeln(fout, 'Содержимое изменённого типизированного файла: ');                             //выводим содержимое типизированного файла после изменения или не изменения 
  writeln(fout);
  Put(FC, fout);
  writeln(fout);
  
  CloseFile(FC);
  CloseFile(fout);
end;
end;
end.
