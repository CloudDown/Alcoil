#include <Misc.au3>
$file = FileOpen("mousemoove.txt", 0)
If $file = -1 Then
    ConsoleWrite("Erreur : Impossible d'ouvrir le fichier.")
    Exit
EndIf

$fileContent = FileReadLine($file)
FileClose($file)

If $fileContent = "" Then
    ConsoleWrite("Avertissement : Le fichier est vide.")
    Exit
EndIf

Global $instructions = StringSplit($fileContent, ",")
Global $confirm = 0
Global $power = 30
Global $fast = 15
$place = MouseGetPos()

Func SmoothMouseMove($xDest, $yDest, $speed=$fast)
    If $speed  = -1 Then
        MouseMove($xDest, $yDest)
    Else
        Local $xStart = MouseGetPos()[0]
        Local $yStart = MouseGetPos()[1]
        
        Local $xStep = ($xDest - $xStart) / $speed
        Local $yStep = ($yDest - $yStart) / $speed
        
        For $i = 1 To $speed
            MouseMove($xStart + ($xStep * $i), $yStart + ($yStep * $i), 0)
            Sleep(10) ; Ajustez la durée de pause pour contrôler la vitesse
        Next
    EndIf
EndFunc
While 1
    If _IsPressed("73") Then ; F4
        $confirm = Not $confirm
        ; Attendre que la touche F4 soit relâchée pour éviter des basculements répétés
        While _IsPressed("73")
            Sleep(100)
        WEnd
    EndIf
    If _IsPressed("77") Then ; F8
        Exit
    EndIf
    While $confirm
        If _IsPressed("73") Then ; F4
            $confirm = Not $confirm
            ; Attendre que la touche F4 soit relâchée pour éviter des basculements répétés
            While _IsPressed("73")
                Sleep(100)
            WEnd
        EndIf
        If _IsPressed("77") Then ; F8
            Exit
        EndIf

        For $i = 0 To UBound($instructions) - 1
            $pos = MouseGetPos()
            $x = $pos[0]
            $y = $pos[1]

            Select
                Case $instructions[$i] = "R"
                    If _IsPressed("01") Then
                        SmoothMouseMove($x - $power, $y)
                    EndIf
                Case $instructions[$i] = "U"
                    If _IsPressed("01") Then
                        SmoothMouseMove($x, $y + $power)
                    EndIf                    
                Case $instructions[$i] = "L"
                    If _IsPressed("01") Then
                        SmoothMouseMove($x + $power, $y)
                    EndIf
                Case $instructions[$i] = "D"
                    If _IsPressed("01") Then
                        SmoothMouseMove($x, $y - $power)
                    EndIf
                Case $instructions[$i] = "RU"
                    If _IsPressed("01") Then
                        SmoothMouseMove($x - $power, $y + $power)
                    EndIf
                Case $instructions[$i] = "RD"
                    If _IsPressed("01") Then
                        SmoothMouseMove($x - $power, $y - $power)
                    EndIf
                Case $instructions[$i] = "LU"
                    If _IsPressed("01") Then
                        SmoothMouseMove($x + $power, $y + $power)
                    EndIf
                Case $instructions[$i] = "LD"
                    If _IsPressed("01") Then
                        SmoothMouseMove($x + $power, $y - $power)
                    EndIf
                Case $instructions[$i] = "W1"
                    If _IsPressed("01") Then
                            Sleep(1000)
                    EndIf
                Case $instructions[$i] = "W2"
                    If _IsPressed("01") Then
                            Sleep(500)
                    EndIf
                Case $instructions[$i] = "W3"
                    If _IsPressed("01") Then
                        Sleep(250)
                    EndIf
            EndSelect
        Next
        Sleep(10)
    WEnd

WEnd

