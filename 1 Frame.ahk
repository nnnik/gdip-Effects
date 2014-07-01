SetBatchlines,-1
;Init
#Include <gdip>
pToken:=gdip_startup()
LoadedImage:=Gdip_CreateBitmapFromFile("Test.jpg")
W:=Round((apw:=Gdip_GetImageWidth(LoadedImage))*1.2,0)
H:=Round((aph:=Gdip_GetImageHeight(LoadedImage))*1.2,0)
;GUI
Gui,add, Text, x0 y0 w%w% h%h% hwndDrawArea,Loading...
Gui,Show,% "w" w " h" h
;GDI to GUI stuff
DrawAreaDC:=GetDC(DrawArea)
GDrawArea:=gdip_graphicsfromHDC(DrawAreaDC)
BufferBitmap:=Gdip_CreateBitmap(w,h)
BufferGraphics:=gdip_GraphicsfromImage(BufferBitmap)
Gdip_DrawImage(BufferGraphics, LoadedImage,0,0,W,H) ;Bild skaliert auf die BufferGraphics zeichnen
Gdip_DrawImage(BufferGraphics, LoadedImage,Round(apw*0.1,0),Round(aph*0.1,0),apw,aph)
Draw:
Gdip_DrawImage(GDrawArea, BufferBitmap)
return
GuiClose:
ExitApp