unit StackLst; //реализация стека на основе односвязанного списка
interface
type
  TInfo = char;
  PElem = ^TElem;
  TElem = record
    info: TInfo;
    next: Pelem;
  end;
  TStack = PElem;

procedure Initialize (var stack: TStack); //инициализация очистка стека
function IsEmpty (stack: Tstack): boolean; //проверка на пустоту
procedure Push (var stack: TStack; info: TInfo); //добавление нового элемента в стек
function Pop (var stack: Tstack): TInfo; //получение элемента из стека

implementation

procedure Initialize (var stack: TStack);
begin
  new(stack);
  stack:= nil;
end;

function IsEmpty (stack: Tstack): boolean;
begin
  result:= stack = nil;
end;

procedure Push (var stack: TStack; info: TInfo);
var
  p: PElem;
begin
  new(p);
  p^.info:= info;
  p^.next:= stack;
  stack:= p;
end;

function Pop (var stack: TStack): TInfo;
var
  p: Pelem;
begin
  if stack <> nil then
  begin
    Result:= stack^.info;
    p:= stack;
    stack:= stack^.next;
    dispose(p);
  end;
end;

end.