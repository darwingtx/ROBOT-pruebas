*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem

*** Variables ***
${URL}  https://demoqa.com/radio-button
${NO_ID}          id=noRadio

**Test Cases**

Yes Option
    Open Browser    ${URL}  chrome
    Execute JavaScript    window.scrollTo(0, 80)
    Sleep   2s
    Execute JavaScript    document.getElementById('yesRadio').click()
    ${yesOp}=    Get Text    class:text-success
    Should Be Equal    ${yesOp}    Yes    msg=El texto no coincide con lo esperado
    Close browser

Impressive Option
    Open Browser    ${URL}  chrome
    Maximize Browser Window
    Execute JavaScript    window.scrollTo(0, 100)
    Execute JavaScript    document.getElementById('impressiveRadio').click()
    ${impressiveRadio}=     Get Text    class:text-success
    Should Be Equal     ${impressiveRadio}     Impressive   msg=El texto no coincide con lo esperado
    Close browser

Verificar Que No Está Deshabilitado
    Open Browser    ${URL}    Chrome
    Maximize Browser Window
    Element Should Be Disabled    ${NO_ID}
    Close Browser
