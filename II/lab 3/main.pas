program Hash;
uses
   UnitLab3;
type
 TCharSet = set of char;
 SetArray = array of TCharSet;
 func = function (x: TCharSet): integer;
var
 csets: SetArray;
 n: integer;
 colls: integer;
 equals: integer;
 fin, fout: TextFile;

begin
if ParamCount < 2 then	              
    writeln('Недостаточно параметров!')
else
  begin
    if not FileExists(ParamStr(1)) then	      
      writeln('Невозможно открыть файл ''', ParamStr(1), ''' для чтения')
    else
    begin
      AssignFile(fin, ParamStr(1));	   
      Reset(fin);

       Get (csets, n, fin);
       Close(fin);

AssignFile(fout, ParamStr(2));
Rewrite(fout);
writeln (fout, ' Количество множеств: ', n);
CollsAndEquals(csets, n, colls, equals, EvalHash1);
writeln (fout, ' Количество равенств в EvalHash1: ', equals);
writeln (fout, ' Количество коллизий в EvalHash1: ', colls);
writeln(fout);
CollsAndEquals(csets, n, colls, equals, EvalHash2);
writeln (fout, ' Количество равенств в EvalHash2: ', equals);
writeln (fout, ' Количество коллизий в EvalHash2: ', colls);
writeln(fout);
CollsAndEquals(csets, n, colls, equals, EvalHash3);
writeln (fout, ' Количество равенств в EvalHash3: ', equals);
writeln (fout, ' Количество коллизий в EvalHash3: ', colls);
writeln(fout);

        Close(fout);
end;
end;
end.
