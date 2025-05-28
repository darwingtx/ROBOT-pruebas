*** Settings ***
Library    SeleniumLibrary


*** Variables ***
${URL}  https://demoqa.com/text-box
${USERNAME}     pepo
${EMAIL}        pepo@example.com
${CURRENT_ADDRESS}    Calle Principal 123
${PERMANENT_ADDRESS}    Avenida Siempre Viva 456

*** Test Cases ***
Text Box Test

    Open Browser    ${URL}    chrome
    Sleep    3s
    
    # Ingresar datos en el formulario
    Input Text    xpath=//*[@id="userName"]    ${USERNAME}
    Input Text    xpath=//*[@id="userEmail"]   ${EMAIL}
    Input Text    xpath=//*[@id="currentAddress"]   ${CURRENT_ADDRESS}
    Input Text    xpath=//*[@id="permanentAddress"]    ${PERMANENT_ADDRESS}
    
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)

    # Hacer click en el botón submit
    Click Element    xpath=//*[@id="submit"]
    Sleep    2s
    
    # Validar que los datos se muestren correctamente
    Element Should Contain    xpath=//*[@id="name"]    ${USERNAME}
    Element Should Contain    xpath=//*[@id="email"]    ${EMAIL}
    Element Should Contain    xpath=//*[@id="currentAddress" and @class="mb-1"]    ${CURRENT_ADDRESS}
    Element Should Contain    xpath=//*[@id="permanentAddress" and @class="mb-1"]    ${PERMANENT_ADDRESS}
    
    Close Browser
