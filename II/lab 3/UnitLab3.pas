unit UnitLab3;

interface
type
 TCharSet = set of char;
 SetArray = array of TCharSet;
 func = function (setin: TCharSet): integer;

procedure GetSet (var setin: TCharset; var f: TextFile); 
procedure Get (var s: SetArray; var k: integer; var f: TextFile); 
function EvalHash1(setin: TCharSet): integer; 
function EvalHash2(setin: TCharSet): integer; 
function EvalHash3(setin: TCharSet): integer;
procedure CollsAndEquals (s: SetArray; k: integer; var n1, n2: integer; fu: func); 

implementation

procedure GetSet;
var
k: char;
begin
setin:= [];
while not Eoln(f) do 
begin
  Read(f, k);
  setin:= setin+[k];
end;
 Readln(f);
end;

procedure Get;
begin 
k:=0; 
while not Eof(f) do 
begin 
  SetLength(s,k+1); 
  GetSet(s[k],f); 
  k:=k+1; 
end; 
end;

function EvalHash1: integer; 
var   
c: char; 
begin   
result := 0;   
foreach c in setin do     
  result := result + ord(c); 
end;

function EvalHash2: integer; 
var   
c: char; 
begin   
result := 67;   
foreach c in setin do   
begin
  if result = 0 then
     result := 67;     
  result := ord(c) mod result;   
end; 
end;

function EvalHash3: integer; 
var   
c: char;   
d: array [0..3] of integer;   
m: integer; 
begin   
d[0] := 11; d[1] := 29; d[2] := 53; d[3] := 67;   
m := 0;   
result := 0;   
foreach c in setin do   
  begin     
  result := result + ord(c) mod d[m mod 4]; 
  m := m + 1;   
  end; 
end;

procedure CollsAndEquals;       
var
i: integer;
j: integer;
begin
  n1:= 0; n2:= 0;
  for i:= 0 to k-2 do
    for j:=i+1 to k-1 do
      if fu(s[i]) = fu(s[j]) then
        begin
        n1:= n1+1;
        if s[i] = s[j] then
          n2:= n2+1;
        end;
end;

end.



