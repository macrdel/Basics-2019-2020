program ExternalSort;
uses ModuleLab9;
var
  fin, fout: TextFile;
  start, finish: System.DateTime;
  ts: System.TimeSpan;
begin
  if ParamCount < 2 then
  begin
    writeln('Недостаточно параметров');
    exit;
  end;
  try
    AssignFile(fin, ParamStr(1));
    Reset(fin);
  except
    writeln('Невозможно открыть файл ''', Paramstr(1), ''' для чтения');
    exit;
  end;
  try
    AssignFile(fout, ParamStr(2));
    Append(fout);
  except
    writeln('Невозможно открыть файл ''', Paramstr(2), ''' для записи');
    exit;
  end;
  CloseFile(fin); CloseFile(fout);
  
  //Сортировка прямым слиянием
  start:= System.DateTime.Now;
  DirectMerge(ParamStr(1), ParamStr(2));
  finish:= System.DateTime.Now;
  ts:= finish - start;
  writeln('Время сортировки прямым слиянием: ', ts.Minutes, ':', ts.Seconds, '.', ts.Milliseconds);
  
  //Сортировка естественным слиянием
  start:= System.DateTime.Now;
  NaturalMerge(ParamStr(1), ParamStr(2));
  finish:= System.DateTime.Now;
  ts:= finish - start;
  writeln('Время сортировки естественным слиянием: ', ts.Minutes, ':', ts.Seconds, '.', ts.Milliseconds);
  
  end.