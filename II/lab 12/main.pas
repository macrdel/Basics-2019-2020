program Lab12;

uses StackMas, Queue, Deck;

var st: TStack; //стек
    q: TQueue;  //очередь 
    d: TDeck;   //дек
    fin, fout: TextFile;

procedure InputInStack (var stack: TStack; f: TextFile);
var 
  ch: TInfo;
begin
  while not eof(f) do
  begin
  readln(f, ch);
  Push(stack, ch);
  end;
end;

procedure InputInQueue (var queue: TQueue; f: TextFile);
var
  ch: TInfo;
begin
  while not eof(f) do
  begin
    readln(f, ch);
    Add(queue, ch);
  end;
end;

procedure InputInDeck (var deck: TDeck; f: TextFile);
var
  ch: TInfo;
  k: integer;
begin
  k:= 0;
  while not eof(f) do
  begin
    readln(f, ch);
    inc(k);
    if k mod 2 = 0 then
      AddToBegin(deck, ch)
      else
       AddToEnd(deck, ch);
  end;
end;

procedure OutputStack (var stack: TStack; f: TextFile);
var
  ch: TInfo;
  stack2: TStack;
begin
  writeln(f);
  Initialize(stack2);
  while not IsEmpty(stack) do
  begin
    ch:= Pop(stack);
    Push(stack2, ch);
  end;
  stack:= stack2;
  while not IsEmpty(stack2) do
  begin
    ch:= Pop(stack2);
    write(f, ch, ' ');
  end;
  writeln(f);
end;

procedure OutputQueue (var queue: TQueue; f: TextFile);
var
  ch: TInfo;
  queue2: Tqueue;
begin
  writeln(f);
  Initialize(queue2);
  while not IsEmpty(queue) do
  begin
    ch:= Get(queue);
    Add(queue2, ch);
  end;
  queue:= queue2;
  while not IsEmpty(queue2) do
  begin
    ch:= Get(queue2);
    write(f, ch, ' ');
  end;
  writeln(f);
end;

procedure OutputDeck (var deck: TDeck; f: TextFile);
var
  ch: TInfo;
  deck2: TDeck;
begin
  writeln(f);
  Initialize(deck2);
  while not IsEmpty(deck) do
  begin
    ch:= GetFromEnd(deck);
    AddToBegin(deck2, ch);
  end;
  deck:= deck2;
  while not IsEmpty(deck2) do
  begin
    ch:= GetFromEnd(deck2);
    write(f, ch, ' ');
  end;
  writeln(f);
end;

procedure DeleteElementsStack(var stack: TStack);
var
  ch: TInfo;
  stack2: TStack;
begin
  Initialize(stack2);
  while not IsEmpty(stack) do
  begin
    ch:= Pop(stack);
    if not (ch = 'b') and not (ch = 'r') then
      Push(stack2, ch); 
  end;
  while not IsEmpty(stack2) do
  begin
    ch:= Pop(stack2);
    Push(stack, ch);
  end;
end;

procedure DeleteElementsQueue(var queue: TQueue);
var
  ch: TInfo;
  queue2: TQueue;
begin
  Initialize(queue2);
  while not IsEmpty(queue) do
  begin
    ch:= Get(queue);
    if not (ch = 'b') and not (ch = 'r') then
      Add(queue2, ch); 
  end;
  while not IsEmpty(queue2) do
  begin
    ch:= Get(queue2);
    Add(queue, ch);
  end;
end;

procedure DeleteElementsDeck(var deck: Tdeck);
var
  ch: TInfo;
  Deck2: TDeck;
begin
  Initialize(deck2);
  while not IsEmpty(deck) do
  begin
    ch:= GetFromEnd(deck);
    if not (ch = 'b') and not (ch = 'r') then
      AddToBegin(Deck2, ch); 
  end;
  while not IsEmpty(Deck2) do
  begin
    ch:= GetFromEnd(Deck2);
    AddToBegin(deck, ch);
  end;
end;

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

//Обработка стека 
Initialize(st);
InputInStack(st, fin);
CloseFile(fin);
OutputStack(st, fout);
writeln(fout, 'Ввели данные из файла в стек ');

Push(st, 'g'); 
Push(st, 'f');
OutputStack(st, fout);
writeln(fout, 'Добавили в стек сначала "g", а потом "f", затем изъяли из стека сначала ', Pop(st), '  , а потом ', Pop(st));
OutputStack(st, fout);

DeleteElementsStack(st);
OutputStack(st, fout);
writeln(fout, 'Удалили из стека все элементы "b" и "r"');


//Обработка очереди
Initialize(q);
Reset(fin);
InputInQueue(q, fin);
CloseFile(fin);
OutputQueue(q, fout);
writeln(fout, 'Ввели данные из файла в очередь ');

Add(q, 'g'); 
Add(q, 'f');
OutputQueue(q, fout);
writeln(fout, 'Добавили в очередь сначала "g", а потом "f", затем изъяли из очереди сначала ', Get(q), '  , а потом ', Get(q));
OutputQueue(q, fout);

DeleteElementsQueue(q);
OutputQueue(q, fout);
writeln(fout, 'Удалили из очереди все элементы "b" и "r"');

//Обработка дека
Initialize(d);
Reset(fin);
InputInDeck(d, fin);
CloseFile(fin);
OutputDeck(d, fout);
writeln(fout, 'Ввели данные из файла в дек ');

AddToBegin(d, 'g'); 
AddToEnd(d, 'f');
OutputDeck(d, fout);
writeln(fout, 'Добавили в дек в начало "g", а в конец "f", затем изъяли из очереди из начала ', GetFromBegin(d), '  , а из конца ', GetFromEnd(d));
OutputDeck(d, fout);

DeleteElementsDeck(d);
OutputDeck(d, fout);
writeln(fout, 'Удалили из дека все элементы "b" и "r"');


CloseFile(fout);
end.