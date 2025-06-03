*** Settings ***
Library           SeleniumLibrary

*** Variables ***
${URL}            https://demoqa.com/dynamic-properties
${browser}        edge

*** Test Cases ***
Random Id
    Open Browser To Page
    ${Random_Id}=  Get Property  xpath=//p[contains(text(), 'This text has random Id')]  id
    Log  ${Random_Id}
    Close Browser

Will Be Enabled
    Open Browser To Page
    Wait Until Element Is Enabled  id:enableAfter  
    Click Element  id:enableAfter 
    Close Browser

Change Color
    Open Browser To Page
    ${Text_Color}=  Get Css Attribute  colorChange  color
    Log  ${Text_Color}
    Click Element  id:colorChange 
    Sleep  2s
    ${Text_Color}=  Get Css Attribute  colorChange  color
    Log  ${Text_Color}
    Close Browser

Visible After
    Open Browser To Page
    Wait Until Element Is Visible  id:visibleAfter
    Click Element  id:visibleAfter
    Close Browser

*** Keywords ***
Open Browser To Page 
    Open Browser    ${url}    ${browser}
    Maximize Browser Window
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)

Get Css Attribute
    [Arguments]    ${parameter}    ${property}
    ${color}=  Execute Javascript
...    return window.getComputedStyle(document.getElementById('${parameter}')).getPropertyValue('${property}');
    RETURN  ${color}