IDENTIFICATION DIVISION.
PROGRAM-ID. IsopodGame.

DATA DIVISION.
WORKING-STORAGE SECTION.
01 Player-Location        PIC X(20).
01 Found-Hiding-Place     PIC X VALUE 'N'.
01 Found-Cookie           PIC X VALUE 'N'.
01 Found-IsopodFriend     PIC X VALUE 'N'.
01 User-Input             PIC X(20).
01 Game-Won-FLAG          PIC X VALUE 'N'.
01 Yes-FLAG               PIC X VALUE 'Y'.

PROCEDURE DIVISION.
Main-Loop.
    DISPLAY "Welcome to the Isopod Adventure!".
    PERFORM Initialize-Game.

    PERFORM UNTIL Game-Won-FLAG = Yes-FLAG
        DISPLAY "What would you like to do? (move/search/status/quit)"
        ACCEPT User-Input
        EVALUATE User-Input
            WHEN "move"
                PERFORM Move-Isopod
            WHEN "search"
                PERFORM Search-Area
            WHEN "status"
                PERFORM Display-Status
            WHEN "quit"
                PERFORM Quit-Game
            WHEN OTHER
                DISPLAY "Invalid action. Try again."
        END-EVALUATE
    END-PERFORM.

    PERFORM End-Game.
    STOP RUN.

Initialize-Game.
    MOVE "forest" TO Player-Location.
    DISPLAY "You are in the forest.".

Move-Isopod.
    DISPLAY "Where would you like to move? (forest/garden/cave)".
    ACCEPT User-Input.
    IF User-Input = "forest" OR User-Input = "garden" OR User-Input = "cave"
        MOVE User-Input TO Player-Location
        DISPLAY "You moved to the " Player-Location "."
    ELSE
        DISPLAY "You can't go there."
    END-IF.

Search-Area.
    IF Player-Location = "forest"
        IF Found-Hiding-Place = "N"
            DISPLAY "You found a nice place to hide!"
            MOVE "Y" TO Found-Hiding-Place
        ELSE
            DISPLAY "There's nothing new here."
        END-IF
    ELSE
        IF Player-Location = "garden"
            IF Found-Cookie = "N"
                DISPLAY "You found a cookie crumb!"
                MOVE "Y" TO Found-Cookie
            ELSE
                DISPLAY "There's nothing new here."
            END-IF
        ELSE
            IF Player-Location = "cave"
                IF Found-IsopodFriend = "N"
                    DISPLAY "You found another isopod friend!"
                    MOVE "Y" TO Found-IsopodFriend
                ELSE
                    DISPLAY "There's nothing new here."
                END-IF
            ELSE
                DISPLAY "You can't search here."
            END-IF
        END-IF
    END-IF.

    PERFORM Check-Game-Won.

Display-Status.
    DISPLAY "Status:".
    DISPLAY "Hiding Place Found: " Found-Hiding-Place.
    DISPLAY "Cookie Crumb Found: " Found-Cookie.
    DISPLAY "Isopod Friend Found: " Found-IsopodFriend.

Check-Game-Won.
    IF Found-Hiding-Place = "Y" AND
       Found-Cookie = "Y" AND
       Found-IsopodFriend = "Y"
        MOVE "Y" TO Game-Won-FLAG
    END-IF.

Quit-Game.
    DISPLAY "Goodbye!".
    STOP RUN.

End-Game.
    DISPLAY "Congratulations! You've won the game!".
