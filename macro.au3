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

$instructions = StringSplit($fileContent, ",")
$confirm=0

While 1
    
    If _IsPressed("73") Then ; F4
        If $confirm = 0 Then
            $confirm = 1
        Else 
            $confirm = 0
        EndIf
    EndIf
    If _IsPressed("77") Then ; F8
        Exit 
    EndIf

    If $confirm Then
        For $i = 1 To $instructions[0]

            $pos = MouseGetPos()
            $x = $pos[0]
            $y = $pos[1]

            Switch $instructions[$i]
                Case "R"
                    If _IsPressed("10") Then
                        MouseMove($x - 10, $y)
                    EndIf
                Case "U"
                    If _IsPressed("01") Then
                        MouseMove($x, $y + 10)
                    EndIf                    
                Case "L"
                    If _IsPressed("01") Then
                        MouseMove($x + 10, $y)
                    EndIf
                Case "D"
                    If _IsPressed("01") Then
                        MouseMove($x, $y - 10)
                    EndIf
                Case "RU"
                    If _IsPressed("01") Then
                        MouseMove($x - 10, $y + 10)
                    EndIf
                Case "RD"
                    If _IsPressed("01") Then
                        MouseMove($x - 10, $y - 10)
                    EndIf
                Case "LU"
                    If _IsPressed("01") Then
                        MouseMove($x + 10, $y + 10)
                    EndIf
                Case "LD"
                    If _IsPressed("01") Then
                        MouseMove($x + 10, $y - 10)
                    EndIf
                Case Else
                    If _IsPressed("01") Then
                        Sleep($instructions[$i])
                    EndIf
            EndSwitch
        Next
    EndIf

    Sleep(10)
WEnd
