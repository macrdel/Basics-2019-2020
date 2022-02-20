unit ModuleLab9;

interface

procedure DirectMerge(InputFile, OutputFile: string); 
procedure NaturalMerge(InputFile, OutputFile: string);

implementation

procedure DirectMerge(InputFile, OutputFile: string);
const   
// Имена промежуточных файлов  
IntermediateFile1 = 'file____1.txt';   
IntermediateFile2 = 'file____2.txt'; 
 
var   
finp, fout, fin1, fin2:  TextFile;   
s, n, i, v1, v2, w1, w2: integer;   
eof1, eof2: boolean; 
 
begin   
n:= 1;
  repeat     
  // Разделение      
  AssignFile(finp, InputFile);     
  Reset(finp);     
  AssignFile(fin1, IntermediateFile1);     
  Rewrite(fin1);     
  AssignFile(fin2, IntermediateFile2);     
  Rewrite(fin2);
  
  s:= 0;
  while true do
  begin
    for i:= 1 to n do
    begin
      read(finp, v1);
      write(fin1, ' ', v1);
      if eof(finp) then
        break;
    end;
    if eof(finp) then
      break;
      for i:= 1 to n do
      begin
        read(finp, v2);
        write(fin2, ' ', v2);
        if eof(finp) then
          break;
      end;
      if eof(finp) then
        break;
        // Подсчитываем количество ПОЛНЫХ серий в каждом из файлов
        s:= s + 1;
  end;
  
  CloseFile(finp);
  CloseFile(fin1);
  CloseFile(fin2);
  
  //Слияние
  AssignFile(fin1, IntermediateFile1);
  Reset(fin1);
  AssignFile(fin2, IntermediateFile2);
  Reset(fin2);
  AssignFile(fout, OutputFile);
  Rewrite(fout);
  
  eof1:= false; eof2:= false;
  read(fin1, v1); read(fin2, v2);
  
  //Теперь рассмотрим цикл по количеству серий
  
  for i:= 1 to s do
  begin
    w1:= 0; w2:= 0;
    //В каждой серии должно быть не больше n операций записи
    while (w1 < n) and (w2 < n) do
    begin
      if v1 < v2 then
      begin
        write(fout, ' ', v1);
        w1:= w1 + 1;
        if eof(fin1) then
        begin
          eof1:= true;
          break;
        end;
        read(fin1, v1);
      end
      else
      begin
        write(fout, ' ', v2);
        w2:= w2 + 1;
        if eof(fin2) then
        begin
          eof2:= true;
          break;
        end;
        read(fin2, v2);
      end;
    end;
    
    // Дописываем незавершённые серии
    while w1 < n do
    begin
      write(fout, ' ', v1);
      w1:= w1 + 1;
      if eof(fin1) then
      begin
        eof1:= true;
        break;
      end;
      read(fin1, v1);
    end;
    while w2 < n do
    begin
      write(fout, ' ', v2);
      w2:= w2 + 1;
      if eof(fin2) then
      begin
        eof2:= true;
        break;
      end;
      read(fin2, v2);
    end;
  end;
  
     //Дописываем неполные серии
     while not eof1 and not eof2 do
       if v1 < v2 then
       begin
         write(fout, ' ', v1);
         if eof(fin1) then
         begin
           eof1:= true;
           break;
         end;
         read(fin1, v1);
       end
       else
       begin
         write(fout, ' ', v2);
         if eof(fin2) then 
         begin
           eof2:= true;
           break;
         end;
         read(fin2, v2);
       end;
       while not eof1 do
       begin
         write(fout, ' ', v1);
         if eof(fin1) then
         begin
           eof1:= true;
           break;
         end;
         read(fin1, v1);
       end;
       while not eof2 do
       begin
         write(fout, ' ', v2);
         if eof(fin1) then
         begin
           eof2:= true;
           break;
         end;
         read(fin2, v2);
       end;
       
       CloseFile(fin1); CloseFile(fin2); CloseFile(fout);
       
       n:= n*2;
       
       // В следующий раз читаем данные из созданного выходного файла
       InputFile:= OutputFile;
       
       //Завершаем цикл если была одна полная серия или были только неполные серии
       
       until s = 0;
       
       //Удалим промежуточные файлы
       DeleteFile(IntermediateFile1); DeleteFile(IntermediateFile2);
end;
       
procedure NaturalMerge(InputFile, OutputFile: string);
const   
IntermediateFile1 = 'file____1.txt';   
IntermediateFile2 = 'file____2.txt'; 
var   
finp, fout, fin1, fin2: TextFile;   
s, v1, v2, vp1, vp2: integer;   
file1, eof1, eof2, eos1, eos2: boolean; 

begin 
 
repeat     
  // Разделение     
  AssignFile(finp, InputFile);     
  Reset(finp);     
  AssignFile(fin1, IntermediateFile1);     
  Rewrite(fin1);     
  AssignFile(fin2, IntermediateFile2);     
  Rewrite(fin2); 
 
  // Переменная file1 обеспечивает выбор файла для записи текущей серии      
  file1 := true;     
  // В переменной s подсчитывается общее количество серий в двух файлах        
  s := 1;
  
  { В цикле считываем элементы исходного файла и записываем их в один 
  из промежуточных файлов в зависимости от значения переменной file1.
  Значение переменной file1 меняем в тот момент, когда достигнут конец серии.
  Конец серии достигается в тот момент, когда число в файле больше следующего.
  Для этого надо считывать два числа и после сравнения как бы "проталкивать" второе в первое.
  По достижению конца файла дописываем оставшееся число. }
  
  read(finp, v1);
  while not eof(finp) do
  begin
    read(finp, v2);
    if file1 then
      write(fin1, ' ', v1)
    else
      write(fin2, ' ', v1);
    if v1 > v2 then
    begin
      file1:= not file1;
      s:= s + 1;
    end;
    v1:= v2;
  end;
 // Дописываем оставшееся число
 if file1 then
   write(fin1, ' ', v1)
  else
   write(fin2, ' ', v1);
   
   CloseFile(finp); CloseFile(fin1); CloseFile(fin2);
   
   //Слияние
   AssignFile(fin1, IntermediateFile1);
   Reset(fin1);
   AssignFile(fin2, IntermediateFile2);
   Reset(fin2);
   AssignFile(fout, OutputFile);
   Rewrite(fout);
   
   // Переменные eof1 и eof2 принимают значения "истина" в тот момент, когда
   //достигнут конец 1-ого или 2-ого файла
   
   eof1:= false; eof2:= false;
   //Когда одна серия  - второй файл пустой
   read(fin1, v1);
   if s = 1 then 
     eof2:= true
     else
     read(fin2, v2);
     while not eof1 and not eof2 do
     begin
       //Переменные eos1 и eos2 принимают значения "истина" в тот момент, когда
       //достигнут конец серии в 1-ом или во 2-ом файле
       eos1:= false; eos2:= false;
        while not eos1 and not eos2 do
        begin
         // В случае, если меньшее взято из первого файла
       if v1 < v2 then
         begin
         //Записываем его в выходной файл
         write(fout, ' ', v1);
         // Проверяем, не достигнут ли конец файла, из которого было взято меньшее число
         // конец файла также обозначает конец серии
         if eof(fin1) then
         begin
           eof1:= true;
           eos1:= true;
           break;
         end;
           // Если конец файла не достигнут, считываем ещё одно число и проверяем, достигнут ли конец серии
           vp1:=v1;
           read(fin1, v1);
           if vp1 > v1 then
             eos1:= true;
          end
          else
            begin
            // Аналогично для второго файла
            write(fout, ' ', v2);
            if eof(fin2) then
         begin
           eof2:= true;
           eos2:= true;
           break;
         end;
          vp2:=v2;
           read(fin2, v2);
           if vp2 > v2 then
             eos2:= true;
          end;
          end;
            //В одном из файлов серии закончились, поэтому дописываем до конца серию из другого файла
            //Так как мы не знаем, в каком из файлов закончилась серия, поэтому проверяем оба файла
            //Однако выполняться будет только один цикл
          while not eos1 do
          begin
            write(fout, ' ', v1);
          if eof(fin1) then
             begin
           eof1:= true;
           eos1:= true;
           break;
             end;
            vp1:=v1;
           read(fin1, v1);
           if vp1 > v1 then
             eos1:= true;
           end;
            while not eos2 do       
              begin          
              // Аналогично для второго файла
              write(fout, ' ', v2);
          if eof(fin2) then
             begin
           eof2:= true;
           eos2:= true;
           break;
             end;
           vp2:=v2;
           read(fin2, v2);
           if vp2 > v2 then
             eos2:= true;
           end;
     end;
     // Достигнут конец из файлов – дописываем до конца данные 
     // из другого файла, пока файл не закончится
     while not eof1 do
       begin
         write(fout, ' ', v1);
         if eof(fin1) then
         begin
           eof1:= true;
           break;
         end;
         read(fin1, v1);
       end;
       while not eof2 do
       begin
         write(fout, ' ', v2);
         if eof(fin1) then
         begin
           eof2:= true;
           break;
         end;
         read(fin2, v2);
       end;
       
       CloseFile(fin1); CloseFile(fin2); CloseFile(fout);
       
       //Присваиваем имя выходного файла в переменную для входного файла,
       //чтобы на втором шаге цикла читать данные из выходного файла 
       
       InputFile:= OutputFile;
       
       //Завершаем цикл по разделению и слиянию в тот момент, когда
       //в двух файлах было не больше двух серий
       
       until s <= 2;
       
       //Удаляем промежуточные файлы
        DeleteFile(IntermediateFile1);   DeleteFile(IntermediateFile2);
end;

end.  
   
 