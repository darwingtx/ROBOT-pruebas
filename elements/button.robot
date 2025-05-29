*** Settings ***
Library           SeleniumLibrary

*** Variables ***
${URL}            https://demoqa.com/buttons
${BTN_DOUBLE}     id=doubleClickBtn
${BTN_RIGHT}      id=rightClickBtn
${BTN_CLICK}      css:X9s05

*** Test Cases ***
Probar Doble Clic
    Open Browser    ${URL}    Chrome
    Maximize Browser Window
    Execute JavaScript    window.scrollTo(0, 100)
    Double Click Element    ${BTN_DOUBLE}
    ${doubleClickBtn}=     Get Text    xpath=//*[@id="doubleClickMessage"]
    Should Be Equal     ${doubleClickBtn}     You have done a double click   msg=El texto no coincide con lo esperado
    Sleep    1s
    Close Browser

Probar Clic Derecho
    Open Browser    ${URL}    Chrome
    Maximize Browser Window
    Execute JavaScript    window.scrollTo(0, 300)
    Sleep   2s
    Open Context Menu    ${BTN_RIGHT}
    ${rightClickBtn}=     Get Text    xpath=//*[@id="rightClickMessage"]
    Should Be Equal     ${rightClickBtn}     You have done a right click   msg=El texto no coincide con lo esperado
    Sleep    1s
    Close Browser

Probar Clic Izquierdo
    Open Browser    ${URL}    Chrome
    Maximize Browser Window
    Execute JavaScript    window.scrollTo(0, 300)
    Sleep   2s
    Click Element    xpath=//button[contains(@class, 'btn-primary') and normalize-space(text())='Click Me']
    ${click}=     Get Text    xpath=//*[@id="dynamicClickMessage"]
    Should Be Equal     ${click}     You have done a dynamic click   msg=El texto no coincide con lo esperado
    Sleep    1s
    Close Browser
