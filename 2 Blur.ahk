SetBatchlines,-1
;Init
#Include <gdip>
pToken:=gdip_startup()
Count:=30
LoadedImage:=Gdip_CreateBitmapFromFile("Test.jpg")
W:=Gdip_GetImageWidth(LoadedImage)
H:=Gdip_GetImageHeight(LoadedImage)
;GUI
Gui,add, Text,% "x0 y0 w" w " h" h " hwndDrawArea",Loading...
Gui,Show,% "w" w " h" h
;GDI to GUI stuff
OnMessage(0xf,"Redraw")
DrawAreaDC:=GetDC(DrawArea)
GDrawArea:=gdip_graphicsfromHDC(DrawAreaDC)
BufferBitmap:=Gdip_CreateBitmap(w,h)
BufferGraphics:=gdip_GraphicsfromImage(BufferBitmap)
Gdip_DrawImage(BufferGraphics, LoadedImage) 
Loop % Count
Gdip_DrawImage(BufferGraphics, LoadedImage,A_Index,0,W-A_Index,H,0,0,W-A_Index,H,"1,0,0,0,0|0,1,0,0,0|0,0,1,0,0|0,0,0," 1/(A_Index+1) ",0|0,0,0,0,1")
Redraw()
return

Redraw(){
Global
Gdip_DrawImage(GDrawArea, BufferBitmap)
}
GuiClose:
ExitApp