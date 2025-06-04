*** Settings ***
Library    SeleniumLibrary


*** Variables ***
${BROWSER}  chrome
${URL}  https://demoqa.com/webtables
${SEARCH_TEXT}  39
${FIRST_NAME}      Mateo
${LAST_NAME}       Torres
${EMAIL}           mateo.torres@example.com
${AGE}             28
${SALARY}          8500
${DEPARTMENT}      Marketing



*** Test Cases ***
Buscar Elementos En Tabla
    
    Open Browser To Page 
        
    Search  ${SEARCH_TEXT}
        
    Close Browser

Add TABLE_ROW

    Open Browser To Page   
    Execute JavaScript    window.scrollTo(0, 100)
    Click Element   id=addNewRecordButton
    Sleep   1s

    Input Data

    Search  ${EMAIL}
    
    Close Browser

Edit

    Open Browser To Page
    Click Element   id=edit-record-1
    Input Data
    
    Search  ${EMAIL}
    
Delete

    Open Browser To Page
    Execute JavaScript    window.scrollTo(0, 120)
    ${primer_nombre}=    Get Text    xpath=(//div[@class='rt-td'])[1]
    Click Element   xpath=//*[@id="delete-record-1"]
    Element Should Not Be Visible    xpath=//div[contains(text(),'${primer_nombre}')]
    
    Close Browser



*** Keywords ***
Search
    [Arguments]     ${searchText}  
    Input Text    id=searchBox    ${searchText}
    
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'rt-tr-group')]//div[contains(text(), '${searchText}')]
       
    Clear Element Text    id=searchBox

Open Browser To Page 
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
   
Input Data
    Input Text    xpath=//input[@id='firstName']    ${FIRST_NAME}
    Input Text    xpath=//input[@id='lastName']     ${LAST_NAME}
    Input Text    xpath=//input[@id='userEmail']    ${EMAIL}
    Input Text    xpath=//input[@id='age']          ${AGE}
    Input Text    xpath=//input[@id='salary']       ${SALARY}
    Input Text    xpath=//input[@id='department']   ${DEPARTMENT}

    Click Element    id=submit


