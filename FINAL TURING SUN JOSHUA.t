%Joshua Sun
%Final Turing assignment
%April 1 2014
import GUI               %Needed for buttons, sliders and GUI objects
%Declearing Variables
var name, bank_card, pin, card_type, expire_month_str, expire_yr_str, input, account_type, value, converted : string
var withdrawl_selection, deposit_selection : string (1)
var amount, decimal_real, total_amount, credit_amount, chequing_amount, saving_amount, account_amount, total, account2_amount, transfer_amount, withdrawl_amount : real
var keypad : array 0 .. 11 of int
var textbox : array 1 .. 6 of int
var save_input : array 1 .. 5 of string
var print_account_type : array 1 .. 2 of string
var answer : string(1)
var button_cancel, button_ok, button_del, chequing, saving, credit, decimal, another, account, font1, font2, font3, font4, font5, col, expire_month, expire_yr, slider, times, stamp_type,
    rand_colour, x1, x2, x, y1, y2, winID2, winID1, flag, exitwhen, randomint, receipt, winID3 : int
%-----------------------------------Manual------------------------------------------------------------
winID3 := Window.Open("graphics:600;400,position:center,top")
put "Manual:"
put "Bank Card Number:"
put "4XXX XXXX XXXX XXXX ----- Visa"
put "51-55XX XXXX XXXX XXXX -- MasterCard"
put "34,37XX XXXX XXXX XXXX -- AmericanExpress"
put "6011 XXXX XXXX XXXX ----- Discover"
put "88,62XX XXXX XXXX XXXX -- China UnionPay"
put "2131 XXXX XXXX XXXX ----- Japan Credit Bureau"
put "or 1800 XXXX XXXX XXXX -- Japan Credit Bureau"
put ""
put "Pin Code:"
put "Any 4 digit number"
put ""
put "Press Anykey To Continue"
getch (answer)
Window.Close(winID3)
%-----------------------------------Fonts-------------------------------------------------------------
flag := 0                                           %Setting the flag to zero to be used in multiple exit loops
font1 := Font.New ("Frutiger Linotype:22:bold")     %Storing font information in variables
font2 := Font.New ("Roman:24")
font3 := Font.New ("Roman:14:bold")
font4 := Font.New ("Stencil:18:bold")
font5 := Font.New ("Tandysoft:14")
var pic := Pic.FileNew ("welcome.JPG")              %Storing pictures in variables
var pic2 := Pic.FileNew ("selection.JPG")
var pic3 := Pic.FileNew ("namescreen.jpg")
var pic4 := Pic.FileNew ("JCB.JPG")
var pic5 := Pic.FileNew ("visa.JPG")
var pic6 := Pic.FileNew ("MC.JPG")
var pic7 := Pic.FileNew ("AE.JPG")
var pic8 := Pic.FileNew ("unionpay.JPG")
var pic9 := Pic.FileNew ("discover.JPG")
var pic10 := Pic.FileNew ("banksymbol.JPG")
var pic11 := Pic.FileNew ("banksymbolsmall.JPG")
var pic12 := Pic.FileNew ("account_selection.JPG")
var pic13 := Pic.FileNew ("cashamount.JPG")
var pic14 := Pic.FileNew ("customamount.JPG")
var pic15 := Pic.FileNew ("another.JPG")
var pic16 := Pic.FileNew ("waiting.BMP")
var pic17 := Pic.FileNew ("envelope.JPG")
var pic18 := Pic.FileNew ("confirm.JPG")
var pic19 := Pic.FileNew ("balance.JPG")
var pic20 := Pic.FileNew ("creditcard.JPG")

%-------------------------------Shortened repetition functions-----------------------------------------
winID1 := Window.Open ("graphics:832;624,position:center,top,nobuttonbar,title:Richman ATM") %Opens the main ATM window

proc processevent                                                   %Needed to run buttons and sliders, stored in procedure because it's needed often
    loop
	exit when GUI.ProcessEvent
    end loop
end processevent

proc waiting (msg : int)                                            %Procedure for the differet types of loading screens
    Pic.Draw (pic16, 0, 200, 0)
    case msg of
	label 1 :
	    Font.Draw ("Processing", 365, 330, font3, white)
	label 2 :
	    Font.Draw ("Verifying", 365, 330, font3, white)
	label 3 :
	    Font.Draw ("Authorizing", 365, 330, font3, white)
	label 4 :
	    Font.Draw ("asfdasd", 365, 330, font3, white)
    end case
    Font.Draw (".", 475, 330, font3, white)                         %Draw the dots that appear after the words
    delay (400)
    Font.Draw (".", 480, 330, font3, white)
    delay (400)
    Font.Draw (".", 485, 330, font3, white)
    delay (400)
    cls
end waiting

proc dispose (x : int, y : int)                                     %Needed for disposing buttons, since there are lots of buttons in this program
    for dispose : x .. y
	GUI.Dispose (keypad (dispose))
    end for
end dispose
%--------------------------------Get Input---------------------------------------------------
%Procedures for the keypad keys that are needed to input the card number, pin code, etc.
proc onClick0
    input := input + "0"                                            %input is the variable which stores the value the user types in
    locate (20, length (input) + 3)                                 %the new number will appear after the last number
    put "0" ..                                                      %printing on screen
end onClick0
proc onClick1
    input := input + "1"
    locate (20, length (input) + 3)
    put "1" ..
end onClick1
proc onClick2
    input := input + "2"
    locate (20, length (input) + 3)
    put "2" ..
end onClick2
proc onClick3
    input := input + "3"
    locate (20, length (input) + 3)
    put "3" ..
end onClick3
proc onClick4
    input := input + "4"
    locate (20, length (input) + 3)
    put "4" ..
end onClick4
proc onClick5
    input := input + "5"
    locate (20, length (input) + 3)
    put "5" ..
end onClick5
proc onClick6
    input := input + "6"
    locate (20, length (input) + 3)
    put "6" ..
end onClick6
proc onClick7
    input := input + "7"
    locate (20, length (input) + 3)
    put "7" ..
end onClick7
proc onClick8
    input := input + "8"
    locate (20, length (input) + 3)
    put "8" ..
end onClick8
proc onClick9
    input := input + "9"
    locate (20, length (input) + 3)
    put "9" ..
end onClick9
proc clear
    input := ""                                                                             %Sets input to nothing
    Draw.FillBox (20, 305, 800, 335, 31)                                                    %Draw a white box to cover the numbers on the screen
end clear
%Procedure for creating a keypad
proc generate_keypad
    input := ""                                                                             %reset to zero everytime the procedure is called, to reduce bugs
    keypad (0) := GUI.CreateButtonFull (445, 50, 0, "0", onClick0, 40, "0", false)          %Creating a button that is 40 pixels wide and 40 pixels tall
    keypad (1) := GUI.CreateButtonFull (320, 200, 40, "1", onClick1, 40, "1", false)
    keypad (2) := GUI.CreateButtonFull (380, 200, 40, "2", onClick2, 40, "2", false)
    keypad (3) := GUI.CreateButtonFull (440, 200, 40, "3", onClick3, 40, "3", false)
    keypad (4) := GUI.CreateButtonFull (320, 150, 40, "4", onClick4, 40, "4", false)
    keypad (5) := GUI.CreateButtonFull (380, 150, 40, "5", onClick5, 40, "5", false)
    keypad (6) := GUI.CreateButtonFull (440, 150, 40, "6", onClick6, 40, "6", false)
    keypad (7) := GUI.CreateButtonFull (320, 100, 40, "7", onClick7, 40, "7", false)
    keypad (8) := GUI.CreateButtonFull (380, 100, 40, "8", onClick8, 40, "8", false)
    keypad (9) := GUI.CreateButtonFull (440, 100, 40, "9", onClick9, 40, "9", false)
    keypad (10) := GUI.CreateButtonFull (320, 50, 0, "Clear", clear, 40, "`", false)
    keypad (11) := GUI.CreateButtonFull (387, 50, 0, "OK", GUI.Quit, 40, "`", false)
end generate_keypad
proc confirm                                                                                %Creating a confirm button
    keypad (0) := GUI.CreateButtonFull (400, 250, 0, "Confirm", GUI.Quit, 50, "y", false)
    processevent                                                                            %Calling GUI.ProcessEvent, which is needed for buttons to run properly
    GUI.ResetQuit                                                                           %Resets GUI from quit mode
end confirm
%----------------------------------------Visual Effects---------------------------------------------
proc flashing                                                                               %Visual effect for the keypad
    loop
	randint (col, 1, 9)                                                                 %randomized colour
	delay (150)
	Draw.ThickLine (315, 45, 485, 45, 5, col)                                           %thick lines around the keypad, turns to a different colour every 0.14 sec
	Draw.ThickLine (315, 245, 485, 245, 5, col)
	Draw.ThickLine (315, 245, 315, 45, 5, col)
	Draw.ThickLine (485, 245, 485, 45, 5, col)
	Draw.ThickLine (315, 195, 485, 195, 5, col)
	Draw.ThickLine (315, 145, 485, 145, 5, col)
	Draw.ThickLine (315, 95, 485, 95, 5, col)
	Draw.ThickLine (370, 245, 370, 95, 5, col)
	Draw.ThickLine (430, 245, 430, 95, 5, col)
	exit when GUI.ProcessEvent                                                          %loops quits when the user presses the ok button on the keypad
    end loop
end flashing
%----------------------------------Loading Info & security--------------------------------------------------------
proc welcome                                                                                %The Welcome screen
    Pic.Draw (pic, 0, 0, 0)                                                                 %Draw a background picture that has been previously loaded
    keypad (0) := GUI.CreateButtonFull (355, 120, 100, "Unlock Screen", GUI.Quit, 50, " ", false)   %Button for unlocking the welcome sreen
    processevent
    GUI.ResetQuit
    GUI.Dispose (keypad (0))                                                                %Disposing the button
    cls
    loop                                                                                    %Asking for the cardholder's name, will ask again if conditions are not met
	name := ""
	Pic.Draw (pic3, 0, 0, 0)
	Font.Draw ("Please Enter the Card Holder's Name:", 17, 350, font1, black)           %Print the words on the screen
	Draw.Box (15, 300, 817, 340, 16)                                                    %Draw an unfilled box that acts as an input area
	locate (20, 3)
	Input.Flush                                                                         %Empties keyboard buffer, avoid accidently reading multiple keystroke
	get name : *                                                                        %Asks for the users first and last name
	if length (name) > 20 then                                                          %If the name is too long, program will tell the user to only enter his/her first name
	    Pic.Draw (pic16, 0, 200, 0)
	    Font.Draw ("Your Name Contains Too Many Characters", 250, 330, font3, white)
	    Font.Draw ("Try Only Entering Your First Name", 250, 360, font3, white)
	    confirm                                                                         %A confirm button that waits for the user to finish reading
	    GUI.Dispose (keypad (0))
	    cls
	elsif length (name) = 0 then                                                        %If name has too few characters (0), then program will ask the user to enter again
	    Pic.Draw (pic16, 0, 200, 0)
	    Font.Draw ("Your Name Contains Too Few Characters", 250, 330, font3, white)
	    confirm
	    GUI.Dispose (keypad (0))
	    cls
	else                                                                                %Else the program will keep going
	    cls
	    exit
	end if
    end loop
end welcome

proc CardKeypad                                                                             %Procedure that asks for the user's credit card number
    Pic.Draw (pic3, 0, 0, 0)
    Font.Draw ("Please Enter Your Bank Card Number:", 17, 350, font1, black)
    Draw.Box (15, 300, 817, 340, 16)
    generate_keypad                                                                         %generate the keypad
    flashing                                                                                %create visual effects
    bank_card := input
    %After the user finish inputting and presses "ok", the card information will be stored in the bank_card variable
    GUI.ResetQuit
    dispose (0, 11)                                                                         %disposing keypad
end CardKeypad                                                                              %will go to the main program loop and check if conditions for a correct card number are met

proc PinKeypad                                                                              %Procedure that asks for the user's card's pin number
    cls
    Pic.Draw (pic3, 0, 0, 0)
    Font.Draw ("Please Enter Your PIN Number:", 17, 350, font1, black)
    Draw.Box (15, 300, 817, 340, 16)
    generate_keypad
    flashing
    pin := input                                                                            %Storing pin code in the pin variable
    GUI.ResetQuit
    dispose (0, 11)
end PinKeypad                                                                               %will go to the main program loop and check if conditions for a correct pin number are met

proc account_info                                                                           %loads account information
    randomize                                                                               %produce randomized numbers
    withdrawl_amount := 0                                                                   %records the total amount of money the user has withdrawn
    randint (chequing, 0, 1000)                                                             %random whole number part of the money in chequing account
    randint (saving, 0, 100000)                                                             %random whole number part of the money in savings account
    randint (credit, -1000, 150)
    %random whole number part of the money in credit card account, can be negative because the user could have bought somthing on their credit card
    randint (decimal, 1, 99)                                                                %random decimal
    decimal_real := decimal / 100                                                           %Needs a new variable because only integers can be randomized
    chequing_amount := chequing + decimal_real                                              %adding the random decimal to the whole number part
    randint (decimal, 1, 99)                                                                %randomize a new decimal for each account
    decimal_real := decimal / 100
    saving_amount := saving + decimal_real
    randint (decimal, 1, 99)
    decimal_real := decimal / 100
    credit_amount := credit + decimal_real
    total_amount := saving_amount + chequing_amount + credit_amount                         %total money the user has
    randint (expire_month, 1, 12)                                                           %randomized expire month
    randint (expire_yr, 14, 20)                                                             %randomized expire year
end account_info

%-------------------------------------Program Function Components----------------------------------------------
proc sel_chequing                                                                           %chequing account has been chosen
    dispose (1, 3)
    account_type := "1"                                                                     %indicating the type of account for later use
    account_amount := chequing_amount                                                       %giving the account balance to a new variable for use in the function
    print_account_type(1) := "Chequing"
    GUI.Quit
end sel_chequing

proc sel_savings
    dispose (1, 3)
    account_type := "2"
    account_amount := saving_amount
    print_account_type(1) := "Saving"
    GUI.Quit
end sel_savings

proc sel_credit
    dispose (1, 3)
    account_type := "3"
    account_amount := credit_amount
    print_account_type(1) := "Credit Card"
    GUI.Quit
end sel_credit

proc sel_all                                                                                %checking balance for all accounts
    dispose (1, 3)
    account_type := "4"
    GUI.Quit
end sel_all

proc yes                                                                                    %used by the yes button
    another := 0                                                                            %indicated the yes button has been pressed
    GUI.Quit
end yes

proc no                                                                                     %used by the no button
    dispose (0, 1)
    another := 1                                                                            %indicated the no button has been pressed
    Pic.Draw (pic15, 0, 0, 0)
    Font.Draw ("Would You Like a Receipt?", 50, 300, font2, white)
    keypad (0) := GUI.CreateButtonFull (675, 95, 133, "Yes", yes, 70, "y", false)           %asking if the user wants receipt or not
    keypad (1) := GUI.CreateButtonFull (675, 4, 133, "No", GUI.Quit, 70, "n", false)
    processevent
    dispose (0, 1)
    GUI.ResetQuit
    if another = 0 then                                                                     %if the yes button has been pressed, program will print out the receipt
	another := 1                                                                        %just there to avoid button disposing problems
	receipt := 1
	Window.SetActive(winID2)                                                            %End of receipt
	put "==============================="
	put "Card NO: XXXX XXXX XXXX ", bank_card (13 .. 16)
	put "CHEQUING BALANCE: $",chequing_amount
	put "SAVINGS BALANCE: $",saving_amount
	put "CREDIT CARD BALANCE: $",credit_amount
	put "TOTAL BALANCE: $",total_amount:1:2
	put ""
	put "Press Anykey to Continue"
	Window.Show(winID2)
	getch(answer)
	if length (answer) >= 0 then
	Window.Close(winID2)
	Window.SetActive(winID1)
	end if
    else                                                                                    %if the user doesn't want the receipt, the program will go back to the welcome screen
	cls
    end if
    GUI.Quit
end no

proc amount_20                                                                              %withdrawl $20
    amount := 20
    GUI.Quit
end amount_20

proc amount_50                                                                              %withdrawl $50
    amount := 50
    GUI.Quit
end amount_50

proc amount_100                                                                             %withdrawl $100
    amount := 100
    GUI.Quit
end amount_100

proc amount_200                                                                             %withdrawl $200
    amount := 200
    GUI.Quit
end amount_200

proc amount_500                                                                             %withdrawl $500
    amount := 500
    GUI.Quit
end amount_500

proc amount_custom                                                                          %custom withdrawl amount
    flag := 1                                                                               %changing flag so the program will not dispose the button again, causing it to crash
    dispose (0, 5)                                                                          %needs to dispose the buttons from the previous window, since this is a new window
    input := ""
    Pic.Draw (pic14, 0, 0, 0)
    Font.Draw ("Enter Your Amount:", 17, 350, font1, white)
    Draw.FillBox (15, 300, 817, 340, white)                                                 %area for input
    loop                                                                                    %for user to enter the amount they want to withdrawl, will ask again if conditions are not met
	generate_keypad
	flashing
	processevent
	GUI.ResetQuit
	dispose (0, 11)
	if length (input) = 0 then                                                          %prevents the program from crashing, if the user doesn't enter anything
	    input := "0"
	end if
	amount := strreal (input)                                                           %storing the value the user entered, has to be tured into a real number since variable amount is real
	waiting (1)                                                                         %loading screen
	GUI.Quit
	exit
    end loop
end amount_custom

proc toChequing                                                                             %transfering to chequing account
    if account_type = "2" then                                                              %if the user chose to transfer from saving account, it will be disabled when..
	GUI.Dispose (keypad (4))                                                            
	GUI.Dispose (keypad (6))                                                                                 %they choose the account to transfer into, so the other two options to transfer into will be disposed after they chose which account to transfer to
    else
	GUI.Dispose (keypad (4))
	GUI.Dispose (keypad (5))
    end if
    print_account_type (2) := "Chequing"                                                    %to store the name of the account for later use
    GUI.Quit
end toChequing

proc toSavings                                                                              %transfering to savings account
    if account_type = "3" then
	GUI.Dispose (keypad (4))
	GUI.Dispose (keypad (5))
    else
	GUI.Dispose (keypad (5))
	GUI.Dispose (keypad (6))
    end if
    print_account_type (2) := "Savings"
    GUI.Quit
end toSavings

proc toCredit                                                                               %transfering to credit card account
    if account_type = "2" then
	GUI.Dispose (keypad (4))
	GUI.Dispose (keypad (6))
    else
	GUI.Dispose (keypad (5))
	GUI.Dispose (keypad (6))
    end if
    print_account_type (2) := "Credit Card"
    GUI.Quit
end toCredit

proc random                                                                                 %randomized variables for stamp graphics
    randint (x1, 150, 650)                                                                  %randomized horizontal location value 1    
    randint (x2, 150, 650)                                                                  %randomized horizontal location value 2
    randint (y1, 100, 500)                                                                  %randomized horizontal location value 3   
    randint (y2, 100, 500)                                                                  %randomized horizontal location value 4   
    randint (rand_colour, 1, 15)                                                            %randomized colour code   
    randint (x, 10, 15)                                                                     %randomized number of ovals 
end random

proc stamp1                                                                                 %stamp type 1                                                                       
    stamp_type := 1                                                                         %indicated the type of stamp for later use
    value := "$0.25"                                                                        %stores the value of this type of stamp for later use
    total := total + 0.25                                                                   %adds a value depending how many the user buys
    GUI.Quit
end stamp1

proc stamp2
    stamp_type := 1
    value := "$0.50"
    total := total + 0.5
    GUI.Quit
end stamp2

proc stamp3
    stamp_type := 2
    value := "$1.00"
    total := total + 1
    GUI.Quit
end stamp3

proc stamp4
    stamp_type := 3
    value := "$5.00"
    total := total + 5
    GUI.Quit
end stamp4

proc stamp5
    stamp_type := 4
    value := "$10.00"
    total := total + 10
    GUI.Quit
end stamp5

proc stamp6
    stamp_type := 5
    value := "$20.00"
    total := total + 20
    GUI.Quit
end stamp6

proc cancel                                                                             %used for confirming the information on the credit card, program will go back to welcome screen if the user clicks cancel
    another := 1                                                                        %indicated the no buttons has been pressed
    GUI.Quit
end cancel

proc SliderMoved (value : int)                                                          %procedure used when the number of deposit slider is moved
    drawfillbox (50, 280, 320, 340, black)                                              %cover the previously value on the screen
    converted := "Number of Deposits: " + intstr (value)                                %strings much be in one variable to be put in a font.draw
    Font.Draw (converted, 50, 300, font3, white)                                        %print the value on the screen
    times := value                                                                      %stores the number of deposits the user wants to make
end SliderMoved

proc SliderMoved2 (value : int)                                                         %procedure used when the number of stamps slider is moved
    drawfillbox (100, 570, 370, 630, black)                                             %cover the previously value on the screen
    converted := "Number of Stamps: " + intstr (value)                                  %strings much be in one variable to be put in a font.draw
    Font.Draw (converted, 100, 590, font3, white)                                       %print the value on the screen
    times := value                                                                      %stores the number of deposits the user wants to make
end SliderMoved2

proc confirmstamp                                                                       %confirmaiton screen for stamp purchasing
    Pic.Draw (pic19, 0, 0, 0)
    Text.Locate (15, 1)
    put "You are purchasing: ", times, " stamps"                                        %how many stamps the user bought
    Text.Locate (17, 1)
    put "From Account: ", print_account_type (1)                                        %which account the user is paying from
    Text.Locate (19, 1)
    put "Total: $", total                                                               %total amount of $
    keypad (0) := GUI.CreateButtonFull (675, 95, 133, "Confirm", GUI.Quit, 70, "y", false)  %confirm button
    processevent
    GUI.ResetQuit
    GUI.Dispose (keypad (0))
end confirmstamp

%----------------------------------Main Program Functions-------------------------------------------

proc account_selection                                                                              %asks the user which account they wish to use
    dispose (0, 6)                                                                                  %disposes the selection screen buttons
    Pic.Draw (pic12, 0, 0, 0)
    Font.Draw ("Please Select An Account:", 17, 400, font1, white)
    keypad (1) := GUI.CreateButtonFull (450, 310, 350, "Chequing", sel_chequing, 70, "1", false)    %button for chequing account
    keypad (2) := GUI.CreateButtonFull (450, 220, 350, "Savings", sel_savings, 70, "2", false)      %button for savings account
    keypad (3) := GUI.CreateButtonFull (450, 130, 350, "Credit Card", sel_credit, 70, "3", false)   %button for credit card account
end account_selection

proc another_transaction                                                                            %asks if the user wants to perform another transaction
    Pic.Draw (pic15, 0, 0, 0)
    Font.Draw ("Your Transactions Are Complete.", 50, 300, font2, white)
    Font.Draw ("Would You Like To Perform Another Transaction?", 50, 240, font2, white)
    keypad (0) := GUI.CreateButtonFull (675, 95, 133, "Yes", yes, 70, "y", false)                   %yes button
    keypad (1) := GUI.CreateButtonFull (675, 4, 133, "No", no, 70, "n", false)                      %no button
    processevent
    if another = 0 then                                                                             %if the user wants to perform another transaction, dispose the buttons
	dispose (0, 1)
    end if
    GUI.ResetQuit
    GUI.Quit
end another_transaction

proc signout                                                                                        %option for user to sign our of their account
    dispose (0, 6)
    another := 1
    another_transaction                                                                              %Asks if the user wants receipt                                  
    GUI.Quit
end signout

proc withdrawl                                                                                      %withdrawl function
    cls
    exitwhen := 0                                                                                   %exits the loop and goes on the another_transaction
    account_selection                                                                               %select an account
    processevent
    GUI.ResetQuit
    waiting (1)
    loop
	exit when exitwhen = 1                                                                      %exits when the user is finished withdrawing
	flag := 0                                                                                   %to avoid disposing problems, buttons will not be disposed again if flag = 1
	cls
	Pic.Draw (pic13, 0, 0, 0)
	keypad (0) := GUI.CreateButtonFull (30, 300, 133, "$20", amount_20, 75, "1", false)         %makes buttons for withdrawing options
	keypad (1) := GUI.CreateButtonFull (30, 210, 133, "$50", amount_50, 75, "2", false)
	keypad (2) := GUI.CreateButtonFull (30, 120, 133, "$100", amount_100, 75, "3", false)
	keypad (3) := GUI.CreateButtonFull (668, 300, 133, "$200", amount_200, 75, "4", false)
	keypad (4) := GUI.CreateButtonFull (668, 210, 133, "$500", amount_500, 75, "5", false)
	keypad (5) := GUI.CreateButtonFull (668, 120, 133, "Enter Amount", amount_custom, 75, "6", false) %button for custom amount
	converted := "$" + realstr (account_amount, 10)
	case account_type of                                                                        %determine which account to be put on the screen
	    label "1" :
		Font.Draw ("Chequing Balance: ", 320, 200, font3, white)
	    label "2" :
		Font.Draw ("Saving Balance: ", 320, 200, font3, white)
	    label "3" :
		Font.Draw ("Credit Card Balance: ", 320, 200, font3, white)
	end case
	Font.Draw (converted, 350, 150, font3, white)                                               %printing the balance of that account
	processevent
	GUI.ResetQuit
	if flag = 0 then                                                                            %if custom amount was't chosen, dispose the buttons. to avoid disposing problems
	    dispose (0, 5)
	end if
	Pic.Draw (pic16, 0, 200, 0)
	if account_type = "3" then                                                                  %money can be withdrawn from credit card account even if it has insufficient amount of money
	    account_amount := 9999
	end if
	if amount > 500 or withdrawl_amount >= 500 then                                             %they user cannot withdrawl more than 500 at once, and cannot withdraw more than 500 per day. the first condition is to ensure that custom amount is entered correctly
	    Font.Draw ("Maximum Withdrawl : $500/Day", 300, 330, font3, white)                      
	    exitwhen := 1
	    confirm
	elsif amount < 0 then
	    Font.Draw ("Minium Amount For Withdrawl: $1", 300, 330, font3, white)                   %minimum withdrawl is $1
	    confirm
	elsif amount > account_amount then
	    Font.Draw ("Insufficient Amount in Account", 300, 330, font3, white)                    %not enough money in account
	    confirm
	else
	    if account_type = "1" then                                                              %if all condition are met, then subtract the withdrawl amount from account balance
		chequing_amount := chequing_amount - amount
	    elsif account_type = "2" then
		saving_amount := saving_amount - amount
	    else
		credit_amount := credit_amount - amount
	    end if
	    converted := "You Have Withdrawn $" + realstr (amount, 3)                              %print how much the user has withdrawn
	    Font.Draw (converted, 330, 330, font3, white)
	    confirm
	    withdrawl_amount := withdrawl_amount + amount
	    exitwhen := 1                                                                           %the user is finished with withdrawing
	end if
	GUI.Dispose (keypad (0))                                                                    %disposing the confirm button
    end loop
    Window.SetActive(winID2)                                                                        %Printing on receipt
    put "WITHDRAW: $",amount:1:2 
    put "  FROM: ",print_account_type(1)
    Window.SetActive(winID1)
    another_transaction                                                                             %ask the user if he/she wants to perform another transaction and if he/she wants a receipt
end withdrawl

proc deposit
    cls
    account_selection
    processevent
    GUI.ResetQuit
    waiting (1)
    times := 1                                                                                      % number of deposits the user wants to make
    total := 0                                                                                      %total deposit amount
    Pic.Draw (pic14, 0, 0, 0)
    Font.Draw ("How Many Deposits Would You Like to Make?:", 17, 350, font1, white)
    slider := GUI.CreateHorizontalSlider (100, 270, 250, 1, 5, 1, SliderMoved)                      %asking how many deposits the user wants to make
    drawfillbox (50, 280, 320, 340, black)                                                          %to cover the previous value
    Font.Draw ("Number of Deposits: 1", 50, 300, font3, white)                                      %shows 1 deposits even if the slider wasn't moved
    confirm                                                                                         %confirm button
    GUI.Dispose (keypad (0))
    cls
    for save_amount : 1 .. times                                                                    %deposit screen, the number of screen depends on how many deposits the user wants to make
	Pic.Draw (pic14, 0, 0, 0)
	input := ""
	converted := "Number " + intstr (save_amount) + " Deposit, Please Enter Amount:"            %indicates the which deposit this one is
	Font.Draw (converted, 17, 350, font1, white)
	Draw.FillBox (15, 300, 817, 340, white)                                                     %area for inputting numbers
	generate_keypad                                                                             %generates keypad
	flashing
	processevent
	dispose (0, 11)
	GUI.ResetQuit
	if length (input) = 0 then                                                                  %prevents the program from crashing, sets input to 0 if the user doesn't enter anything
	    input := "0"
	end if
	save_input (save_amount) := input                                                           %storing the value the user enters to an array
	total := total + strreal (input)                                                            %adding up the value in the array to calculate total $
	cls
    end for
    if account_type = "1" then                                                                      %telling the user that he is depositing into the correct account
	converted := "Depositing Into: " + "CHEQUING"
    elsif account_type = "2" then
	converted := "Depositing Into: " + "SAVINGS"
    else
	converted := "Depositing Into: " + "CREDIT CARD"
    end if
    Pic.Draw (pic14, 0, 0, 0)
    Font.Draw ("Please Confirm Your Transaction:", 17, 380, font1, white)
    Font.Draw (converted, 17, 350, font3, white)
    x := 320                                                                                        %location variable
    for printing : 1 .. times                                                                       %prints out each deposit on the screen
	x := x - 40
	converted := intstr (printing) + ":$ " + save_input (printing)
	Font.Draw (converted, 17, x, font3, white)
    end for
    converted := "Total:$" + realstr (total, 10)                                                    %total money deposited
    Font.Draw (converted, 17, 20, font3, white)
    confirm         
    GUI.Dispose (keypad (0))
    Pic.Draw (pic17, 0, 0, 0)
    keypad (0) := GUI.CreateButtonFull (450, 5, 350, "OK", GUI.Quit, 70, "y", false)                
    processevent
    GUI.Dispose (keypad (0))
    GUI.ResetQuit
    cls
    case account_type of                                                                            %adding the money to the corrosponding account
	label "1" :
	    chequing_amount := chequing_amount + total
	label "2" :
	    saving_amount := saving_amount + total
	label "3" :
	    credit_amount := credit_amount + total
    end case
    Window.SetActive(winID2)                                                                        %Printing receipt
    put "Deposit: $",total:1:2
    put "  INTO: ",print_account_type(1)
	for printing : 1 .. times 
	put "  ", printing,". $" + save_input (printing)
	end for
    Window.SetActive(winID1)
    another_transaction
end deposit

proc balance                                                                                        %tells the user the balance of the accounts
    cls
    account_selection                                                                               % select which account the user would like to check 
    keypad (4) := GUI.CreateButtonFull (450, 40, 350, "All Accounts", sel_all, 70, "4", false)
    processevent
    GUI.ResetQuit
    GUI.Dispose (keypad (4))
    cls
    Pic.Draw (pic19, 0, 0, 0)
    if account_type = "4" then                                                                      %if the user wishes to check all accounts
	Text.Locate (15, 1)
	put "Chequing: $", chequing_amount : 1 : 2                                                  %print account balances on the screen
	Text.Locate (17, 1)
	put "Saving: $", saving_amount : 1 : 2
	Text.Locate (19, 1)
	put "Credit Card: $", credit_amount : 1 : 2
	Text.Locate (21, 1)
	put "Total: $", total_amount : 1 : 2    
    elsif account_type = "1" then                                                                   %chequing balance
	Text.Locate (15, 1)
	put "Chequing: $", chequing_amount : 1 : 2
    elsif account_type = "2" then                                                                   %savings balance
	Text.Locate (15, 1)
	put "Saving: $", saving_amount : 1 : 2
    else                                                                                            %credit card balance
	Text.Locate (15, 1)
	put "Credit Card: $", credit_amount : 1 : 2
    end if
    keypad (0) := GUI.CreateButtonFull (675, 95, 133, "OK", GUI.Quit, 70, "y", false)               %confirm button
    processevent
    GUI.ResetQuit
    GUI.Dispose(keypad(0))
    another_transaction
end balance

proc transfer                                                                                       %transfer money from one account to the other
    cls
    input := "" 
    account_selection
    processevent
    GUI.ResetQuit
    Pic.Draw (pic12, 0, 0, 0)
    Font.Draw ("Select An Account to Transfer to:", 17, 400, font1, white)                          %select an account to transfer into
    keypad (4) := GUI.CreateButtonFull (450, 310, 350, "Chequing", toChequing, 70, "1", false)      %chequing
    keypad (5) := GUI.CreateButtonFull (450, 220, 350, "Savings", toSavings, 70, "2", false)        %savings
    keypad (6) := GUI.CreateButtonFull (450, 130, 350, "Credit Card", toCredit, 70, "3", false)     %credit card
    if account_type = "1" then                                                                      %disable one of the second set of buttons because you cannot transfer from the same account to the same account
	print_account_type (1) := "Chequing"
	GUI.Disable (keypad (4))
    elsif account_type = "2" then
	print_account_type (1) := "Savings"
	GUI.Disable (keypad (5))
    else
	print_account_type (1) := "Credit Card"
	GUI.Disable (keypad (6))
    end if
    processevent
    GUI.ResetQuit
    cls
    Pic.Draw (pic14, 0, 0, 0)
    Font.Draw ("Enter Your Amount:", 17, 350, font1, white)                                         %enter amount the user would like to transfer
    Draw.FillBox (15, 300, 817, 340, white)                                                         %area for input
    generate_keypad 
    flashing
    processevent
    GUI.ResetQuit
    dispose (0, 11)
    if length (input) = 0 then                                                                      %prevents the program from crashing if the user doesn't type anything
	input := "0"
    end if
    transfer_amount := strreal (input)                                                              %stores the value the user entered as a real number
    cls
    put "Transfer Amount: $", transfer_amount                                                       %prints out transfer amount
    case print_account_type (2) of                                                                  %stores the value of the account the user wants to transfer into
	label "Chequing" :
	    account2_amount := chequing_amount                                                      %chequing
	label "Savings" :
	    account2_amount := saving_amount                                                        %savings
	label "Credit Card" :
	    account2_amount := credit_amount                                                        %credit card
    end case
    if account_type = "3" or transfer_amount < account_amount then                                  %type 3 is credit card, which has no limits for transfering
	Pic.Draw (pic19, 0, 0, 0)
	Font.Draw ("Please Confirm Your Transaction:", 17, 350, font1, black)
	locate (20, 1)
	put "From Account: ", print_account_type (1), ", Balance : $", account_amount               %prints the account that's going to be transferred from, and its balance
	locate (21, 1)
	put "To Account: ", print_account_type (2), ", Balance : $", account2_amount                %print the account that's going to be transferred into, and its balance
	case account_type of                                                                        %subtracting the values from the account that lost money
	    label "1" : 
		account_amount := chequing_amount - transfer_amount
	    label "2" :
		account_amount := saving_amount - transfer_amount
	    label "3" :
		account_amount := credit_amount - transfer_amount
	end case
	case print_account_type (2) of                                                              %add the value to the account that gained money
	    label "Chequing" :
		account2_amount := chequing_amount + transfer_amount
	    label "Savings" :
		account2_amount := saving_amount + transfer_amount
	    label "Credit Card" :
		account2_amount := credit_amount + transfer_amount
	end case
	locate (22, 1)
	put "Transfer Amount: $", transfer_amount
	locate (23, 1)
	put print_account_type (1), " Balance Will Be: $", account_amount                           %prints the results
	locate (24, 1)
	put print_account_type (2), " Balance Will Be: $", account2_amount
	keypad (0) := GUI.CreateButtonFull (675, 95, 133, "Confirm", GUI.Quit, 70, "y", false)
	processevent
	GUI.Dispose (keypad (0))
	GUI.ResetQuit
    else
	cls                                                                                         %insufficient amonut in original account
	Pic.Draw (pic16, 0, 200, 0)
	Font.Draw ("Insufficient Amount in Account", 300, 330, font3, white)
	confirm
	GUI.Dispose (keypad (0))
    end if
    Window.SetActive(winID2)
    put "TRANSFERRED: $",transfer_amount
    put "  FROM: ",print_account_type(1)
    put "  TO: ",print_account_type(2)
    Window.SetActive(winID1)
    another_transaction
end transfer

proc stamp
    cls
    times := 1                                                                                      %number of stamp the user would like ot buy
    total := 0                                                                                      %total cost 
    account_selection
    processevent
    GUI.ResetQuit
    waiting (1)
    Pic.Draw (pic14, 0, 0, 0)
    Font.Draw ("Choose a Value:", 17, 450, font1, white)
    keypad (1) := GUI.CreateButtonFull (25, 350, 50, "$0.25", stamp1, 50, "1", false)               %choices of stamps
    keypad (2) := GUI.CreateButtonFull (25, 250, 50, "$0.50", stamp2, 50, "2", false)
    keypad (3) := GUI.CreateButtonFull (125, 350, 50, "$1.00", stamp3, 50, "3", false)
    keypad (4) := GUI.CreateButtonFull (125, 250, 50, "$5.00", stamp4, 50, "4", false)
    keypad (5) := GUI.CreateButtonFull (225, 350, 50, "$10.00", stamp5, 50, "5", false)
    keypad (6) := GUI.CreateButtonFull (225, 250, 50, "$20.00", stamp6, 50, "6", false)
    processevent
    GUI.ResetQuit
    dispose (1, 6)
    cls
    random                                                                                          %generate random values
    Draw.FillBox (100, 50, 700, 550, rand_colour)                                                   %draw the background of the stamp
    drawfillstar (100, 50, 700, 550, rand_colour + 1)                                               %draw the star
    for ovaldraw : 1 .. x                                                                           %draw the ovals
	random
	drawfilloval (x1, y1, x + 10, x + 10, rand_colour)
    end for
    random
    Draw.FillMapleLeaf (x1, y1, x2, y2, rand_colour)                                                %draw the mapleleaf
    Pic.Draw (pic10, 360, 450, 0)
    Draw.FillBox (600, 500, 700, 550, white)                                                        %white background for the word "stamp"
    Draw.FillBox (600, 100, 700, 50, white)                                                         %white backgroun fot the price
    Font.Draw ("STAMP", 610, 520, font4, black)                                                     %printing the word stamp
    Draw.Box (100, 50, 700, 550, black)                                                             %border
    Font.Draw (value, 615, 65, font4, black)                                                        %printing the price of the stamp
    slider := GUI.CreateVerticalSlider (770, 200, 180, 1, 99, 1, SliderMoved2)                      %for choosing the number of stamps to buy
    keypad (0) := GUI.CreateButton (730, 50, 0, "Confirm", GUI.Quit)                                %for comfirming the choice
    processevent
    GUI.Dispose (keypad (0))
    GUI.Dispose (slider)
    GUI.ResetQuit
    cls
    total := total * times                                                                          %total money
    if account_type = "1" and chequing_amount > total then                                          %subtracting the money from the corrosponding account
	print_account_type (1) := "Chequing"
	chequing_amount := chequing_amount - total
	confirmstamp
    elsif account_type = "2" and saving_amount > total then
	print_account_type (1) := "Savings"
	saving_amount := saving_amount - total
	confirmstamp
    elsif account_type = "3" then
	print_account_type (1) := "Credit Card"
	credit_amount := credit_amount - total
	confirmstamp
    else                                                                                            %shows insufficient amount if money is not enough
	Pic.Draw (pic16, 0, 200, 0)
	Font.Draw ("Insufficient Amount in Account", 300, 330, font3, white)
	confirm
	GUI.Dispose (keypad (0))
    end if
    Window.SetActive(winID2)
    put "STAMPS: ",value," X ",times
    put "  TOTAL: $",total:1:2
    put "  FROM: ",print_account_type(1)
    Window.SetActive(winID1)
    another_transaction
end stamp

proc change_pin                                                                                     %allows the user to change pin number
    dispose (0, 6)
    cls
    loop                                                                                            %asking for the current pin                                                                                
	Pic.Draw (pic19, 0, 0, 0)
	input := "" 
	Draw.Box (15, 300, 817, 340, 16)                                                            %area for input
	Font.Draw ("Please Enter Your Current PIN Number:", 17, 350, font1, black)                  
	generate_keypad
	flashing
	processevent
	dispose (0, 11)
	GUI.ResetQuit
	cls
	if input = pin then                                                                         %if the user enters it correctly
	    loop
		Pic.Draw (pic19, 0, 0, 0)
		input := ""
		pin := ""
		Draw.Box (15, 300, 817, 340, 16)
		Font.Draw ("Enter New PIN Number:", 17, 350, font1, black)                          %asks for new pin
		generate_keypad
		flashing
		processevent
		dispose (0, 11)
		GUI.ResetQuit
		if length (input) = 4 then                                                          %quits the loop if the new pin is 4 digits long
		    cls
		    pin := input
		    exit
		else                                                                                %ask the user to enter again if it's not
		    Pic.Draw (pic16, 0, 200, 0)
		    Font.Draw ("Must Be 4 Digits", 300, 330, font3, white)
		    confirm
		    GUI.Dispose (keypad (0))
		    cls
		end if
	    end loop
	    Pic.Draw (pic16, 0, 200, 0)
	    Font.Draw ("Reset Complete", 300, 330, font3, white)                                    %indicates reset complete
	    confirm
	    GUI.Dispose (keypad (0))
	    another := 1
	else                                                                                        %if the user didn't enter the current pin correctly, asks if the user wants to continue
	    another := 1                                                                            %default - quit the loop
	    Pic.Draw (pic16, 0, 200, 0)
	    Font.Draw ("Wrong PIN, Would You Like to Try Again?", 300, 330, font3, white)
	    keypad (0) := GUI.CreateButton (300, 300, 0, "Yes", yes)                                %if yes, program will ask the user for the pin again, variable another will change to 1
	    keypad (1) := GUI.CreateButton (500, 300, 0, "No", GUI.Quit)                            % if no, program will ask for another transaction
	    processevent
	    GUI.ResetQuit
	    dispose (0, 1)
	end if
    exit when another = 1
    end loop
    another := 0
    Window.SetActive(winID2)
    put "PASSCODE CHANGE"
    Window.SetActive(winID1)
    another_transaction
end change_pin

proc selection_screen                                                                               %the function selectioon screen
    cls
    Pic.Draw (pic2, 0, 0, 0)
    keypad (0) := GUI.CreateButtonFull (30, 212, 350, "Cash Withdrawl", withdrawl, 70, "1", false)  %cash withdrawl button
    keypad (1) := GUI.CreateButtonFull (30, 122, 350, "Deposit", deposit, 70, "2", false)           %deposit button
    keypad (2) := GUI.CreateButtonFull (30, 30, 350, "Balance Inquiry", balance, 70, "3", false)    %balance button
    keypad (3) := GUI.CreateButtonFull (450, 212, 350, "Account Transfers", transfer, 70, "4", false)%transfers button
    keypad (4) := GUI.CreateButtonFull (450, 122, 350, "Stamp Purchases", stamp, 70, "5", false)    %stamp button
    keypad (5) := GUI.CreateButtonFull (450, 30, 350, "Change PIN", change_pin, 70, "6", false)     %change pin button
    keypad (6) := GUI.CreateButtonFull (375, 0, 50, "Sign Out", signout, 30, "7", false)            %sign out button
    processevent
    GUI.ResetQuit
end selection_screen

%----------------------------------------------------Main Program Loop------------------------------------------------------------------


loop                                                                                                %main program loop
    winID2 := Window.Open ("position:top;right,graphics:250;600")                                   %Opening the receipt window
	Font.Draw ("Richman's            Bank", 30, 585, font5, black)
	Pic.Draw (pic11, 135, 575, 0)
	Text.Locate (3, 13)
	put "Location:"
	Text.Locate (4, 10)
	put "50 Obama Road,"
	Text.Locate (5, 9)
	put "LucianVille, Mars"
	put ""
	randint (randomint,1111,9999)
	put "SEQ NBR: ",randomint
	put "==============================="
    Window.Hide(winID2)                                                                             %Hide the receipt window
    Window.SetActive(winID1)                                                                        %Indicates the window which the user should input information

    another := 0                                                                                    
    welcome                                                                                         %the welcome screen
    cls
    account_info                                                                                    %load account info
    CardKeypad                                                                                      %asks for card number
    loop
	flag := 1                                                                                        %conditions for determining a legitimate card number, must be 16 digits and starting numbers must meet certain conditions
	waiting (2)
	if index (bank_card, "4") = 1 and length (bank_card) = 16 then
	    card_type := "Visa"
	elsif length (bank_card) = 16 and ((index (bank_card, "51") = 1 or index (bank_card, "52") = 1 or index (bank_card, "53") = 1 or index (bank_card, "54") = 1 or index (bank_card, "55") = 1))
		then
	    card_type := "MasterCard"
	elsif length (bank_card) = 16 and ((index (bank_card, "34") = 1 or index (bank_card, "37") = 1)) then
	    card_type := "American Express"
	elsif length (bank_card) = 16 and ((index (bank_card, "6011") = 1 or index (bank_card, "65") = 1)) then
	    card_type := "Discover"
	elsif length (bank_card) = 16 and ((index (bank_card, "88") = 1 or index (bank_card, "62") = 1)) then
	    card_type := "China UnionPay"
	elsif length (bank_card) = 16 and ((index (bank_card, "2131") = 1 or index (bank_card, "1800") = 1 or index (bank_card, "35") = 1)) then
	    card_type := "JCB"
	else
	    flag := 0 
	    Pic.Draw (pic16, 0, 200, 0)                                                         %card number is invalid
	    Font.Draw ("Invalid Card Number", 340, 330, font3, white)
	    confirm
	    GUI.Dispose (keypad (0))
	    bank_card := ""
	    CardKeypad                                                                          %asks the user to enter again
	end if
	exit when flag = 1
    end loop
    PinKeypad                                                                                   %asks for the pin number
    loop
	waiting (2)
	cls
	if length (pin) = 4 then                                                                %pin must be 4 digits
	    cls
	    waiting (3)
	    exit    
	else  
	    Pic.Draw (pic16, 0, 200, 0)                                                         %pin is invalid
	    Font.Draw ("Invalid PIN Number", 340, 330, font3, white)
	    confirm
	    GUI.Dispose (keypad (0))
	    pin := ""
	    PinKeypad                                                                           %asks for pin again
	end if
    end loop
    Pic.Draw (pic3, 0, 0, 0)                                                                    %drawing the credit card graphic
    Pic.Draw (pic20, 120, 60, 0)
    Font.Draw (bank_card (1 .. 4), 180, 200, font2, grey)                                       %breaking the card number string into four parts to simulate a real credit card
    Font.Draw (bank_card (5 .. 8), 320, 200, font2, grey)
    Font.Draw (bank_card (9 .. 12), 460, 200, font2, grey)
    Font.Draw (bank_card (13 .. 16), 600, 200, font2, grey)
    Font.Draw (Str.Upper (name), 180, 100, font3, grey)                                         %name on card in upper case
    if expire_month < 10 then                                                                   %positioning the expire dates
	expire_month_str := "0" + intstr (expire_month)
    else
	expire_month_str := intstr (expire_month)
    end if
    expire_yr_str := intstr (expire_yr)
    Font.Draw (expire_month_str, 570, 100, font2, grey)                                         %printing the expire dates
    Font.Draw (expire_yr_str, 630, 100, font2, grey)
    Font.Draw ("/", 615, 100, font2, grey)
    keypad (1) := GUI.CreateButtonFull (0, 0, 100, "Confirm", yes, 40, "`", false)              %asks the user if he/she agrees with the info on the card
    keypad (0) := GUI.CreateButtonFull (735, 0, 100, "Cancel", cancel, 40, "`", false)
    if card_type = "Visa" then                                                                  %determines what type of card the card is based on rules and draw the corrosponding logo on the card
	Pic.Draw (pic5, 200, 285, 0)
    elsif card_type = "MasterCard" then
	Pic.Draw (pic6, 200, 285, 0)
    elsif card_type = "American Express" then
	Pic.Draw (pic7, 200, 285, 0)
    elsif card_type = "China UnionPay" then
	Pic.Draw (pic8, 200, 285, 0)
    elsif card_type = "Discover" then
	Pic.Draw (pic9, 200, 285, 0)
    elsif card_type = "JCB" then
	Pic.Draw (pic4, 200, 285, 0)
    end if
    processevent
    dispose (0, 1)
    GUI.ResetQuit
    cls
    if another = 0 then                                                                         %helps the user to return to the selection screen, exits when the user press the no button
	loop
	    selection_screen
	    exit when another = 1
	end loop
    end if
    cls
end loop
%-------------------------------Receipt Window2-------------------------------------------------------
