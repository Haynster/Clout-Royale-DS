Scene = "Menu"
Menu = 0
GameRunning = 0

PlayerNames = {"dangerbitch", "hypeassfan", "fundoodle", "rxcode", "numberslore", "space", "erand", "nicenipple", "phobus", "gingerking", "abyss"}
Player1Icon = 0
Player2Icon = 0
Player3Icon = 0

Player1Clout = 0
Player2Clout = 0
Player3Clout = 0

Player2Name = 0
Player3Name = 0

IconsX = 32
winnertxtx = 0

Time = 120

icons = Sprite.new("sprites/iconsheet.png", 64, 64, VRAM) 
checkerboard = Image.load("sprites/checker.png", VRAM) 
desk = Image.load("sprites/desk.png", VRAM) 
ipadbg = Image.load("sprites/ipadbg.png", VRAM)
hackbg = Image.load("sprites/hackbg.png", VRAM)
timetext = Image.load("sprites/time.png", VRAM)   
logo = Image.load("sprites/logo.png", VRAM)  
YT = Image.load("sprites/yt.png", VRAM)  
TT = Image.load("sprites/tc.png", VRAM) 
buy = Image.load("sprites/buy.png", VRAM) 

timer = Timer.new()
timer:start()

function sleep(a) 
    sec = tonumber(timer:getTime() + a); 
    while (timer:getTime() < sec) do 
    end 
end

function ai()
    sleep(100)
    Time = Time - 0.1
    math.randomseed(timer:getTime())
    decision = math.random(1,200)
    if decision == 1 then
        Player2Clout = Player2Clout + math.random(1,3)
    elseif decision == 2 then
        if Player2Clout >= 500 then
            Player2Clout = Player2Clout - 500 -- increase timer
            Time = Time + Time / 4
        end
    elseif decision == 3 then
        if Player2Clout >= 500 then
            Player2Clout = Player2Clout - 500 -- decrease timer
            Time = Time - Time / 4
        end
    elseif decision == 4 then
        if Player2Clout >= 150 then
            Player2Clout = Player2Clout - 100
            playerchoice = math.random(1,2)
            if playerchoice == 1 then
                Player2Clout = Player2Clout + Player1Clout / 4
                Player1Clout = Player1Clout / 4
            elseif playerchoice == 2 then
                Player2Clout = Player2Clout + Player3Clout / 4
                Player3Clout = Player3Clout / 4
            end
        end
    elseif decision >= 5 then
        Player2Clout = Player2Clout + math.random(4,6)
    end

    math.randomseed(timer:getTime())
    decision = math.random(1,200)
    if decision == 1 then
        Player3Clout = Player3Clout + math.random(1,3)
    elseif decision == 2 then
        if Player3Clout >= 500 then
            Player3Clout = Player3Clout - 500 -- increase timer
            Time = Time + Time / 4
        end
    elseif decision == 3 then
        if Player3Clout >= 500 then
            Player3Clout = Player3Clout - 500 -- decrease timer
            Time = Time - Time / 4
        end
    elseif decision == 4 then
        if Player3Clout >= 100 then
            Player3Clout = Player3Clout - 100 -- steal clout
            playerchoice = math.random(1,2)
            if playerchoice == 1 then
                Player3Clout = Player3Clout + Player1Clout / 4
                Player1Clout = Player1Clout / 4
            elseif playerchoice == 2 then
                Player3Clout = Player3Clout + Player2Clout / 4
                Player2Clout = Player2Clout / 4
            end
        end
    elseif decision >= 5 then
        Player3Clout = Player3Clout + math.random(4,6)
    end
end

function findwinner()
    Winner = ""
    WinnerClout = 0
    WinnerIcon = 0

    if Player1Clout > WinnerClout then
        WinnerClout = Player1Clout
        Winner = dsUser.name
        WinnerIcon = Player1Icon
    end
    if Player2Clout > WinnerClout then
        WinnerClout = Player2Clout
        Winner = PlayerNames[Player2Name]
        WinnerIcon = Player2Icon
    end
    if Player3Clout > WinnerClout then
        WinnerClout = Player3Clout
        Winner = PlayerNames[Player3Name]
        WinnerIcon = Player3Icon
    end

    return(Winner)
end

while not Keys.newPress.Start do
    while Scene == "Menu" do
        Controls.read()

        if Keys.newPress.A then
            math.randomseed(timer:getTime())
            Player1Clout = 0
            Player2Clout = 0
            Player3Clout = 0
            Player2Icon = math.random(0,6)
            Player3Icon = math.random(0,6)
            Player2Name = math.random(1,11)
            Player3Name = math.random(1,11)
            GameRunning = 0
            Menu = 0
            Time = 120
            Scene = "Game"
        end

        if Keys.newPress.R then
            if Player1Icon == 6 then
                Player1Icon = 0
            else
                Player1Icon = Player1Icon + 1
            end
        end

        if Keys.newPress.L then
            if Player1Icon == 0 then
                Player1Icon = 6
            else
                Player1Icon = Player1Icon - 1
            end
        end

        screen.drawFillRect(SCREEN_UP, 0, 0, 256, 192, Color.new256(26, 28, 59))
        screen.blit(SCREEN_UP, 0, 0, checkerboard)
        screen.print(SCREEN_UP, 48, 176, "Press A to Enter a Game!!!")
        screen.blit(SCREEN_UP, 60, 24, logo)
        screen.drawFillRect(SCREEN_DOWN, 0, 0, 256, 192, Color.new256(26, 28, 59))
        screen.blit(SCREEN_DOWN, 0, 0, checkerboard)
        Image.setTint(checkerboard, Color.new256(37, 44, 77))
        icons:drawFrame(SCREEN_DOWN, 16, 112, Player1Icon)
        screen.print(SCREEN_DOWN, 84, 158, "Press L/R to Switch Icon")
        screen.print(SCREEN_DOWN, 10, 10, "Username: " .. dsUser.name)

        render()
    end

    while Scene == "Game" do
        Controls.read()

        screen.blit(SCREEN_UP, 0, 0, desk)
        if Menu == 0 then
            screen.blit(SCREEN_DOWN, 0, 0, ipadbg)
        else
            screen.blit(SCREEN_DOWN, 0, 0, hackbg)
        end
        screen.setAlpha(60)
        screen.drawFillRect(SCREEN_UP, 26, 110, 230, 192, Color.new256(0, 0, 0))
        screen.setAlpha(100)
        screen.blit(SCREEN_UP, 90, 4, timetext)

        if Keys.newPress.Select then
            GameRunning = 1
        end

        -- top stuff
        icons:drawFrame(SCREEN_UP, 0 + IconsX, 106, Player1Icon)
        icons:drawFrame(SCREEN_UP, 64 + IconsX, 106, Player2Icon)
        icons:drawFrame(SCREEN_UP, 128 + IconsX, 106, Player3Icon)
        screen.print(SCREEN_UP, 34, 170, dsUser.name, Color.new256(0, 187, 120))
        screen.print(SCREEN_UP, 34, 180, math.floor(Player1Clout), Color.new256(0, 187, 120))
        screen.print(SCREEN_UP, 98, 170, PlayerNames[Player2Name])
        screen.print(SCREEN_UP, 98, 180, math.floor(Player2Clout))
        screen.print(SCREEN_UP, 160, 170, PlayerNames[Player3Name])
        screen.print(SCREEN_UP, 160, 180, math.floor(Player3Clout))
        screen.print(SCREEN_UP, 112, 34, math.floor(Time))
        screen.print(SCREEN_UP, 0, 0, "Winning: " .. findwinner())

        if Time <= 0 then
            winnertxtx = 0
            Scene = "Winner"
        end

        if GameRunning == 1 then
            if Menu == 0 then
                screen.setAlpha(60)
                screen.drawFillRect(SCREEN_DOWN, 0, 175, 256, 192, Color.new256(0, 0, 0))
                screen.setAlpha(100)
                screen.print(SCREEN_DOWN, 44, 180, "Press L to open Hacker Menu")
                screen.blit(SCREEN_DOWN, 15, 15, YT)
                screen.print(SCREEN_DOWN, 78, 30, "TubeClout")
                screen.print(SCREEN_DOWN, 78, 45, "A")
                screen.blit(SCREEN_DOWN, 15, 79, TT)
                screen.print(SCREEN_DOWN, 78, 94, "TikClout")
                screen.print(SCREEN_DOWN, 78, 109, "B")
    
                if Keys.newPress.A then
                    Player1Clout = Player1Clout + math.random(1,3)
                end
    
                if Keys.newPress.B then
                    Player1Clout = Player1Clout + math.random(4,6)
                end
            elseif Menu == 1 then
                screen.blit(SCREEN_DOWN, 15, 15, buy)
                screen.print(SCREEN_DOWN, 85, 27, "Steal Clout - $100")
                screen.blit(SCREEN_DOWN, 15, 50, buy)
                screen.print(SCREEN_DOWN, 85, 62, "Increase Timer - $500")
                screen.blit(SCREEN_DOWN, 15, 85, buy)
                screen.print(SCREEN_DOWN, 85, 94, "Decrease Timer - $500")
                screen.setAlpha(60)
                screen.drawFillRect(SCREEN_DOWN, 0, 175, 256, 192, Color.new256(0, 0, 0))
                screen.setAlpha(100)
                screen.print(SCREEN_DOWN, 46, 180, "Press L to open Home Menu")

                if Keys.newPress.A then
                    Menu = 0
                end
    
                if Keys.newPress.B then
                    Menu = 0
                end

                if Stylus.released then
                    if Stylus.X > 15 and Stylus.X < 79 then
                        if Stylus.Y > 15 and Stylus.Y < 47 then
                            if Player1Clout >= 100 then
                                Player1Clout = Player1Clout - 100 -- steal clout
                                math.randomseed(timer:getTime())
                                randomplayerchoice = math.random(1,2)
                                if randomplayerchoice == 1 then
                                    Player1Clout = Player1Clout + Player2Clout / 4
                                    Player2Clout = Player2Clout / 4
                                elseif randomplayerchoice == 2 then
                                    Player1Clout = Player1Clout + Player3Clout / 4
                                    Player3Clout = Player3Clout / 4
                                end
                            end
                        end
                    end

                    if Stylus.X > 15 and Stylus.X < 79 then
                        if Stylus.Y > 50 and Stylus.Y < 114 then
                            if Player1Clout >= 500 then
                                Player1Clout = Player1Clout - 500 -- decrease timer
                                Time = Time + Time / 4
                            end
                        end
                    end

                    if Stylus.X > 15 and Stylus.X < 79 then
                        if Stylus.Y > 50 and Stylus.Y < 82 then
                            if Player1Clout >= 500 then
                                Player1Clout = Player1Clout - 500 -- increase timer
                                Time = Time - Time / 4
                            end
                        end
                    end
                end
            end

            if Keys.newPress.L then
                if Menu == 0 then
                    Menu = 1
                elseif Menu == 1 then
                    Menu = 0
                end
            end

            if Keys.newPress.A then
                Player1Clout = Player1Clout + math.random(1,3)
            end
            
            if Keys.newPress.B then
                Player1Clout = Player1Clout + math.random(4,6)
            end    

            ai()
        elseif GameRunning == 0 then
            screen.print(SCREEN_UP, 56, 86, "PRESS SELECT TO BEGIN!!!")
        end

        render()
    end

    while Scene == "Winner" do
        Controls.read()

        screen.drawFillRect(SCREEN_UP, 0, 0, 256, 192, Color.new256(99, 172, 255))
        screen.blit(SCREEN_UP, 0, 0, checkerboard)
        screen.drawFillRect(SCREEN_DOWN, 0, 0, 256, 192, Color.new256(99, 172, 255))
        screen.blit(SCREEN_DOWN, 0, 0, checkerboard)
        Image.setTint(checkerboard, Color.new256(88, 138, 219))
        screen.print(SCREEN_DOWN, 60, 92, "Press Select to Return")

        icons:drawFrame(SCREEN_UP, 96, 64, WinnerIcon)
        screen.setAlpha(60)
        screen.drawFillRect(SCREEN_UP, 0, 175, 256, 192, Color.new256(0, 0, 0))
        screen.setAlpha(100)
        winnertxtx = winnertxtx + 0.5
        if winnertxtx >= 256 then
            winnertxtx = 0
        end
        screen.print(SCREEN_UP, winnertxtx, 180, Winner .. " Wins!!")

        if Keys.newPress.Select then
            Scene = "Menu"
        end

        render()
    end
end

timer:stop()

Image.destroy(icons)
Image.destroy(checkerboard)
Image.destroy(desk)
Image.destroy(ipadbg)

icons = nil
checkerboard = nil
desk = nil
ipadbg = nil