unit StackMas; //реализация стека на основе динамического массива 
interface
type
  TInfo = char;
  
  TStack = record
     stack: array of TInfo;
     n: integer;
  end;

procedure Initialize (var stack: TStack); //инициализация очистка стека
function IsEmpty (stack: Tstack): boolean; //проверка на пустоту
procedure Push (var stack: TStack; info: TInfo); //добавление нового элемента в стек
function Pop (var stack: Tstack): TInfo; //получение элемента из стека

implementation

procedure Initialize (var stack: TStack);
begin
  stack.n:= 0;
  SetLength(stack.stack, 0);
end;

function IsEmpty (stack: Tstack): boolean;
begin
  result:= stack.n = 0;
end;

procedure Push (var stack: TStack; info: TInfo);
begin
  stack.n:= stack.n + 1;
  SetLength(stack.stack, stack.n);
  stack.stack[stack.n - 1]:= info;
end;

function Pop (var stack: Tstack): TInfo;
begin
  if stack.n <> 0 then
  begin
    result:= stack.stack[stack.n - 1];
    stack.n:= stack.n - 1;
    SetLength(stack.stack, stack.n);
  end;
end;

end.