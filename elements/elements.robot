*** Settings ***
Library   SeleniumLibrary

*** Variables ***
${browser}    firefox

*** Test Cases ***
Test TextBox
    Open Browser To Page    https://demoqa.com/text-box
    Type In Textfield   userName    AndresWasHere
    Type In Textfield   userEmail     test@test.com
    Type In Textfield   currentAddress    MyAssHoleAddress
    Type In Textfield   permanentAddress    MyAssHolePermanentAddress
    [Teardown]    Close Browser

*** Keywords ***
Open Browser To Page 
    [Arguments]   ${url}
    Open Browser    ${url}    ${browser}

Type In Textfield
    [Arguments]   ${id}   ${text}
    Input Text    id=${id}    ${text}

