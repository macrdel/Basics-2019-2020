program Lab11;
//Создать однонаправленный и двунаправленный списки из символов английского алфавита, такие, что сначала идут гласные, потом все остальные. 
//Найти в списке первый (и последний) элемент 'b' или 'r' и удалить все такие элементы из списка.
//uses SingleLinkedList;
uses DoublyLinkedList;

var
  fin, fout: TextFile;
  lst: TList;
  former, latter: PElem;
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
    Rewrite(fout);
  except
    writeln('Невозможно открыть файл ''', Paramstr(2), ''' для записи');
    exit;
  end;

Initialize(lst);
InputList(fin, lst);
CloseFile(fin);
OutputList(fout, lst); //для двунаправленного списка выводим всегда в прямом и обратном порядке
writeln(fout, 'Ввели данные из файла с сохранением порядка элементов таким, какой есть в файле');
writeln(fout);

AddToBegin(lst, 'f');
AddToBegin(lst, 'g');
AddToEnd(lst, 'f');
AddToEnd(lst, 'g');
OutputList(fout, lst);
writeln(fout, 'Добавили элементы "f" и "g" в начало и конец списка');
writeln(fout);

Search(lst, former, latter);
writeln(fout, 'Адрес первого элемента "b" или "r": ', former);
writeln(fout, 'Адрес последнего элемента "b" или "r": ', latter); //у однонаправленного списка всегда = nil
writeln(fout);

DeleteElements(lst);
OutputList(fout, lst);
writeln(fout, 'Удалили из списка все элементы "b" и "r"');
writeln(fout);

DeleteList(lst);

Reset(fin);
InputListCondition(fin, lst);
CloseFile(fin);
OutputList(fout, lst);
writeln(fout, 'Ввели данные из файла, добавляя элементы в список так, чтобы соблюдался нужный нам порядок');
writeln(fout);

Search(lst, former, latter);
writeln(fout, 'Адрес первого элемента "b" или "r": ', former);
writeln(fout, 'Адрес последнего элемента "b" или "r": ', latter); //у однонаправленного списка всегда = nil
writeln(fout);

DeleteElements(lst);
OutputList(fout, lst);
writeln(fout, 'Удалили из списка все элементы "b" и "r"');
writeln(fout);

DeleteList(lst);

CloseFile(fout);
end.
  