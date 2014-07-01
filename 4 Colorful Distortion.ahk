SetBatchlines,-1
;Init
#Include <gdip>
pToken:=gdip_startup()
LoadedImage:=Gdip_CreateBitmapFromFile("Test.jpg")
Gdip_LockBits(LoadedImage,0,0,Gdip_GetImageWidth(LoadedImage),Gdip_GetImageHeight(LoadedImage),LoadedStride,LoadedScan0,LoadedBitmapData)
W:=Gdip_GetImageWidth(LoadedImage)
H:=Gdip_GetImageHeight(LoadedImage)
;GUI
Gui,add, Text, x20 y20 w%w% h%h% hwndDrawArea,Loading...
Gui,Show,% "w" w+40 " h" h+40
;GDI to GUI stuff
DrawAreaDC:=GetDC(DrawArea)
GDrawArea:=gdip_graphicsfromHDC(DrawAreaDC)
BufferBitmap:=Gdip_CreateBitmap(w,h)
BufferGraphics:=gdip_GraphicsfromImage(BufferBitmap)
Gdip_LockBits(BufferBitmap,0,0,W,H,BufferStride,BufferScan0,BufferBitmapData)



Startup:
diff:= 30
max:=0xff-diff
running:=1
Loop,% W
{
x:=A_Index-1	
	Loop,% H
	{
		Gdip_FromARGB(Gdip_GetLockBitPixel(LoadedScan0, X, A_Index-1, LoadedStride), A, R, G, B)
		Random,_R,-diff,diff
		Random,_G,-diff,diff
		Random,_B,-diff,diff
		R:=m(R,diff,max)
		G:=m(G,diff,max)
		B:=m(B,diff,max)
		Gdip_SetLockBitPixel(Gdip_ToARGB(A,R+_R,G+_G,B+_B), BufferScan0, X, A_Index-1, BufferStride)
	}
}

Loop{
Gdip_UnlockBits(BufferBitmap, BufferBitmapData)
Gdip_DrawImage(GDrawArea, BufferBitmap)
Gdip_LockBits(BufferBitmap,0,0,W,H,BufferStride,BufferScan0,BufferBitmapData)
Loop,10000{
Random,X,0,W-1
Random,Y,0,H-1
Gdip_FromARGB(Gdip_GetLockBitPixel(LoadedScan0, X, Y, LoadedStride), A, R, G, B)
Random,_R,-diff,diff
Random,_G,-diff,diff
Random,_B,-diff,diff
R:=m(R,diff,max)
G:=m(G,diff,max)
B:=m(B,diff,max)
Gdip_SetLockBitPixel(Gdip_ToARGB(A,R+_R,G+_G,B+_B), BufferScan0, X, Y, BufferStride)
}
}




GuiClose:
ExitApp



M(byref value,min,max)
{
	If (value<min)
		value:=min
	Else If (value>max) 
		value:=max
	return value
}