unit DoublyLinkedList; //модуль для работы с двунаправленным (однонаправленным) списком

interface
type
TInfo = char;

PElem = ^TElem;

TElem = record
   info: TInfo;
   next, prev: PElem; //добавляем ещё и указатель на предыдущий элемент
end;

TList = record
   first, last: PElem;
end;

procedure Initialize (var list: TList); //процедура инициализация списка
function IsEmpty (list: Tlist): boolean; //функция проверки на пустоту
procedure AddToBegin (var list: TList; info: TInfo); //процедура добавление элемента в начало списка
procedure AddToEnd (var list: TList; info: TInfo); //процедура добавления элемента в конец списка
procedure AddAfterCurrent (var list: TList; cur: PElem; info: TInfo); //процедура добавления нового элемента ПОСЛЕ заданного
procedure AddBeforeCurrent (var list: TList; cur: PElem; info: TInfo); //процедура добавления нового элемента ПЕРЕД заданным
procedure DeleteFirst (var list: TList); //процедура удаления первого элемента из списка
procedure DeleteLast (var list: TList); //процедура удаления последнего элемента из списка
procedure DeleteCurrent (var list: TList; var cur: PElem); //процедура удаления заданного элемента списка
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
  p^.prev:= nil;
  if list.first = nil then //список пуст
    begin
    list.first:= p;
    list.last:= p;
    end
  else  //уже есть хотя бы один элемент
    begin 
    list.first^.prev:= p;
    list.first:= p;
    end;
end; 

procedure AddToEnd (var list: TList; info: TInfo);
var
  p: PElem;
begin
  new(p);
  p^.info:= info;
  p^.next:= nil;
  p^.prev:= list.last;
  if list.last = nil then //список пуст
    begin
    list.first:= p;
    list.last:= p;
    end
  else  //уже есть хотя бы один элемент
    begin 
    list.last^.next:= p;
    list.last:= p;
    end;
end;

procedure AddAfterCurrent (var list: TList; cur: PElem; info: TInfo);
var
  p: PElem;
begin
  if cur = nil then
    exit;
   new(p);
   p^.info:= info;
   if cur = list.last then //если заданный элемент последний
   begin
     p^.next:= nil;
     p^.prev:= list.last;
     list.last^.next:= p;
     list.last:= p;
   end
   else
   begin // cur <-> p <-> cur^.next
     cur^.next^.prev:= p;
     p^.next:= cur^.next;
     p^.prev:= cur;
     cur^.next:= p;
   end;
end;

procedure AddBeforeCurrent (var list: TList; cur: Pelem; info: TInfo);
var
  p: PElem;
begin
  if cur = nil then
    exit;
   new(p);
   p^.info:= info;
   if cur = list.first then //если заданный элемент первый
   begin
     p^.next:= list.first;
     p^.prev:= nil;
     list.first^.prev:= p;
     list.first:= p;
   end
   else //cur^.prev <-> p <-> cur
   begin
     cur^.prev^.next:= p;
     p^.next:= cur;
     p^.prev:= cur^.prev;
     cur^.prev:= p;
   end;
end;
 
procedure DeleteFirst (var list: TList);
var
  p: PElem;
begin
   if list.first = nil then //если нечего удалять
      exit;
   if list.first = list.last then //элемент единственный
   begin
     dispose(list.first);
     list.first:= nil;
     list.last:= nil;
   end
  else
  begin //более одного элемента
    p:= list.first;
    list.first:= list.first^.next;
    list.first^.prev:= nil;
    dispose(p);
  end;
end; 

procedure DeleteLast (var list: TList);
var
  p: PElem;
begin
   if list.last = nil then //если нечего удалять
      exit;
   if list.first = list.last then //элемент единственный
   begin
     dispose(list.last);
     list.first:= nil;
     list.last:= nil;
   end
  else
  begin
    p:= list.last;
    list.last:= list.last^.prev;
    list.last^.next:= nil;
    dispose(p);
  end;
end;

procedure DeleteCurrent (var list: TList; var cur: PElem);
var
  p: PElem;
begin
  if cur = nil then
    exit;
  if (cur = list.first) and (list.first = list.last) then //единственный элемент
  begin
    dispose(cur);
    list.first:= nil;
    list.last:= nil;
    cur:= nil;
  end
  else if cur = list.first then //удаляем первый
  begin
    list.first:= list.first^.next;
    list.first^.prev:= nil;
    dispose(cur);
    cur:= list.first;
  end
  else if cur = list.last then //удаляем последний
  begin
    list.last:= list.last^.prev;
    list.last^.next:= nil;
    dispose(cur);
    cur:= nil;
  end
  else //удаление из середины cur^.prev <-> cur <-> cur^.next
  begin
    cur^.prev^.next:= cur^.next;
    cur^.next^.prev:= cur^.prev;
    p:= cur^.next;
    dispose(cur);
    cur:= p;
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
  p: PElem;
begin
  p:= list.first;
  while p <> nil do
    if (p^.info = 'b') or (p^.info = 'r') then
       DeleteCurrent(list, p)
    else
       p:= p^.next;
end;

procedure Search (list: TList; var first, last: PElem);
var
  p: PElem;
begin
  first:= nil;
  last:= nil;
  p:= list.first; //первый ищем начиная с первого элемента - с начало
  while p <> nil do
  begin
    if (p^.info = 'b') or (p^.info = 'r') then
    begin
      first:= p;
      break;
    end;
    p:= p^.next;
  end;
  if first = nil then
    exit; //если нет первого, значит нет и последнего
  p:= list.last; //последний ищем начиная с последнего - с конца
  while p <> nil do
  begin
    if (p^.info = 'b') or (p^.info = 'r') then
    begin
      last:= p;
      break;
    end;
    p:= p^.prev;
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
  p:= list.last;
  while p <> nil do
  begin
    write(f, p^.info, ' ');
    p:= p^.prev;
  end;
  writeln(f);
end;

end.