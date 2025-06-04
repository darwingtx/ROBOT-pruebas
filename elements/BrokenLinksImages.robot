*** Settings ***
Library           SeleniumLibrary
Library               RequestsLibrary

*** Variables ***
${URL}            https://demoqa.com/broken
${browser}        edge

*** Test Cases ***
Valid Image
    Open Browser To Page
    Image is Valid  xpath=//*[@id="app"]/div/div/div/div[2]/div[2]/img[1]
    Close Browser

Invalid Image
    Open Browser To Page
    Run Keyword And Expect Error  Imagen rota o no cargada correctamente  Image is Valid  xpath=//*[@id="app"]/div/div/div/div[2]/div[2]/img[2]
    Close Browser

Valid Link
    Open Browser To Page
    ${link}=  Get Element Attribute  //*[@id="app"]/div/div/div/div[2]/div[2]/a[1]  href
    GET  ${link}  params=query=ciao  expected_status=200
    Close Browser

Invalid Link
    Open Browser To Page
    ${link}=  Get Element Attribute  //*[@id="app"]/div/div/div/div[2]/div[2]/a[2]  href
    GET  ${link}  params=query=ciao  expected_status=500
    Close Browser

*** Keywords ***
Open Browser To Page 
    Open Browser    ${url}    ${browser}
    Maximize Browser Window
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)

Image is Valid
    [Arguments]  ${xpath}
    Wait Until Element Is Visible    ${xpath}    timeout=10s
    ${es_valida}=    Execute JavaScript
    ...    return document.evaluate('${xpath}', document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.complete &&
    ...           document.evaluate('${xpath}', document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.naturalWidth > 0;
    Should Be True    ${es_valida}    Imagen rota o no cargada correctamente