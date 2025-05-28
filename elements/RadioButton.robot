*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem

*** Variables ***
${URL}  https://demoqa.com/radio-button


**Test Cases**

Click Buttons
    Open Browser    ${URL}  chrome
    Execute JavaScript    window.scrollTo(0, 80)
    Sleep   2s
    Execute JavaScript    document.getElementById('yesRadio').click()
    ${yesOp}=    Get Text    class:text-success
    Should Be Equal    ${yesOp}    Yes    msg=El texto no coincide con lo esperado

    Execute JavaScript    document.getElementById('impressiveRadio').click()
    ${impressiveRadio}=     Get Text    class:text-success
    Should Be Equal     ${impressiveRadio}     Impressive   msg=El texto no coincide con lo esperado
    Close browser

