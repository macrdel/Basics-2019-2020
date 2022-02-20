unit SingleLinkedList; //модуль для работы с однонаправленным (односвязанным) списком

interface
type
TInfo = char;

PElem = ^TElem;

Telem = record
   info: TInfo;
   next: Pelem;
end;

TList = record
   first, last: PElem;
end;

procedure Initialize (var list: TList); //процедура инициализация списка
function IsEmpty (list: Tlist): boolean; //функция проверки на пустоту
procedure AddToBegin (var list: TList; info: TInfo); //процедура добавление элемента в начало списка
procedure AddToEnd (var list: TList; info: TInfo); //процедура добавления элемента в конец списка
procedure AddAfterCurrent (var list: TList; cur: PElem; info: TInfo); //процедура добавления нового элемента ПОСЛЕ заданного
procedure DeleteFirst (var list: TList); //процедура удаления первого элемента из списка
procedure DeleteCurrent (var list: TList; var prev, cur: PElem); //процедура удаления заданного элемента списка
procedure DeleteList (var list: TList); //процедура удаления списка
procedure AddCondition (var list: TList; info: TInfo); //процедура добавления элемента с сохранением порядка
procedure DeleteElements (var list: TList); //процедура удаления элементов, удовлетворяющих условию
procedure Search (list: TList; var first, last: PElem); //процедура поиска первого удовлетворяющего условию элемента
procedure InputList (f: TextFile; var list: TList); //процедура ввода из файла
procedure InputListCondition (f: Textfile; var list: TList); //процедура ввода из файла с созданием порядка
procedure OutputList (var f: TextFile; list: TList); //процедура вывода списка в файл в прямом порядке

implementation

procedure Initialize (var list: Tlist);
begin
  list.first:= nil;
  list.last:= nil;
end;

function IsEmpty (list: TList): boolean;
begin
  result:= list.first = nil;
end;

procedure AddToBegin (var list: TList; info: TInfo);
var
  p: PElem;
begin
  new(p);
  p^.info:= info;
  p^.next:= list.first;
  list.first:= p;
  if list.last = nil then //если элемент был последним
    list.last:= p;
end;

procedure AddToEnd (var list: TList; info: TInfo);
var
  p: PElem;
begin
 new(p);
 p^.info:= info;
 p^.next:= nil;
 if list.first = nil then
   list.first:= p
 else
   list.last^.next:= p;
   list.last:= p;
end;

procedure AddAfterCurrent (var list: TList; cur: PElem; info: TInfo);
var
  p: PElem;
begin
 if cur = nil then 
   exit;
    new(p);
    p^.info:= info;
    p^.next:= cur^.next;
    cur^.next:= p;
    if cur = list.last then
      list.last:= p;
end;

procedure DeleteFirst (var list: TList);
var
  p: PElem;
begin
if list.first = nil then //нечего удалять
  exit;
  p:= list.first;
  list.first:= list.first^.next;
  dispose(p);
  if IsEmpty(list) then
    list.last:= nil;
end;

procedure DeleteCurrent (var list: TList; var prev, cur: PElem); //передаётся адрес предыдущего элемента
begin
  if cur = nil then
    exit;
    if (cur = list.first) and (list.first = list.last) then //в списке имеется лишь один элемент
    begin
      dispose(list.first);
      list.first:= nil;
      list.last:= nil;
      prev:= nil;
      cur:= nil;
    end
    else if cur = list.last then //удаляем последний элемент
    begin
      list.last:= prev;
      dispose(cur);
      list.last^.next:= nil;
      cur:= nil;
    end
    else if cur = list.first then //удаляем первый элемент
    begin
      list.first:= list.first^.next;
      dispose(cur);
      cur:= list.first;
    end
    else  //удаляем произвольный неграничный неединственный элемент
      begin
      prev^.next:= cur^.next;
      dispose(cur);
      cur:= prev^.next;
      end;
end;

procedure DeleteList (var list: TList);
var
  p: PElem;
begin
  while list.first <> nil do
  begin
    p:= list.first;
    dispose(p);
    list.first:= list.first^.next;
  end;
  list.last:= nil;
end;

procedure AddCondition (var list: TList; info: TInfo);
begin
  if list.first = nil then
    AddToBegin(list, info)
  else if ((info = 'a') or (info = 'e') or (info = 'i') or (info = 'o') or (info = 'u')) then
         AddToBegin(list, info)
        else
          AddToEnd(list, info);
end;

procedure DeleteElements (var list: TList);
var
  prev, cur: PElem;
begin
  prev:= nil;
  cur:= list.first;
  while cur <> nil do
    if (cur^.info = 'b') or (cur^.info = 'r') then
      DeleteCurrent(list, prev, cur)
      else
      begin
        prev:= cur;
        cur:= cur^.next;
      end;
end;

procedure Search (list: TList; var first, last: PElem);
var
  p: PElem;
begin
  first:= nil;
  last:= nil;
  p:= list.first;
  while p <> nil do
  begin
    if (p^.info = 'b') or (p^.info = 'r') then
      begin
      first:= p;
      break;
      end;
    p:= p^.next;
  end;
end;

procedure InputList(f: TextFile; var list: TList);
var
  info: TInfo;
begin
  while not eof(f) do
    begin
      read(f, info);
      AddToEnd(list, info);
    end;
end;

procedure InputListCondition(f: TextFile; var list: TList);
var
  info: TInfo;
begin
  while not eof(f) do
  begin
    read(f, info);
    AddCondition(list, info);
  end;
end;

procedure OutputList (var f: TextFile; list: TList);
var
  p: PElem;
begin
  p:= list.first;
  while p <> nil do
  begin
    write(f, p^.info, ' ');
    p:= p^.next;
  end;
  writeln(f);
end;

end.