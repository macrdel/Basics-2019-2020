unit UnitSetOnCharArray;

interface 

type 
TCharSet = array[0..255] of char;

procedure Init(var s: TCharSet);

function IsInSet(ch: char; const s: TCharSet): boolean;

procedure Add(var s: TCharSet; ch: char);

function Union(const s1,s2: TCharSet): TCharSet;

function Intersection(const s1,s2: TCharSet): TCharSet;

function Difference(const s1,s2: TCharSet): TCharSet;

implementation 

procedure Init; 
var 
i: integer; 
begin 
for i:=0 to 255 do 
s[i]:=chr(0); 
end; 

function IsInSet: boolean; 
var 
i:integer; 
begin 
result:=false; 
for i:=0 to 255 do 
if s[i]=ch then 
result:=true; 
end; 

procedure Add; 
var 
i:integer; 
begin 
i:=0; 
if not IsInSet(ch,s) then 
begin 
while s[i]<>chr(0) do 
i:=i+1; 
s[i]:=ch; 
end; 
end; 

function Union: TCharSet; 
var 
i: integer; 
begin 
result:=s1; 
for i:=0 to 255 do 
Add(result,s2[i]); 
end; 

function Intersection: TCharSet; 
var 
i:integer; 
begin 
Init(result); 
for i:=0 to 255 do 
if IsInSet(s2[i],s1) then 
Add(result, s2[i]); 
end; 

function Difference: TCharSet; 
var 
i:integer; 
begin 
Init(result); 
for i:=0 to 255 do 
if not IsInSet(s1[i],s2) then 
Add(result,s1[i]); 
end; 

end.