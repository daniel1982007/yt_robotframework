*** Settings ***

Library  SeleniumLibrary

Documentation  Suite description #automated tests for scout website

*** Variables ***
${LOGIN URL}               https://scouts-test.futbolkolektyw.pl/en
${BROWSER}      Chrome
${SIGNINBUTTON}       xpath=//*[text()='Sign in']
${EMAILINPUT}     xpath=//*[@id='login']
${PASSWORDINPUT}      xpath=//*[@id='password']

# sidebar elements locator
${PLAYERS}          xpath=//div[@role='presentation']//ul[1]/div[2]
${LANGUAGE}         xpath=//div[@role='presentation']//ul[last()]/div[1]
${LOGOUTBUTTON}     xpath=//div[@role='presentation']//ul[last()]/div[2]
${MATCHES}          xpath=//div[@role='presentation']//ul[position()=2]/div[2]

# dashboard elements locators
${PAGELOGO}       xpath=//*[@id="__next"]/div[1]/main/div[3]/div[1]/div/div[1]
${ADDPLAYER}        xpath=//span[text()='Add player']/parent::button

# add player fields locators
${SUBMITBUTTON}     xpath=//span[text()='Submit']/parent::button
${NEWPLAYER NAME}  xpath=//input[@name='name']
${NEWPLAYER SURNAME}    xpath=//input[@name='surname']
${NEWPLAYER AGE}    xpath=//input[@name='age']
${NEWPLAYER MAINPOSITION}   xpath=//input[@name='mainPosition']
${NEWPLAYER EMAIL}  xpath=//input[@name='email']
${NEWPLAYER PHONE}  xpath=//input[@name='phone']
${NEWPLAYER WEIGHT}  xpath=//input[@name='weight']
${NEWPLAYER HEIGHT}  xpath=//input[@name='height']
${NEWPLAYER CLUB}  xpath=//input[@name='club']
${NEWPLAYER LEVEL}  xpath=//input[@name='level']
${NEWPLAYER SECONDPOSITION}  xpath=//input[@name='secondPosition']
${NEWPLAYER ACHIEVEMENTS}  xpath=//input[@name='achievements']
${NEWPLAYER LEG}  xpath=//div[@id='mui-component-select-leg']
${NEWPLAYER LEG RIGHT}   xpath=//div[@id='menu-leg']//ul/li[1]
${NEWPLAYER LEG LEFT}   xpath=//div[@id='menu-leg']//ul/li[2]
${SECONDS}              4

# players list locator
${PLAYERSLIST BASEURL}      https://scouts-test.futbolkolektyw.pl/en/players?lng=en&subpath=en&start=
${PLAYER IN ROW}            xpath=//tr[@id='MUIDataTableBodyRow-

# add match page
${ADDMATCHBUTTON}           xpath=//span[text()='Add match']/parent::button
${MYTEAM}                   xpath=//input[@name='myTeam']
${ENEMYTEAM}                xpath=//input[@name='enemyTeam']
${MYTEAMSCORE}              xpath=//input[@name='myTeamScore']
${ENEMYTEAMSCORE}           xpath=//input[@name='enemyTeamScore']
${DATE}                     xpath=//input[@name='date']


*** Test Cases ***
Login to the system
    Open login page
    Type in email
    Type in password
    Click on the Submit button
    Assert dashboard
    [Teardown]  Close Browser

Login to the system with invalid credential
    Open login page
    Type in invalid email
    Type in invalid password
    Click on the Submit button
    Assert Login Error
    [Teardown]  Close Browser

Logout from the system
    Open login page
    Type in email
    Type in password
    Click on the Submit button
    Assert dashboard
    Click on the Logout button
    [Teardown]  Close Browser

Create a player to database
    Open login page
    Type in email
    Type in password
    Click on the Submit button
    Assert dashboard
    Click at the Add Player button
    Assert Add Player Page
    Type in new player info
    Submit new player to database
    [Teardown]  Close Browser

Create a player to database with invalid data input
    Open Login Page
    Type In Email
    Type In Password
    Click On The Submit Button
    Assert Dashboard
    Click At The Add Player Button
    Assert Add Player Page
    Type In New Player Info with invalid data input
    Submit New Player To Database
    [Teardown]    close browser

Edit a player data
    Open login page
    Type in email
    Type in password
    Click on the Submit button
    Assert dashboard
    Click at the Players link
    Select A Player Page In Players List
    Assert Edit Player Page title start
    Choose A Player Row And Edit Player Data
    Save to database
    [Teardown]  Close Browser

Add a match to database
    Open login page
    Type in email
    Type in password
    Click on the Submit button
    Assert dashboard
    Click at the Players link
    Select A Player Page In Players List
    Assert Edit Player Page title start
    Choose A Player Row and Click Match Button
    Add Match Data
    Save To Database
    [Teardown]  Close Browser

Change a language
    Open login page
    Type in email
    Type in password
    Click on the Submit button
    Assert dashboard
    Click on language button
    [Teardown]  Close Browser

*** Keywords ***
Open login page
    Open Browser        ${LOGIN URL}     ${BROWSER}
    Title Should Be     Scouts panel - sign in
Type in email
    Input Text   ${EMAILINPUT}   user07@getnada.com
Type in password
    Input Text   ${PASSWORDINPUT}    Test-1234
Type in invalid email
    Input Text   ${EMAILINPUT}   example@example.com
Type in invalid password
    Input Text   ${PASSWORDINPUT}       ***
Assert Login Error
    sleep               3s
    ${email_class}      Get Element Attribute       xpath=//form//div/span      class
    Should Contain      ${email_class}              Error
Click on the submit button
    Click Element   ${SIGNINBUTTON}
Assert dashboard
    wait until element is visible   ${PAGELOGO}
    title should be     Scouts panel
    Capture Page Screenshot     alert.png
Click on the Logout button
    Click Element   ${LOGOUTBUTTON}
Click at the Add Player button
    Click Element   ${ADDPLAYER}
Assert Add Player Page
    wait until element is visible   ${SUBMITBUTTON}
    Capture Page Screenshot     alert.png
Type in new player info
    Input Text      ${NEWPLAYER NAME}       example-1
    Input Text      ${NEWPLAYER SURNAME}    example-1
    Input Text      ${NEWPLAYER AGE}        12,31,1985
    Input Text      ${NEWPLAYER MAINPOSITION}   example
    Input Text      ${NEWPLAYER EMAIL}       example@example.com
    Input Text      ${NEWPLAYER PHONE}       999999999
    Input Text      ${NEWPLAYER WEIGHT}       88
    Input Text      ${NEWPLAYER HEIGHT}       190
    Input Text      ${NEWPLAYER CLUB}       example
    Input Text      ${NEWPLAYER LEVEL}       example
    Input Text      ${NEWPLAYER SECONDPOSITION}       example
    Input Text      ${NEWPLAYER ACHIEVEMENTS}       example
    Input Text      ${NEWPLAYER NAME}       example-1
    Click Element   ${NEWPLAYER LEG}
    Click Element   ${NEWPLAYER LEG LEFT}
Type In New Player Info with invalid data input
    Input Text      ${NEWPLAYER NAME}       example-1
    Input Text      ${NEWPLAYER SURNAME}    example-1
    Input Text      ${NEWPLAYER AGE}        mm,dd,yyyy
    Input Text      ${NEWPLAYER MAINPOSITION}   example
    ${CSS_VALUE}    GET ELEMENT ATTRIBUTE   xpath=//input[@name='age']/parent::div      class
    Should Contain  ${CSS_VALUE}            error
Submit new player to database
    Click Element   ${SUBMITBUTTON}
    Sleep           ${SECONDS}s
Click at the Players link
    Click Element   ${PLAYERS}
Select a player page in players list
    Go To           ${PLAYERSLIST BASEURL}4
Assert Edit Player Page title start
    Sleep           3s
    ${TITLE}        GET TITLE
    Should Start With      ${TITLE}      Players
choose a player row and Edit player data
    Click Element   ${PLAYER IN ROW}4']
    press keys      ${NEWPLAYER NAME}       CTRL+A+BACKSPACE
    Input Text      ${NEWPLAYER NAME}       example-100
    press keys      ${NEWPLAYER SURNAME}    CTRL+A+BACKSPACE
    Input Text      ${NEWPLAYER SURNAME}    example-200
Save to database
    Click Element   ${SUBMITBUTTON}
    Sleep           ${SECONDS}s
Choose A Player Row and Click match button
    Click Element   ${PLAYER IN ROW}4']
    wait until element is visible       ${MATCHES}
    Click Element   ${MATCHES}
    wait until element is visible       ${ADDMATCHBUTTON}
    click element   ${ADDMATCHBUTTON}
    wait until element is visible       ${SUBMITBUTTON}
    ${TITLE}        GET TITLE
    Should Start With    ${TITLE}       Adding match player
Add Match Data
    Input Text      ${MYTEAM}                   example
    Input Text      ${ENEMYTEAM}                example
    Input Text      ${MYTEAMSCORE}              3
    Input Text      ${ENEMYTEAMSCORE}           0
    Input Text      ${DATE}                     12,31,1999
Click on language button
    click element   ${LANGUAGE}
    Sleep           3s


