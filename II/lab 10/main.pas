program Lab10;
//Отсортировать исходные данные ПО ГРУППЕ. 
//Найти студентов, средний балл которых БОЛЬШЕ общего среднего балла.
//Определить средний балл всех студентов по всем предметам. 
//Отсортировать выходные данные по стипендии.
type

Student = record
   group: string[10];
   FIO: string[15];
   BirthYear: integer;
   gender: char;
   Scholarship: real;
   phys, math, info: 2..5;
   GPA: real;  //средний балл по трём предметам
end; 

func = function(rec1, rec2: Student): boolean;      //параметр функционального типа, который будет задавать функцию для сравнения полей записей      

TypedFile = file of Student;                        //типизированный файл из записей

DynArr = array of Student;

var
fin, fout: TextFile;
fil: TypedFile;
st: DynArr;
n1, n2: byte;
AverageAll: real; //общий средний балл

function CompareGroup (rec1, rec2: Student): boolean;          //функция сравнения записей по группам
begin
  result:= rec1.group > rec2.group;
end;

function CompareScholarship (rec1, rec2: Student): boolean;    //функция сравнения записей по стипендиям
begin
  result:= rec1.Scholarship > rec2.Scholarship;
end;

procedure Transform (const F: TextFile; var TF: TypedFile);    //запись данных в типизированный файл
var
 rec: Student;
begin
  Reset(F);
  Rewrite(TF);
  while not eof(F) do
    begin
    with rec do
    begin
      Readln(F, group);
      Readln(F, FIO);
      Readln(F, BirthYear);
      Readln(F, gender);
      Readln(F, Scholarship);
      Readln(F, phys);
      Readln(F, math);
      Readln(F, info);
      GPA:= (phys + math + info)/3;
    end;
    write(TF, rec);
    end;
   CloseFile(F); 
end;

procedure ToArray (var x: DynArr; const TF: TypedFile);        //запись данных в динамический массив
var
 i: byte;
 rec: Student;
begin
  for i:= 0 to FileSize(TF) - 1 do
  begin
    seek(TF, i);
    read(TF, rec);
    x[i]:= rec;
  end;
  CloseFile(TF);
end;

procedure QuickSort(var x: DynArr; n1, n2: byte; f: func);     //сортировка записей методом быстрой сортировки с использованием функционального
var                                                            //типа для сравнения полей
 i, j: byte;
 y, k: Student;
begin
    if n2 - n1 = 1 then
    begin
     if f(x[n1], x[n2]) then
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
      while f(k, x[i]) do 
        i:= i + 1;
      while f(x[j], k) do 
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
      QuickSort(x, n1, j, f);
     if i < n2 then
      QuickSort(x, i, n2, f);
end;

function Average (const x: DynArr; k: byte): real;    //общий средний балл
var
i: byte;
begin
  result:= 0;  
  for i:= 0 to k-1 do
    result:= result + x[i].GPA;
  result:= result/k ;
end;

procedure Selection (var x: DynArr; k1: byte; var k2: byte;  all: real); //отбор студентов, средний балл которых выше общего среднего балла
var
i, j: byte;
begin
  j:= -1;
  for i:= 0 to k1-1 do
    if x[i].GPA > all then
      begin
      j:= j + 1;
      x[j]:= x[i];
      end;
  k2:= j + 1;
  SetLength(x, k2);
end;

procedure Put (const x: DynArr; k: byte; var F: TextFile);
var
  i: byte;
begin
  for i:= 0 to k-1 do
    begin
  with x[i] do
  begin
    write(F, ' Группа: ', group, ' ');
    write(F, ' ФИО: ', FIO, ' ');
    write(F, ' Год рождения: ', BirthYear, ' ');
    write(F, ' Пол: ', gender, ' ');
    write(F, ' Стипендия: ', Scholarship, ' ');
    write(F, ' Физика: ', phys, ' ');
    write(F, ' Математика: ', math, ' ');
    write(F, ' Информатика: ', info, ' ');
    write(F, ' Средний балл: ', GPA :3: 2, ' ');
  end;
  writeln(F);
     end;
end;

begin
   if ParamCount < 3 then	                               //проверяем количество параметров
    writeln('Недостаточно параметров!')
  else
  begin
    if not FileExists(ParamStr(1)) then	                 //проверяем существование входного и выходного текстовых файлов
      writeln('Невозможно открыть файл для чтения')
    else
    begin
  AssignFile(fin, ParamStr(1));
  AssignFile(fout, ParamStr(2));
  AssignFile(fil, Paramstr(3));
  try
    Transform(fin, fil);                                 //записываем данные из входного файла в типизированный
     except
      on System.FormatException do                       //обрабатываем исключения в случае, когда входной файл содержит неверные данные  
       begin
      writeln('Файл ''', Paramstr(1), ''' содержит неверные данные');
      exit;
       end;
  end;
  n1:=  FileSize(fil);
  SetLength(st, n1);
  ToArray(st, fil);   //записываем данные в массив
  QuickSort(st, 0, n1-1, CompareGroup); //сортируем записи по группам
  Rewrite(fout);
  writeln(fout, 'Отсортированные исходные данные по группам: ');
  writeln(fout);
  Put(st, n1, fout);
  AverageAll:= Average(st, n1); //находим средний балл
  writeln(fout);
  writeln(fout, 'Общий средний балл: ', AverageAll:3:2);
  Selection(st, n1, n2, AverageAll);
  QuickSort(st, 0, n2-1, CompareScholarship); //сортируем записи в обновлённом массиве по стипендиям
  writeln(fout);
  writeln(fout, 'Студенты, чей средний балл выше общего среднего балла, записи о которых отсортированы по стипендиям: ');
  writeln(fout);
  Put(st, n2, fout);
  CloseFile(fout);
  end;
end;
end.




