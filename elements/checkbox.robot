*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BROWSER}     chrome
${URL}         https://demoqa.com/checkbox

*** Test Cases ***
Expandir Manualmente Y Verificar Todos Los Checkboxes

    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Execute JavaScript    window.scrollTo(0, 500)
    Sleep    1s

    # Expandir Home
    Click Element    xpath=//label[@for="tree-node-home"]/preceding-sibling::button
    Sleep    0.5s

    # Expandir Documents
    Click Element    xpath=//label[@for="tree-node-documents"]/preceding-sibling::button
    Sleep    0.5s

    # Expandir WorkSpace
    Click Element    xpath=/html/body/div[2]/div/div/div/div[2]/div[2]/div/ol/li/ol/li[2]/ol/li[1]/span/button
    Sleep    0.5s

    # Expandir Office
    Click Element    xpath=//label[@for="tree-node-office"]/preceding-sibling::button
    Sleep    0.5s

    # Expandir Downloads
    Click Element    xpath=//label[@for="tree-node-downloads"]/preceding-sibling::button
    Sleep    0.5s

    Click Element    xpath=//span[text()='Home']/preceding::span[@class='rct-checkbox']
    
    # Lista de elementos esperados
    ${elementos_esperados}=    Create List
    ...    home
    ...    desktop
    ...    notes
    ...    commands
    ...    documents
    ...    workspace
    ...    react
    ...    angular
    ...    veu
    ...    office
    ...    public
    ...    private
    ...    classified
    ...    general
    ...    downloads
    ...    wordFile
    ...    excelFile

    # Verificar cada elemento en el resultado
    FOR    ${elemento}    IN    @{elementos_esperados}
        Element Should Be Visible    xpath=//div[@id='result']//span[@class='text-success' and text()='${elemento}']
    END

    Click Element    xpath=//button[@title="Collapse all"]
    Sleep   1s
    Element Should Not Be Visible    xpath=//span[text()='Desktop']

    Click Element    xpath=//button[@title="Expand all"]
    Sleep   1s
    Element Should Be Visible    xpath=//span[text()='Desktop']

    Close Browser

