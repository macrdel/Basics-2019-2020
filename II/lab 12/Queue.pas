unit Queue; //очередь
interface

type
  TInfo = char;
  
  TQueue = record
    queue: array of TInfo;
    n: integer;
  end;

procedure Initialize (var queue: TQueue); //инициализация и очистка очереди
function IsEmpty (queue: TQueue): boolean; //проверка на пустоту
procedure Add (var queue: TQueue; info: TInfo); //добавление нового элемента в конец очереди
function Get (var queue: TQueue): TInfo; //изъятие (и удаление) элемента из конца очереди

implementation

procedure Initialize (var queue: TQueue);
begin
  queue.n:= 0;
  SetLength(queue.queue,0);
end;

function IsEmpty (queue: TQueue): boolean;
begin
  result:= queue.n = 0;
end;

procedure Add (var queue: TQueue; info: TInfo);
begin
  queue.n:= queue.n + 1;
  SetLength(queue.queue, queue.n);
  queue.queue[queue.n - 1]:= info;
end;

function Get (var queue: TQueue): TInfo;
begin
  if queue.n <> 0 then
  begin
    result:= queue.queue[0];
    for i: integer:= 0 to queue.n - 2 do
      queue.queue[i]:= queue.queue[i + 1];
    queue.n:= queue.n - 1;
    SetLength(queue.queue, queue.n);
  end;
end;

end.