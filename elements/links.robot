*** Settings ***
Library           SeleniumLibrary
Library           RequestsLibrary


*** Variables ***
${URL}            https://demoqa.com/links
${BROWSER}        Chrome
${API_BASE}       https://demoqa.com

*** Test Cases ***
Verificar Links Que Abren Nuevas Pestañas
    Open Browser To Page
    Click Link And Verify URL    simpleLink    ${API_BASE}/
    Click Link And Verify URL    dynamicLink   ${API_BASE}/

Verificar Links De API Por Código De Respuesta
    Open Browser To Page
    Check API Status    created        201
    Check API Status    no-content     204
    Check API Status    moved          301
    Check API Status    bad-request    400
    Check API Status    unauthorized   401
    Check API Status    forbidden      403
    Check API Status    invalid-url    404

*** Keywords ***
Open Browser To Page
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Execute JavaScript    window.scrollTo(0, 500)

Click Link And Verify URL
    [Arguments]    ${element_id}    ${expected_url}
    ${main_window}=    Get Window Handles
    Click Element    id=${element_id}
    Sleep    2s
    ${windows}=    Get Window Handles
    ${new_window}=    Evaluate    [w for w in ${windows} if w not in ${main_window}][0]
    Switch Window    ${new_window}
    Location Should Be    ${expected_url}
    Close Window
    Switch Window    ${main_window}[0]

Check API Status
    [Arguments]    ${element_id}    ${expected_status}
    Click Element    id=${element_id}
    Sleep    2s
    ${response_text}=    Get Text    id=linkResponse
    Should Contain    ${response_text}    ${expected_status}
    


