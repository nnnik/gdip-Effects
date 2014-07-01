SetBatchlines,-1
#SingleInstance,Force
Gui,add,picture,hwndhwnd,Test.jpg
If !Gdip_startup()
    Msgbox % "GDI+ lib wurde leider nicht gefunden" 
LoadedImage:=Gdip_CreateBitmapFromFile("Test.jpg")
HDC:=GetDC(hwnd+0)
G:=Gdip_GraphicsFromHDC(HDC)
OnMessage(0xF,"WM_Paint")
W:=Gdip_GetImageWidth(LoadedImage)
H:=Gdip_GetImageHeight(LoadedImage)
Loop 5
{
    X:=A_Index
    Loop 5
        Gui,add,Edit,% "x" . (X*40-20) . " y" . (H-16+24*A_Index) . " w30 h20 vMatrix" . X . A_Index,% (X=A_Index)
}
oldmatrix:="1|0|0|0|0|0|1|0|0|0|0|0|1|0|0|0|0|0|1|0|0|0|0|0|1"
Gui,Add,Button,x19 w192 h30 gPress,Test
Gui,Show
return

Press:
oldmatrix:=CreateMatrix()
Gdip_GraphicsClear(G, 0)
Gdip_DrawImage(G, LoadedImage, "", "", "", "", "", "", "", "", oldmatrix)
return 

F7::
MatrixToGui(oldmatrix:=Clipboard)
GoSub,Press
return

F8::
Clipboard:=oldmatrix
return

GuiClose:
ExitApp


WM_Paint()
{
global
Critical
Gdip_DrawImage(G, LoadedImage, "", "", "", "", "", "", "", "", oldmatrix)
}

CreateMatrix()
{
Global
Gui,Submit,NoHide
ret:=""
Loop 5
{
    X:=A_Index
    Loop 5
        ret.= Matrix%X%%A_Index% . "|"
}
StringTrimRight,ret,ret,1
return ret
}

MatrixToGui(Matrix)
{
nr:=1
Loop 5
{
    X:=A_Index
    Loop 5
    {
        nr:=RegexMatch(Matrix,"(?:[^\d\-\+]?([\+\-]?[\d]+\.?[\d]*)[^\d]?)",Out,nr+strlen(out))
        GuiControl,,Matrix%X%%A_Index%,% Out1
    }
}
}