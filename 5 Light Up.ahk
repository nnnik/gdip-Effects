SetBatchlines,-1
OnMessage(0xF,"Redraw")
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
		Calc(A,R,G,B)
		Gdip_SetLockBitPixel(Gdip_ToARGB(A,R,G,B), BufferScan0, X, A_Index-1, BufferStride)
	}
}
Gdip_UnlockBits(BufferBitmap, BufferBitmapData)
Redraw()
return
Redraw()
{
global
Gdip_DrawImage(GDrawArea, BufferBitmap)
}


GuiClose:
ExitApp


Calc(byref A,byref R,byref G,byref B){
	If (V:=(R+G+B)/3)
	{
		RV:=R/V
		GV:=G/V
		BV:=B/V
		If (RV>GV)
			MV:=RV
		Else
			MV:=GV
		If (BV>MV)
			MV:=BV
		V:=255/MV
		R:=RV*V
		G:=GV*V
		B:=BV*V
	}
}

