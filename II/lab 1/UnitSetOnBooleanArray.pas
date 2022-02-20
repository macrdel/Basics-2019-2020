unit UnitSetOnBooleanArray;

interface 

type 
TCharSet = array[0..255] of boolean; 

procedure Init(var s: TCharSet);

procedure Add(var s: TCharSet; ch: char);

function IsInSet(ch: char; const s: TCharSet): boolean;

function Union(const s1,s2: TCharSet): TCharSet;

function Intersection(const s1,s2: TCharSet): TCharSet;

function Difference(const s1,s2: TCharSet): TCharSet;

implementation 

procedure Init;
var 
i: integer; 
begin 
for i:=0 to 255 do 
s[i]:= false;
end;

procedure Add;
begin 
s[ord(ch)]:= true;
end; 

function IsInSet: boolean;
begin
result:= s[ord(ch)]
end;

function Union: TCharSet;
var 
i:byte;
begin 
for i:=0 to 255 do  
result[i]:= s1[i] or s2[i];
end; 

function Intersection: TCharSet;
var 
i:byte;
begin 
for i:=0 to 255 do 
result[i]:= s1[i] and s2[i];
end; 

function Difference: TCharSet;
var 
i:byte;
begin 
for i:=0 to 255 do  
result[i]:=s1[i] and not s2[i];
end; 

end.