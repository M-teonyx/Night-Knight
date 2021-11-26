
// Project: simon grellneth test animation 
// Created: 2021-09-14

// show all errors

#include "functions.agc"
SetErrorMode(2)

// set window properties
SetWindowTitle( "N-K" )
SetWindowSize( 1024, 768, 0 )

// set display properties
SetVirtualResolution( 1024, 768 ) // doesn't have to match the window
SetOrientationAllowed( 1, 1, 1, 1 ) // allow both portrait and landscape on mobile devices
setsyncrate(60,0)
UseNewDefaultFonts( 1 ) // since version 2.0.22 we can use nicer default fonts
SetDefaultMagFilter(0)

global stena,stena2,avatar,stenaid,stena1,enemy

avatar=loadsprite("Dino.png")



setspriteanimation(avatar,24,24,24)
SetPhysicsGravity(0,300)
setspritesize(avatar,54,54)
playsprite(avatar,10,1,1,10)
setspriteposition(avatar,500,100)





enemy=loadsprite("enemy.png")

setspriteanimation(enemy,22,33,13)

setspritesize(enemy,54,54)
playsprite(enemy,10,1,1,13)
setspriteposition(enemy,350,445)



SetSpritePhysicsOn(avatar,2)
SetSpritePhysicsCanRotate( avatar, 0 ) 









helbar=createsprite(0)
setspritesize(helbar,100,20)
setspritecolor(helbar,255,0,0,255)
setspritepositionbyoffset(helbar,1000-50,30)



heart=loadsprite("life.png")
setspritesize(heart,150,130)
size=100
setspritepositionbyoffset(heart,1000,30)
setspritepositionbyoffset(heart,getspritexbyoffset(helbar),GetSpriteYByOffset(helbar)+1)



SetClearColor(169,169,169)




//SetPhysicsDebugOn()


tecol=createsprite(0)
setspritesize(tecol,24,1)
SetSpriteVisible(tecol,0)

tecol2=clonesprite(tecol)
setspritesize(tecol2,100,70)
emove=1.2


tiles=Loadimage("tilesdragongame.png")



CopyImage( 1, tiles, 0, 0, 32, 32 ) 
 
CopyImage( 2, tiles, 32, 0, 32, 32 )
 
CopyImage( 3, tiles, 0, 32, 32, 32 )
 
CopyImage( 4, tiles, 32, 32, 32, 32 )

line as string
x=0
y=0
firstTile=0
file= opentoread("level3.csv")
tiletotal=0
totalrawcubes=0
while FileEOF(file)=0
	
	
	
	line=ReadLine(file)
	for i=1 to CountStringTokens(line,",")
		n=val(GetStringToken(line,",",i))+1
		tiletotal=tiletotal+1
		if n>0
			tile=CreateSprite(n)
			SetSpritePosition(tile,x,y)
			setspritephysicson(tile,1)
			setspriteshape(tile,3)
			
			
			
			
			if n=1 or n=2
				totalrawcubes=totalrawcubes+1
				red=getspritecolorred(tile)
				green=getspritecolorgreen(tile)
				blue=getspritecolorblue(tile)
			endif
			
			
			
			
			if firstTile=0 then firstTile=tile	
		endif
		x=x+32
		
		
		
		
		
	next
	x=0
	y=y+32
	
endwhile
CloseFile(file)


trc=totalrawcubes
emove2=2

time as float=60.0
music = LoadMusicOGG( "music.ogg" )

playmusicogg(music,1)
enemy2 = CloneSprite(enemy)
setspriteposition(enemy2,350,540)
do
	
	time=time-0.0166666666666667
	print(time)
	print(trc)
	setspritex(enemy,getspritex(enemy)+emove)
	setspritex(enemy2,getspritex(enemy2)+emove2)
	SetSpritePositionByOffset(tecol,GetSpriteXByOffset(avatar),getspriteybyoffset(avatar)+20)
	SetSpritePositionByOffset(tecol2,GetSpriteXByOffset(avatar),getspriteybyoffset(avatar))




	//demage
	collision=0
	for t=firstTile to tile
		
		if GetSpriteCollision(t,tecol)
			collision=t 
			
		endif
		if GetSpriteCollision(t,tecol2) and getspriteybyoffset(t)<GetSpriteyByOffset(avatar) and (GetSpriteImageID(t)=1 or GetSpriteImageID(t)=2)
			setspritephysicsoff(t) 
		else
			setspritephysicson(t,1)
		endif
		if getspriteimageid(t)=3
			if getspritecollision(t,avatar) and size>0
				size=size-1
				setspritex(helbar,getspritex(helbar)+1)
			endif
		endif

	next
	if (GetspriteCollision(enemy,avatar) or GetspriteCollision(enemy2,avatar)) and size>0
		size=size-2
		setspritex(helbar,getspritex(helbar)+2)

	endif





	SetSpriteShape(avatar,3)
	move=0
    if getrawkeystate(27)
	   exit 
	endif
	if getspritex(enemy)>630
		
		emove=-1.2
		setspriteflip(enemy,1,0)
	endif
	if getspritex(enemy)<350
		emove=1.2
		setspriteflip(enemy,0,0)
	endif
	if getspritex(enemy2)>630
		emove2=-2
		setspriteflip(enemy2,1,0)
	endif
	if getspritex(enemy2)<350
		emove2=2
		setspriteflip(enemy2,0,0)
	endif
	if getrawkeystate(37)
	   SetSpritePhysicsVelocity(avatar,-150,GetSpritePhysicsVelocityY(avatar))
	   setspriteflip(avatar,1,0)
	   move=1


	endif
	print(collision)
	if getrawkeystate(39)
	   SetSpritePhysicsVelocity(avatar,150,GetSpritePhysicsVelocityY(avatar))
	   setspriteflip(avatar,0,0)
	   move=1

	endif
	if getrawkeystate(40)
	   setspritey(avatar,getspritey(avatar)+2.9)

	   

	endif
	
	if GetRawKeyPressed(38) and (collision>0 or getspritey(tecol)>760)
	   
	   skok=1

	endif
	
	
	
	
	if skok=1
		SetSpritePhysicsVelocity(avatar,GetSpritePhysicsVelocityX(avatar),-250)
		skok=0
	endif
	
	
	
	//vyfarbuj
	if collision>0
		if GetSpriteImageID(collision)=1 or GetSpriteImageID(collision)=2
			
			if getspritecolorred(collision)=red and getspritecolorgreen(collision)=green and getspritecolorblue(collision)=blue
				trc=trc-1
				setspritecolor(collision,0,255,0,255)
			endif
			

		else
			
		endif
	endif
	

    if move=0
        if GetSpritePlaying(avatar)
           StopSprite(avatar)
        endif
    else
        if GetSpritePlaying(avatar)=0
            ResumeSprite(avatar)
        endif
    endif

	
	


	
	
	
	

	

	setspritesize(helbar,size,20)
    Sync()
loop
