/*Wen Li
Rich Assessment Task
ICS 2O1
2-Player Battleships
Capable of keyboard input and mouse input
Started 11/01/10
Finished 20/01/10*/

var leave:string%Variable for inputting answers that require yes/no or two option inputs
var p1,p2:string%Name of player 1 and 2
var winner:string%Name of the winning player
var up,upc:int%Variables to get the appropriate x or y value of the coordinate charactersand  the integer that turns to those appropriate characters using ASCII
var d:int%Variable to determine the distance between the bow and stern of the ship
var xc:int%counter to store ship coordinates in an array as each one is inputted
var acx,acy:int%attack coordinates (x,y)
var n1,n2:int%counter to store attack coordinates in an array as each one is inputted
var x,y,button:int%three variables for the command "mousewhere" (x,y) coordinates and whether the mouse is clicked or not
var boomc1,boomc2:int%boom counter to count how many hits have each player made and when a winner should be determined
var st,ed:int%Starting array number and the ending array number of what "damage" array has been assigned to a ship to determine whether the ship has been sunk or not
var check,rep:boolean%booleans to check for if the ship's position is valid, if the attack coordinate is valid and not repeated
var second:boolean%boolean to check for if the checking of whether the attack coordinate is beside a sunken ship is done at the right time. Only the second time should it be checked
var showsink,keyboard:boolean%boolean to check if the user wants the game to show whether a ship has sunk or not and if the user wants to play the game in keyboard version or not
var music,ex:boolean%boolean to check if the user wants background music and to check for if the music should be turned off
var damage:array 1..36 of boolean%to check for if a specific coordinate has been hit
var kill:array 1..16 of boolean%to check for if a specific ship is sunk
var hit1:array 1..64 of boolean%to check for if the attempt to hit a ship is successful for player 1
var hit2:array 1..64 of boolean%to check for if the attempt to hit a ship is successful for player 2
var bow:array 1..16 of string%to store the location of the bow of the ships
var stern:array 1..16 of string%to store the location of the stern of the ships
var cox:array 1..36 of int%to store each x coordinate of the ships
var coy:array 1..36 of int%to store each y coordinate of the ships
var ac1:array 1..64 of string%to store each x attack coordinate of player 1
var ac2:array 1..64 of string%to store each x attack coordinate of player 2
var cht:array char of boolean%to check for if a key has been pressed

proc map%procedure to draw the grid
cls%clear the screen
up:=525%y value of where the coordinates of the letter is to be
upc:=65%ASCII integer value of letters
for x:1..8%repeat the loop once each from 1 to 8
Draw.Text(chr(upc), 275, up, Font.New ("Comic Sans MS:12"), white)%Draw the ASCII character using Comic Sans with size 12 and colour as white at coordinates (275, up)
up:=up-50%Decrease the variable value for each repetition of the loop
upc:=upc+1
end for%End the loop
drawline(250,100,250,550,white)%Draw a white line from (250,100) to (250,550)
drawline(300,100,300,550,white)
drawline(350,100,350,550,white)
drawline(400,100,400,550,white)
drawline(450,100,450,550,white)
drawline(500,100,500,550,white)
drawline(550,100,550,550,white)
drawline(600,100,600,550,white)
drawline(650,100,650,550,white)
drawline(700,100,700,550,white)
drawline(250,100,700,100,white)
drawline(250,150,700,150,white)
up:=325
upc:=49
for x:1..8
Draw.Text(chr(upc), up, 125, Font.New ("Comic Sans MS:12"), white)
up:=up+50
upc:=upc+1
end for
drawline(250,200,700,200,white)
drawline(250,250,700,250,white)
drawline(250,300,700,300,white)
drawline(250,350,700,350,white)
drawline(250,400,700,400,white)
drawline(250,450,700,450,white)
drawline(250,500,700,500,white)
drawline(250,550,700,550,white)
end map%end the procedure

proc ships1%Draw the already set up ships for player 1
if check=false then%Under the condition the boolean "check" is false, do the following
for dr:1..xc
drawfillbox(((cox(dr))-49)*50+300,-(coy(dr)-65)*50+500,(cox(dr)-49)*50+350,-(coy(dr)-65)*50+550,white)
end for
elsif check=true then%If check is not false and check is true do the following
for dr:1..xc-1
drawfillbox(((cox(dr))-49)*50+300,-(coy(dr)-65)*50+500,(cox(dr)-49)*50+350,-(coy(dr)-65)*50+550,white)
end for
end if%End the condition
end ships1

proc ships2%draw the already set up ships for player 2
if check=false then
for dr:19..xc
drawfillbox(((cox(dr))-49)*50+300,-(coy(dr)-65)*50+500,(cox(dr)-49)*50+350,-(coy(dr)-65)*50+550,white)
end for
elsif check=true then
for dr:19..xc-1
drawfillbox(((cox(dr))-49)*50+300,-(coy(dr)-65)*50+500,(cox(dr)-49)*50+350,-(coy(dr)-65)*50+550,white)
end for
end if
end ships2

proc drhit1%draw all the hits player 1 has made
for dr:1..n1-1
if hit1(dr)=true then
drawfillbox((ord(ac1(dr)(2))-49)*50+300,-(ord(ac1(dr)(1))-65)*50+500,(ord(ac1(dr)(2))-49)*50+350,-(ord(ac1(dr)(1))-65)*50+550,brightred)
elsif hit1(dr)=false then
drawfillbox((ord(ac1(dr)(2))-49)*50+300,-(ord(ac1(dr)(1))-65)*50+500,(ord(ac1(dr)(2))-49)*50+350,-(ord(ac1(dr)(1))-65)*50+550,79)
end if
end for
end drhit1

proc drhit2%draw all the hits player 2 has made
for dr:1..n2-1
if hit2(dr)=true then
drawfillbox((ord(ac2(dr)(2))-49)*50+300,-(ord(ac2(dr)(1))-65)*50+500,(ord(ac2(dr)(2))-49)*50+350,-(ord(ac2(dr)(1))-65)*50+550,brightred)
elsif hit2(dr)=false then
drawfillbox((ord(ac2(dr)(2))-49)*50+300,-(ord(ac2(dr)(1))-65)*50+500,(ord(ac2(dr)(2))-49)*50+350,-(ord(ac2(dr)(1))-65)*50+550,79)
end if
end for
end drhit2

proc drsink%draw the perimeter of the sinked ships
for draw:st..ed
if cox(draw)-49>0 then
drawfillbox(((cox(draw))-50)*50+300,-(coy(draw)-65)*50+500,(cox(draw)-50)*50+350,-(coy(draw)-65)*50+550,79)
if cox(draw)-1=ord(ac1(n1)(2)) and coy(draw)=ord(ac1(n1)(1))and second=true then
rep:=true
end if
end if
if cox(draw)-49<7 then
drawfillbox(((cox(draw))-48)*50+300,-(coy(draw)-65)*50+500,(cox(draw)-48)*50+350,-(coy(draw)-65)*50+550,79)
if cox(draw)+1=ord(ac1(n1)(2))and coy(draw)=ord(ac1(n1)(1))and second=true then
rep:=true
end if
end if
if coy(draw)-65>0 then
drawfillbox(((cox(draw))-49)*50+300,-(coy(draw)-66)*50+500,(cox(draw)-49)*50+350,-(coy(draw)-66)*50+550,79)
if coy(draw)-1=ord(ac1(n1)(1))and cox(draw)=ord(ac1(n1)(2))and second=true then
rep:=true
end if
end if
if coy(draw)-65<7 then
drawfillbox(((cox(draw))-49)*50+300,-(coy(draw)-64)*50+500,(cox(draw)-49)*50+350,-(coy(draw)-64)*50+550,79)
if coy(draw)+1=ord(ac1(n1)(1))and cox(draw)=ord(ac1(n1)(2))and second=true then
rep:=true
end if
end if
end for
end drsink

proc drsink1%draw the perimeter of the sinked ships for player 1
if damage(19)=true and damage(20)=true and damage(21)=true and damage(22)=true then
kill(9):=true
st:=19
ed:=22
drsink
end if
if damage(23)=true and damage(24)=true and damage(25)=true then
kill(10):=true
st:=23
ed:=25
drsink
end if
if damage(26)=true and damage(27)=true and damage(28)=true then
kill(11):=true
st:=26
ed:=28
drsink
end if
if damage(29)=true and damage(30)=true then
kill(12):=true
st:=29
ed:=30
drsink
end if
if damage(31)=true and damage(32)=true then
kill(13):=true
st:=31
ed:=32
drsink
end if
if damage(33)=true and damage(34)=true then
kill(14):=true
st:=33
ed:=34
drsink
end if
if damage(35)=true then
kill(15):=true
st:=35
ed:=35
drsink
end if
if damage(36)=true then
kill(16):=true
st:=36
ed:=36
drsink
end if
end drsink1

proc drsink2%draw the perimeter of the sinked ships for player 2
if damage(1)=true and damage(2)=true and damage(3)=true and damage(4)=true then
kill(1):=true
st:=1
ed:=4
drsink
end if
if damage(5)=true and damage(6)=true and damage(7)=true then
kill(2):=true
st:=5
ed:=7
drsink
end if
if damage(8)=true and damage(9)=true and damage(10)=true then
kill(3):=true
st:=8
ed:=10
drsink
end if
if damage(11)=true and damage(12)=true then
kill(4):=true
st:=11
ed:=12
drsink
end if
if damage(13)=true and damage(14)=true then
kill(5):=true
st:=13
ed:=14
drsink
end if
if damage(15)=true and damage(16)=true then
kill(6):=true
st:=15
ed:=16
drsink
end if
if damage(17)=true then
kill(7):=true
st:=17
ed:=17
drsink
end if
if damage(18)=true then
kill(8):=true
st:=18
ed:=18
drsink
end if
end drsink2

process backmusic%A process to play background music
loop%Conditional loop
exit when ex=true%only exit the loop when the boolean ex is equal to true
Music.PlayFile ("Duel of the Fates.wav")%Play the audio file "Duel of the Fates"
end loop%End the loop
end backmusic%End the process

process hit
Music.PlayFile("Hit.wav")
end hit

process miss
Music.PlayFile("Miss.wav")
end miss

process win
Music.PlayFile("Winning Hit.wav")
end win

process esc
loop
Input.KeyDown(cht)%check for if a key is pressed
if cht (chr (27)) then%Do the following if the pressed key is key 27 which is the escape key
quit%quit the program if escape button is pressed
end if
end loop
end esc

fork esc%Call the esc process which continuously check for if the user wants to quit the program without interfering with the program

setscreen("graphics:max;max,nobuttonbar")%Set the sreen in graphics mode with maximum screen size and without a button bar at the top
colourback(blue)%Set background colour as blue
colour(white)%Set text colour as white
cls
Draw.Text ("Welcome to Wen's BATTLESHIPS", maxx div 2-400, maxy div 2, Font.New ("Comic Sans MS:36"), white)
delay(3000)%pause the program for 3 seconds
cls
put"\n\n\n\n\nPlease visit the user's manual located in the same folder prior to playing"
Draw.Text ("Wen's BATTLESHIPS", maxx div 2-200, maxy-50, Font.New ("Comic Sans MS:20"), white)
put"\n\n\nPlayer 1, please enter your name "..
get p1:*%Aquire name of player 1
put"\n\nPlayer 2, please enter your name "..
get p2:*
loop
put"\n\nWould you like to play in keyboard mode or mouse mode (K/M)(k/m)?"
get leave
exit when leave="K"or leave="k"or leave="M"or leave="m"
put"INVALID INPUT"
end loop
if leave="K"or leave="k"then
keyboard:=true
elsif leave="M"or leave="m"then
keyboard:=false
end if
loop
put"\n\nWould you like the game to notify whether the ship has sunk or not?"
get leave
exit when leave="yes"or leave="Y"or leave="y"or leave="YES"or leave="no"or leave="N"or leave="n"or leave="NO"
put"INVALID INPUT"
end loop
if leave="yes"or leave="Y"or leave="y"or leave="YES"then
showsink:=true
elsif leave="no"or leave="N"or leave="n"or leave="NO"then
showsink:=false
end if
loop
put"\n\nWould you like background music?"
get leave
exit when leave="yes"or leave="Y"or leave="y"or leave="YES"or leave="no"or leave="N"or leave="n"or leave="NO"
put"INVALID INPUT"
end loop
if leave="yes"or leave="Y"or leave="y"or leave="YES"then
music:=true
else music:=false
end if
Input.Flush%Flushes out all keys being pressed

loop
cls
if music=true then
ex:=false
fork backmusic
end if
for s:1..36
cox(s):=0
coy(s):=0
end for
check:=false
xc:=1

if keyboard=true then
for s:1..16 %Ship Setup Loop
cls
if s=1 then
put p1,", you may set up your ships. Press any key to continue"..
loop
exit when hasch%exit the loop when a key is pressed
end loop
elsif s=9 then
put p2,", you may set up your ships. Press any key to continue"..
loop
exit when hasch
end loop
end if
Input.Flush
loop
map
if s<9 then
ships1
elsif s>8 then
ships2
end if
loop
if s=1or s=9then
put"Enter the locations for the battleship (4 units)"
d:=3
elsif s=2or s=10then
put"Enter the locations for cruiser 1 (3 units)"
d:=2
elsif s=3or s=11then
put"Enter the locations for cruiser 2 (3 units)"
d:=2
elsif s=4or s=12then
put"Enter the locations for destroyer 1 (2 units)"
d:=1
elsif s=5or s=13then
put"Enter the locations for destroyer 2 (2 units)"
d:=1
elsif s=6or s=14then
put"Enter the locations for destroyer 3 (2 units)"
d:=1
elsif s=7or s=15then
put"Enter the locations for submarine 1 (1 unit)"
d:=0
elsif s=8or s=16then
put"Enter the locations for submarine 2 (1 unit)"
d:=0
end if
check:=false
loop
loop
put"Please enter the location of the bow of the Ship "..
get bow(s)
exit when length(bow(s))=2%exit the loop when the length of the string bow(s) is 2
put"INVALID INPUT"
delay(500)
end loop
exit when bow(s)(1)>="A" and bow(s)(1)<="H" and bow(s)(2)>="1"and bow(s)(2)<="8"
put"INVALID INPUT"
delay(500)
end loop
loop
loop
put"Please enter the location of the stern of the Ship "..
get stern(s)
exit when length(stern(s))=2
put"INVALID INPUT"
delay(500)
end loop
exit when stern(s)(1)>="A" and stern(s)(1)<="H" and stern(s)(2)>="1"and stern(s)(2)<="8"
put"INVALID INPUT"
delay(500)
end loop
var bowchange1:int:=ord(bow(s)(1))
var bowchange2:int:=ord(bow(s)(2))
if bow(s)(1)=stern(s)(1)and ord(stern(s)(2))-ord(bow(s)(2))=d then
for ds:ord(bow(s)(2))-49..ord(stern(s)(2))-49
drawfillbox((bowchange2-49)*50+300,-(ord(bow(s)(1))-65)*50+500,(bowchange2-49)*50+350,-(ord(bow(s)(1))-65)*50+550,white)
cox(xc):=bowchange2
coy(xc):=ord(bow(s)(1))
xc:=xc+1
bowchange2:=bowchange2+1
end for
exit
elsif bow(s)(2)=stern(s)(2)and ord(stern(s)(1))-ord(bow(s)(1))=d then
for ds:ord(bow(s)(1))-65..ord(stern(s)(1))-65
drawfillbox((ord(bow(s)(2))-49)*50+300,-(bowchange1-65)*50+500,(ord(bow(s)(2))-49)*50+350,-(bowchange1-65)*50+550,white)
cox(xc):=(ord(bow(s)(2)))
coy(xc):=bowchange1
xc:=xc+1
bowchange1:=bowchange1+1
end for
exit
elsif bow(s)(1)=stern(s)(1)and ord(bow(s)(2))-ord(stern(s)(2))=d then
for ds:ord(stern(s)(2))-49..ord(bow(s)(2))-49
drawfillbox((bowchange2-49)*50+300,-(ord(bow(s)(1))-65)*50+500,(bowchange2-49)*50+350,-(ord(bow(s)(1))-65)*50+550,white)
cox(xc):=bowchange2
coy(xc):=ord(bow(s)(1))
xc:=xc+1
bowchange2:=bowchange2-1
end for
exit
elsif bow(s)(2)=stern(s)(2)and ord(bow(s)(1))-ord(stern(s)(1))=d then
for ds:ord(stern(s)(1))-65..ord(bow(s)(1))-65
drawfillbox((ord(bow(s)(2))-49)*50+300,-(bowchange1-65)*50+500,(ord(bow(s)(2))-49)*50+350,-(bowchange1-65)*50+550,white)
cox(xc):=ord(bow(s)(2))
coy(xc):=bowchange1
xc:=xc+1
bowchange1:=bowchange1-1
end for
exit
end if
put"Invalid ship size"
delay(1000)
cls
map
if s<9 then
ships1
elsif s>8 then
ships2
end if
end loop
check:=false
if s<9 then
for a:1..xc-d-2
for b:xc-d-1..xc-1
if cox(a)-1=cox(b) or cox(a)=cox(b) or cox(a)+1=cox(b)then
if coy(a)=coy(b)then
check:=true
xc:=xc-d-1
exit
end if
elsif coy(a)-1=coy(b) or coy(a)=coy(b) or coy(a)+1=coy(b)then
if cox(a)=cox(b)then
check:=true
xc:=xc-d-1
end if
end if
end for
exit when check=true
end for
elsif s>8 then
for a:19..xc-d-2
for b:xc-d-1..xc-1
if cox(a)-1=cox(b) or cox(a)=cox(b) or cox(a)+1=cox(b)then
if coy(a)=coy(b)then
check:=true
xc:=xc-d-1
exit
end if
elsif coy(a)-1=coy(b) or coy(a)=coy(b) or coy(a)+1=coy(b)then
if cox(a)=cox(b)then
check:=true
xc:=xc-d-1
end if
end if
end for
exit when check=true
end for
end if
exit when check=false
put"Invalid ship location"
delay(1000)
cls
map
if s<9 then
ships1
elsif s>8 then
ships2
end if
end loop
end for

boomc1:=0
boomc2:=0
rep:=false
n1:=1
n2:=1
for s:1..64
ac1(s):="1Q"
ac2(s):="1Q"
end for
for z:1..36
damage(z):=false
end for
for a:1..64
hit1(a):=false
hit2(a):=false
end for
cls
Draw.Text ("THE BATTLE BEGINS NOW!!!",maxx div 2-330, maxy div 2, Font.New ("Comic Sans MS:36"), white)
delay(2000)
ex:=true
Music.PlayFileStop
loop %Attack Loop
cls
Draw.Text (p1, maxx div 2-100, maxy div 2, Font.New ("Comic Sans MS:36"), white)
delay(1500)
loop %p1 Attack Loop
cls
map
if showsink=false then
drhit1
end if
if showsink=true then
second:=false
drsink1
drhit1
end if
exit when boomc1=18
put"Enter the coordinates of your attack "..
loop
loop
rep:=false
get ac1(n1)
if showsink=true then
second:=true
drsink1
drhit1
end if
exit when length(ac1(n1))=2
put"INVALID INPUT"
delay(1000)
end loop
for r:1..n1-1
if ac1(n1)=ac1(r)then
rep:=true
end if
end for
exit when ac1(n1)(1)>="A"and ac1(n1)(1)<="H"and ac1(n1)(2)>="1"and ac1(n1)(2)<="8"and rep=false
put"INVALID INPUT"
delay(1000)
end loop
acx:=ord(ac1(n1)(2))
acy:=ord(ac1(n1)(1))
for h:19..36
if acx=cox(h)and acy=coy(h)then
drawfillbox(((acx)-49)*50+300,-(acy-65)*50+500,(acx-49)*50+350,-(acy-65)*50+550,brightred)
fork hit
hit1(n1):=true
boomc1:=boomc1+1
damage(h):=true
exit
end if
end for
if hit1(n1)=false then
drawfillbox(((acx)-49)*50+300,-(acy-65)*50+500,(acx-49)*50+350,-(acy-65)*50+550,79)
fork miss
delay(500)
end if
n1:=n1+1
exit when hit1(n1-1)=false
put"Attack again - "..
end loop
exit when boomc1=18
cls
Draw.Text (p2, maxx div 2-100, maxy div 2, Font.New ("Comic Sans MS:36"), white)
delay(1500)
loop %p2 Attack Loop
cls
map
if showsink=false then
drhit2
end if
if showsink=true then
second:=false
drsink2
drhit2
end if
exit when boomc2=18
put"Enter the coordinates of your attack "..
loop
loop
rep:=false
get ac2(n2)
if showsink=true then
second:=true
drsink2
drhit2
end if
exit when length(ac2(n2))=2
put"INVALID INPUT"
delay(1000)
end loop
for r:1..n2-1
if ac2(n2)=ac2(r) then
rep:=true
end if
end for
exit when ac2(n2)(1)>="A"and ac2(n2)(1)<="H"and ac2(n2)(2)>="1"and ac2(n2)(2)<="8"and rep=false
put"INVALID INPUT"
delay(1000)
end loop
acx:=ord(ac2(n2)(2))
acy:=ord(ac2(n2)(1))
for h:1..18
if acx=cox(h)and acy=coy(h)then
drawfillbox(((acx)-49)*50+300,-(acy-65)*50+500,(acx-49)*50+350,-(acy-65)*50+550,brightred)
fork hit
hit2(n2):=true
boomc2:=boomc2+1
damage(h):=true
exit
end if
end for
if hit2(n2)=false then
drawfillbox(((acx)-49)*50+300,-(acy-65)*50+500,(acx-49)*50+350,-(acy-65)*50+550,79)
fork miss
delay(500)
end if
n2:=n2+1
exit when hit2(n2-1)=false
put"Attack again - "..
end loop
exit when boomc2=18
end loop

elsif keyboard=false then
for s:1..16 %Ship Setup Loop
cls
if s=1 then
put p1,", you may set up your ships. Click to continue"
loop
mousewhere(x,y,button)
exit when button=1
end loop
elsif s=9 then
delay(250)
put p2,", you may set up your ships. Click to continue"
loop
mousewhere(x,y,button)
exit when button=1
end loop
end if
Input.Flush
loop
map
if s<9 then
ships1
elsif s>8 then
ships2
end if
loop
if s=1or s=9then
put"Enter the locations for the battleship (4 units)"
d:=3
elsif s=2or s=10then
put"Enter the locations for cruiser 1 (3 units)"
d:=2
elsif s=3or s=11then
put"Enter the locations for cruiser 2 (3 units)"
d:=2
elsif s=4or s=12then
put"Enter the locations for destroyer 1 (2 units)"
d:=1
elsif s=5or s=13then
put"Enter the locations for destroyer 2 (2 units)"
d:=1
elsif s=6or s=14then
put"Enter the locations for destroyer 3 (2 units)"
d:=1
elsif s=7or s=15then
put"Enter the locations for submarine 1 (1 unit)"
d:=0
elsif s=8or s=16then
put"Enter the locations for submarine 2 (1 unit)"
d:=0
end if
check:=false

loop
put"Please CLICK the location of the bow of the Ship "
delay(250)
loop
mousewhere(x,y,button)
exit when button=1
end loop
bow(s):=chr(-((y-550)div 50)+65)+chr(((x-300)div 50)+49)
exit when bow(s)(1)>="A" and bow(s)(1)<="H" and bow(s)(2)>="1"and bow(s)(2)<="8"
put"INVALID POSITION"
delay(500)
end loop
loop
delay(250)
put"Please CLICK the location of the stern of the Ship "
loop
mousewhere(x,y,button)
exit when button=1
end loop
stern(s):=chr(-((y-550)div 50)+65)+chr(((x-300)div 50)+49)
exit when stern(s)(1)>="A" and stern(s)(1)<="H" and stern(s)(2)>="1"and stern(s)(2)<="8"
put"INVALID POSITION"
delay(500)
end loop
var bowchange1:int:=ord(bow(s)(1))
var bowchange2:int:=ord(bow(s)(2))
if bow(s)(1)=stern(s)(1)and ord(stern(s)(2))-ord(bow(s)(2))=d then
for a:ord(bow(s)(2))-49..ord(stern(s)(2))-49
drawfillbox((bowchange2-49)*50+300,-(ord(bow(s)(1))-65)*50+500,(bowchange2-49)*50+350,-(ord(bow(s)(1))-65)*50+550,white)
cox(xc):=bowchange2
coy(xc):=ord(bow(s)(1))
xc:=xc+1
bowchange2:=bowchange2+1
end for
exit
elsif bow(s)(2)=stern(s)(2)and ord(stern(s)(1))-ord(bow(s)(1))=d then
for a:ord(bow(s)(1))-65..ord(stern(s)(1))-65
drawfillbox((ord(bow(s)(2))-49)*50+300,-(bowchange1-65)*50+500,(ord(bow(s)(2))-49)*50+350,-(bowchange1-65)*50+550,white)
cox(xc):=(ord(bow(s)(2)))
coy(xc):=bowchange1
xc:=xc+1
bowchange1:=bowchange1+1
end for
exit
elsif bow(s)(1)=stern(s)(1)and ord(bow(s)(2))-ord(stern(s)(2))=d then
for a:ord(stern(s)(2))-49..ord(bow(s)(2))-49
drawfillbox((bowchange2-49)*50+300,-(ord(bow(s)(1))-65)*50+500,(bowchange2-49)*50+350,-(ord(bow(s)(1))-65)*50+550,white)
cox(xc):=bowchange2
coy(xc):=ord(bow(s)(1))
xc:=xc+1
bowchange2:=bowchange2-1
end for
exit
elsif bow(s)(2)=stern(s)(2)and ord(bow(s)(1))-ord(stern(s)(1))=d then
for a:ord(stern(s)(1))-65..ord(bow(s)(1))-65
drawfillbox((ord(bow(s)(2))-49)*50+300,-(bowchange1-65)*50+500,(ord(bow(s)(2))-49)*50+350,-(bowchange1-65)*50+550,white)
cox(xc):=ord(bow(s)(2))
coy(xc):=bowchange1
xc:=xc+1
bowchange1:=bowchange1-1
end for
exit
end if
put"Invalid ship size"
delay(500)
cls
map
if s<9 then
ships1
elsif s>8 then
ships2
end if
end loop
check:=false
if s<9 then
for a:1..xc-d-2
for b:xc-d-1..xc-1
if cox(a)-1=cox(b) or cox(a)=cox(b) or cox(a)+1=cox(b)then
if coy(a)=coy(b)then
check:=true
xc:=xc-d-1
exit
end if
elsif coy(a)-1=coy(b) or coy(a)=coy(b) or coy(a)+1=coy(b)then
if cox(a)=cox(b)then
check:=true
xc:=xc-d-1
end if
end if
end for
exit when check=true
end for
elsif s>8 then
for a:19..xc-d-2
for b:xc-d-1..xc-1
if cox(a)-1=cox(b) or cox(a)=cox(b) or cox(a)+1=cox(b)then
if coy(a)=coy(b)then
check:=true
xc:=xc-d-1
exit
end if
elsif coy(a)-1=coy(b) or coy(a)=coy(b) or coy(a)+1=coy(b)then
if cox(a)=cox(b)then
check:=true
xc:=xc-d-1
end if
end if
end for
exit when check=true
end for
end if
exit when check=false
put"Invalid ship location"
delay(500)
cls
map
if s<9 then
ships1
elsif s>8 then
ships2
end if
end loop
end for

boomc1:=0
boomc2:=0
rep:=false
n1:=1
n2:=1
for s:1..64
ac1(s):="1Q"
ac2(s):="1Q"
end for
for z:1..36
damage(z):=false
end for
for a:1..64
hit1(a):=false
hit2(a):=false
end for
cls
Draw.Text ("THE BATTLE BEGINS NOW!!!",maxx div 2-330, maxy div 2, Font.New ("Comic Sans MS:36"), white)
delay(2000)
ex:=true
Music.PlayFileStop
loop %Attack Loop
cls
Draw.Text (p1, maxx div 2-100, maxy div 2, Font.New ("Comic Sans MS:36"), white)
delay(1500)
loop %p1 Attack Loop
cls
map
if showsink=false then
drhit1
end if
if showsink=true then
second:=false
drsink1
drhit1
end if
delay(250)
exit when boomc1=18
put"CLICK the position of your attack "
loop
rep:=false
loop
mousewhere(x,y,button)
exit when button=1
end loop
ac1(n1):=chr(-((y-550)div 50)+65)+chr(((x-300)div 50)+49)
if showsink=true then
second:=true
drsink1
drhit1
end if
for r:1..n1-1
if ac1(n1)=ac1(r)then
rep:=true
end if
end for
exit when ac1(n1)(1)>="A"and ac1(n1)(1)<="H"and ac1(n1)(2)>="1"and ac1(n1)(2)<="8"and rep=false
put"INVALID POSITION"
delay(500)
end loop
acx:=ord(ac1(n1)(2))
acy:=ord(ac1(n1)(1))
for h:19..36
if acx=cox(h)and acy=coy(h)then
drawfillbox(((acx)-49)*50+300,-(acy-65)*50+500,(acx-49)*50+350,-(acy-65)*50+550,brightred)
fork hit
hit1(n1):=true
boomc1:=boomc1+1
damage(h):=true
exit
end if
end for
if hit1(n1)=false then
drawfillbox(((acx)-49)*50+300,-(acy-65)*50+500,(acx-49)*50+350,-(acy-65)*50+550,79)
fork miss
delay(500)
end if
n1:=n1+1
exit when hit1(n1-1)=false
put"Attack again - "..
delay(250)
end loop
exit when boomc1=18
cls
Draw.Text (p2, maxx div 2-100, maxy div 2, Font.New ("Comic Sans MS:36"), white)
delay(1500)
loop %p2 Attack Loop
cls
map
if showsink=false then
drhit2
end if
if showsink=true then
second:=false
drsink2
drhit2
delay(250)
end if
exit when boomc2=18
put"CLICK the position of your attack "
loop
rep:=false
loop
mousewhere(x,y,button)
exit when button=1
end loop
ac2(n2):=chr(-((y-550)div 50)+65)+chr(((x-300)div 50)+49)
if showsink=true then
second:=true
drsink2
drhit2
end if
for r:1..n2-1
if ac2(n2)=ac2(r) then
rep:=true
end if
end for
exit when ac2(n2)(1)>="A"and ac2(n2)(1)<="H"and ac2(n2)(2)>="1"and ac2(n2)(2)<="8"and rep=false
put"INVALID POSITION"
delay(500)
end loop
acx:=ord(ac2(n2)(2))
acy:=ord(ac2(n2)(1))
for h:1..18
if acx=cox(h)and acy=coy(h)then
drawfillbox(((acx)-49)*50+300,-(acy-65)*50+500,(acx-49)*50+350,-(acy-65)*50+550,brightred)
fork hit
hit2(n2):=true
boomc2:=boomc2+1
damage(h):=true
exit
end if
end for
if hit2(n2)=false then
drawfillbox(((acx)-49)*50+300,-(acy-65)*50+500,(acx-49)*50+350,-(acy-65)*50+550,79)
fork miss
delay(500)
end if
n2:=n2+1
exit when hit2(n2-1)=false
put"Attack again - "..
delay(250)
end loop
exit when boomc2=18
end loop
end if

fork win
loop
cls
map
if boomc1=18 then
winner:=p1+" WINS!!!"
if showsink=true then
drsink1
end if
drhit1
elsif boomc2=18 then
winner:=p2+" WINS!!!"
if showsink=true then
drsink2
end if
drhit2
end if
Draw.Text (winner, 250, maxy-100, Font.New ("Comic Sans MS:36"), white)
locate(maxrow-2,maxcol div 2-18)
put"Would you like to keep playing? "..
get leave
exit when leave="y"or leave="yes"or leave="Y"or leave="YES"or leave="n"or leave="no"or leave="N"or leave="NO"
put"INVALID INPUT"
end loop
exit when leave="n"or leave="no"or leave="N"or leave="NO"
end loop
quit
