*** Settings ***
Library           SeleniumLibrary

*** Variables ***
${URL}            https://demoqa.com/dynamic-properties
${browser}        edge

*** Test Cases ***
# Random Id
    Open Browser To Page
    ${Random_Id}=  Get Property  xpath=//p[contains(text(), 'This text has random Id')]  id
    Log  ${Random_Id}
    Close Browser

# Will Be Enabled
    Open Browser To Page
    Wait Until Element Is Enabled  id:enableAfter  
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    Click Element  id:enableAfter 
    Close Browser

Change Color
    Open Browser To Page
    ${Text_Color}=  Get Css Attribute  colorChange  color
    Log  ${Text_Color}
    # Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    # Click Element  id:enableAfter 
    Close Browser

*** Keywords ***
Open Browser To Page 
    Open Browser    ${url}    ${browser}

Get Css Attribute
    [Arguments]    ${parameter}    ${property}
    ${color}=  Execute Javascript
...    return window.getComputedStyle(document.getElementById('${parameter}')).getPropertyValue('${property}');
    RETURN  ${color}