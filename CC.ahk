#SingleInstance Force
#NoEnv

Global RememberOffsets := True
Global MouseDelay      := 50

Global XOffset         := -1
Global YOffset         := -1
Global Instructions    := []
Global StopLoop        := 0
Global ActivePage      := 0
Global ActiveGirlPage  := 20
Global ActiveJobPage   := 20

Global GirlPage        := 1
Global JobPage         := 2
Global HobbyPage       := 3
Global StatsPage       := 4
Global GirlActionTalk  := 1
Global GirlActionStats := 2
Global GirlActionGift  := 3
Global GirlActionDate  := 4

Global XOffsetInit     := 0
Global YOffsetInit     := 110
Global PageX           := [ 80, 210, 340, 460 ]
Global PageY           := 640
Global GirlX           := 100
Global GirlY           := [ 310, 410, 510 ]
Global GirlScrollBaseX := 190
Global GirlScrollBaseY := 300
Global GirlActionX     := 580
Global GirlActionY     := [ 285, 325, 365, 405 ]
Global GirlTapX        := 800
Global GirlTapY        := 330
Global GirlUpgradeX    := 890
Global GirlUpgradeY    := 570
Global GiftX           := [ 300, 450 ]
Global GiftY           := [ 340, 405, 470, 535 ]
Global GiftIncrX       := 482
Global GiftIncrY       := 288
Global GiftQtyIncrX    := 637
Global GiftQtyIncrY    := 462
Global GiftQtys        := [ 5, 10, 25, 50, 100, 1000, 10000 ]
Global GiftConfirmX    := 705
Global GiftConfirmY    := 420
Global DateX           := 350
Global DateY           := [ 350, 410, 470, 530 ]
Global DateDelays      := [ 250, 2000, 1000, 250 ]
Global DateConfirmX    := 705
Global DateConfirmY    := 420
Global DateAgainX      := 270
Global DateAgainY      := 550
Global DateCompleteX   := 700
Global DateCompleteY   := 550
Global JobX            := [ 400, 740 ]
Global JobY            := [ 320, 380, 440, 500, 560 ]
Global HobbyX          := [ 345, 575, 805 ]
Global HobbyY          := [ 325, 400, 475, 550 ]
Global ResetX          := 870
Global ResetY          := 460
Global ResetConfirmX   := 410
Global ResetConfirmY   := 535

SendMode, Event
SetWorkingDir, %A_ScriptDir%
Critical, Off
CoordMode, Mouse, Screen
SetMouseDelay, %MouseDelay%

MoveMouse(x, y, s := -1)
{
    x -= XOffsetInit
    y -= YOffsetInit
    x += XOffset
    y += YOffset
    if (s = -1)
        MouseMove, %x%, %y%
    Else
        MouseMove, %x%, %y%, %s%
}

ActivatePage(page)
{
    If (ActivePage != page)
    {
        MoveMouse(PageX[page], PageY)
        Click
        ActivePage := page
    }
}

ChooseGirl(index)
{
    ActivatePage(GirlPage)
    page := (index - 1) // 3 + 1
    If (page != ActiveGirlPage)
    {
        SetMouseDelay, 0
        scrollX := GirlScrollBaseX
        scrollY := GirlScrollBaseY + 48 * (ActiveGirlPage - 1)
        MoveMouse(scrollX, scrollY)
        Sleep 250
        Click, Down
        SendInput {Click, Down}
        Sleep 500
        MoveMouse(scrollX, scrollY + 48 * (page - ActiveGirlPage))
        Sleep 250
        SendInput {Click, Up}
        SetMouseDelay, %MouseDelay%
    }
    
    ;scrollX := GirlX + 20
    ;scrollY := GirlY[3] + 20
    ;If (page < ActiveGirlPage)
    ;{
    ;    MoveMouse(scrollX, scrollY)
    ;    Click, WheelUp, 20
    ;    Sleep, 50
    ;    Click, WheelUp
    ;    ActiveGirlPage := 1
    ;}
    ;pageOffset := page - ActiveGirlPage
    ;If (pageOffset > 0)
    ;{
    ;    Loop, % pageOffset
    ;    {
    ;        MoveMouse(scrollX, scrollY)
    ;        MouseClickDrag, Left, 0, 0, 0, -355, 5, R
    ;        Sleep, 50
    ;        If (StopLoop = 1)
    ;            Break
    ;    }
    ;}
    If (StopLoop = 1)
        Return
    y := GirlY[Mod(index - 1, 3) + 1]
    MoveMouse(GirlX, y)
    Sleep, 50
    Click
    ActiveGirlPage := page
}

GiveGift(index, n)
{
    ActivatePage(GirlPage)
    mIndex := Mod(index - 1, 8) + 1
    x := GiftX[Mod(mIndex - 1, 2) + 1]
    y := GiftY[(mIndex - 1) // 2 + 1]
    page := (index - 1) // 8
    While (n > 0)
    {
        If (StopLoop = 1)
            Break
        Sleep 50
        MoveMouse(GirlActionX, GirlActionY[GirlActionGift])
        Click
        Loop, %page%
        {
            MoveMouse(GiftIncrX, GiftIncrY)
            Click
        }
        MoveMouse(x, y)
        Click
        incCount := 0
        Loop, % GiftQtys.Length()
        {
            If (n >= GiftQtys[A_Index])
                incCount++
            Else
                Break
        }
        If (incCount > 0)
        {
            MoveMouse(GiftQtyIncrX, GiftQtyIncrY)
            Loop, %incCount%
                Click
        }
        MoveMouse(GiftConfirmX, GiftConfirmY)
        Click
        If (incCount = 0)
            n--
        Else
            n -= GiftQtys[incCount]
    }
}

GoOnDate(index, n)
{
    ActivatePage(GirlPage)
    MoveMouse(GirlActionX, GirlActionY[GirlActionDate])
    Click
    yVals := [ 230, 300, 370, 430 ]
    y := DateY[index]
    sVals := [ 250, 2000, 1000, 250 ]
    delay := DateDelays[index]
    MoveMouse(DateX, y)
    Click
    MoveMouse(DateConfirmX, DateConfirmY)
    Click
    Sleep, %delay%
    n--
    If (n > 0)
        MoveMouse(DateAgainX, DateAgainY)
    While (n > 0)
    {
        If (StopLoop = 1)
            Break
        Click
        Sleep, %delay%
        n--
    }
    MoveMouse(DateCompleteX, DateCompleteY)
    Click
}

ToggleJob(index)
{
    ActivatePage(JobPage)
    page := index > 10 ? 2 : 1
    scrollX := (JobX[1] + JobX[2]) // 2
    scrollY := JobY[1]
    If (page < ActiveJobPage)
    {
        MoveMouse(scrollX, scrollY)
        Click, WheelUp, 20
        ActiveJobPage := 1
    }
    If (page > ActiveJobPage)
    {
        MoveMouse(scrollX, scrollY)
        Click, WheelDown, 20
    }
    ActiveJobPage := page
    x := JobX[Mod(index - 1, 2) + 1]
    y := JobY[(index - 1) // 2 + 1 - (index > 10 ? 3 : 0)]
    MoveMouse(x, y)
    Click
}

ToggleHobby(index)
{
    ActivatePage(HobbyPage)
    x := HobbyX[(index - 1) // 4 + 1]
    y := HobbyY[Mod(index - 1, 4) + 1]
    MoveMouse(x, y)
    Click
}

Reset()
{
    ActivatePage(StatsPage)
    MoveMouse(ResetX, ResetY)
    Click
    Sleep, 50
    MoveMouse(ResetConfirmX, ResetConfirmY)
    Click
    Sleep, 10000
}

Accumulate(x, y, n)
{
    ActivatePage(GirlPage)
    MoveMouse(x, y)
    
    ; The thread won't exit until it finishes unless the mouse delay is 0
    ; I'm probably doing something wrong that's preventing it from exiting
    ; like I expect, but ¯\_(ツ)_/¯
    
    SetMouseDelay, 0
    Loop, %n%
    {
        Click
        If (StopLoop = 1)
            Break
        Sleep, %MouseDelay%
    }
    SetMouseDelay, %MouseDelay%
}

Tap(n)
{
    Accumulate(GirlTapX, GirlTapY, n)
}

Talk(n)
{
    Accumulate(GirlActionX, GirlActionY[GirlActionTalk], n)
}

Upgrade()
{
    ActivatePage(GirlPage)
    MoveMouse(GirlUpgradeX, GirlUpgradeY)
    Click
    Sleep, 50
    Click
    Sleep, 50
    Click
}

Wait(n)
{
    Sleep, %n%
}

ReadInstructions()
{
    Instructions := []
    Loop, Read, CC.txt
    {
        t := []
        Loop, Parse, A_LoopReadLine, %A_Space%
        {
            f := A_LoopField
            StringLower, f, f
            t.Push(f)
        }
        Instructions.Push(t)
    }
}

DoInstructions(reset)
{
    Loop, % Instructions.Length()
    {
        i := Instructions[A_Index]
        command := i[1]
        param1 := 1
        param2 := 1
        If (i.Length() > 1)
            param1 := i[2]
        If (i.Length() > 2)
            param2 := i[3]

        If (command = "stop")
        {
            StopLoop = 1
            Break
        }
        
        If (command = "wait")
            Wait(param1)
        If (command = "girl")
            ChooseGirl(param1)
        If (command = "job")
            ToggleJob(param1)
        If (command = "upgrade")
            Upgrade()
        If (command = "talk")
            Talk(param1)
        If (command = "hobby")
            ToggleHobby(param1)
        If (command = "gift")
            GiveGift(param1, param2)
        If (command = "date")
            GoOnDate(param1, param2)
            
        If (command = "reset" && reset = 1)
            Reset()
            
        If (StopLoop = 1)
            Break
    }
}

SetMouseOffsets(alert)
{
    MouseGetPos, x, y
    xOffset := x
    yOffset := y
    If (alert)
        MsgBox, Offsets Captured!
}

ResetStates()
{
    StopLoop := 0
    ActivePage := 0
    ActiveJobPage := 20
    ActivatePage(GirlPage)
    MoveMouse(GirlX + 20, GirlY[3] + 20)
    Click, WheelUp, 20
    Sleep, 50
    Click, WheelUp
    ActiveGirlPage := 1
}

LoopCC(reset)
{
    If (xOffset = -1 || yOffset = -1 || !RememberOffsets)
        SetMouseOffsets(False)
    ResetStates()
    ReadInstructions()
    Loop
    {
        DoInstructions(reset)
        If (StopLoop = 1 || reset != 1)
            Break
    }
}

StopCC()
{
    StopLoop := 1
}

Test()
{
    If (xOffset = -1 || yOffset = -1)
        SetMouseOffsets(False)
    ResetStates()
    ChooseGirl(2)
    ChooseGirl(6)
    ChooseGirl(8)
    ChooseGirl(5)
    ChooseGirl(11)
    ChooseGirl(2)
    ChooseGirl(12)
    ChooseGirl(1)
    ChooseGirl(7)
    ChooseGirl(3)
    ChooseGirl(13)
    ChooseGirl(9)
    ;Loop, 5
    ;{
    ;    Random, r, 1, 3
    ;    ChooseGirl(r)
    ;    MsgBox, %r%
    ;}
}

^+1::Test()
^+5::SetMouseOffsets(True)
^+8::LoopCC(0)
^+9::LoopCC(1)
^+0::StopCC()