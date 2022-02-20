unit Deck; //дек

interface
  type
  TInfo = char;
  
  TDeck = record
    deck: array of TInfo;
    n: integer;
  end;

procedure Initialize (var deck: TDeck); //инициализация и очистка дека
function IsEmpty (deck: TDeck): boolean; //проверка на пустоту
procedure AddToBegin (var deck: TDeck; info: TInfo); //добавление в начало дека
procedure AddToEnd (var deck: TDeck; info: TInfo); //добавление в конец дека
function GetFromBegin (var deck: TDeck): TInfo; //изъятие (и удаление) из начала дека
function GetFromEnd (var deck: TDeck): TInfo; //изъятие (и удаление) из конца дека

implementation

procedure Initialize (var deck: TDeck);
begin
  deck.n:= 0;
  SetLength(deck.deck,0);
end;

function IsEmpty (deck: TDeck): boolean;
begin
  result:= deck.n = 0;
end;

procedure AddToBegin (var deck: TDeck; info: TInfo);
begin
  deck.n:= deck.n + 1;
  SetLength(deck.deck, deck.n);
  for i: integer:= deck.n - 1 downto 1 do
    deck.deck[i]:= deck.deck[i - 1];
  deck.deck[0]:= info;
end;

procedure AddToEnd (var deck: TDeck; info: TInfo);
begin
  deck.n:= deck.n + 1;
  SetLength(deck.deck, deck.n);
  deck.deck[deck.n - 1]:= info;
end;

function GetFromBegin (var deck: TDeck): TInfo;
begin
  if deck.n <> 0 then
  begin
    result:= deck.deck[0];
    for i: integer:= 0 to deck.n -2 do
      deck.deck[i]:= deck.deck[i + 1];
    deck.n:= deck.n -1;
    SetLength(deck.deck, deck.n);
  end;
end;

function GetFromEnd (var deck: TDeck): TInfo;
begin
  if deck.n <> 0 then
  begin
    result:= deck.deck[deck.n -1];
    deck.n:= deck.n - 1;
    SetLength(deck.deck, deck.n);
  end;
end;

end.


