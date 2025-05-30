*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem

*** Variables ***
${URL}  https://demoqa.com/upload-download
${DOWNLOAD_DIR}    C:\\Users\\abela\\Downloads
${FILE_NAME}    sampleFile.jpeg
${UPLOAD_FILE_PATH}    C:\\Users\\abela\\Downloads\\${FILE_NAME}

*** Test Cases ***
Download
    Open Browser    ${URL}    chrome    
    
    Sleep  3s
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)

    Click Element    xpath=//*[@id="downloadButton"]
    
    # Esperar a que el archivo se descargue (máximo 10 segundos)
    ${file_path}=    Set Variable    ${DOWNLOAD_DIR}\\${FILE_NAME}
    Wait Until Created    ${file_path}    timeout=10s
    
    # Verificar que el archivo existe
    File Should Exist    ${file_path}
    
    # Verificar que el archivo no está vacío
    ${file_size}=    Get File Size    ${file_path}
    Should Be True    ${file_size} > 0
        
    Close Browser

Upload

    Open Browser    ${URL}    chrome   
    Sleep   3s
    
    Execute JavaScript    window.scrollTo(0, 500)

    Choose File    xpath=//*[@id="uploadFile"]    ${UPLOAD_FILE_PATH}

    Element Should Contain    xpath=//*[@id="uploadedFilePath"]   ${FILE_NAME}

    Close Browser

