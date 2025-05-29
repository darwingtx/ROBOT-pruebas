*** Settings ***
Library   SeleniumLibrary
Library   DataDriver  ${EXECDIR}/login/data.csv  encoding=utf-8
Library      AutoRecorder
Test Template     Validar Login

*** Variables ***
${URL}  https://demoqa.com/login

*** Test Cases ***
testcase  validar login with ${username} and password as ${password} and isValid as ${isValid}   Default_user    Default_password    0

*** Keywords ***
Validar Login
    [Arguments]     ${username}     ${password}     ${isValid}

    #loguear que usuario y contraseña se va a usar en este test
    Log     ${username}
    Log     ${password}
    Log     ${isValid}

    #abrir el navegador en la pagina correcta
    Open Browser    ${URL}    edge
    Sleep  2s

    #rellenar la informacion en el formulario de login
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    Input Text    xpath=//*[@id="userName"]    ${username}
    Input Text    xpath=//*[@id="password"]    ${password}
    Sleep  2s
    

    #Hacer login
    Click Element    xpath=//*[@id="login"]
    Sleep  3s

    #Tomar screenshot
    Take Screenshot    name=Test  format=jpg

    #Verificar 
    IF    $isValid == "true"
        Valid User
    ELSE
        Invalid User
    END

    Close Browser


Valid User
    ${url}=   Get Location
    Should Be Equal As Strings    ${url}    https://demoqa.com/profile


Invalid User
    Element Should Contain    xpath=//*[@id="name"]    Invalid username or password!