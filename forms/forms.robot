*** Settings ***
Library   SeleniumLibrary
Library   OperatingSystem
Library   DataDriver    ${EXECDIR}/forms/data.csv    encoding=utf-8     dialect=excel
Suite Setup   Open Browser To Form
Suite Teardown    Close All Browsers
Test Template    Fill Form

*** Test Cases ***
Test2    

*** Keywords ***
Fill Form
    [Arguments]    ${firstname}    ${lastName}    ${email}    ${gender}    ${number}    ${birthdate}    ${subjects}    ${hobbies}    ${picture}    ${currentAddress}    ${state}    ${city}
    Execute JavaScript    window.scrollTo(0, 300)
    Type In TextField   firstName   ${firstName}
    Type In TextField   lastName    ${lastName}
    Type In TextField   userEmail   ${email}
    Select Gender   ${gender}
    Type In TextField   userNumber    ${number}
    Select Date Of Birth    ${birthdate}
    Select Subjects    ${subjects}
    Select Hobbies    ${hobbies}
    Upload File From Local    ${picture}
    Type In TextField   currentAddress    ${currentAddress}
    Select State And City    ${state}    ${city}
    Submit Form

Open Browser To Form
    Open Browser    https://demoqa.com/automation-practice-form    firefox    options=add_argument("--start-fullscreen")
    Remove Shit

Remove Shit
    Execute JavaScript    document.querySelectorAll('iframe, .advertisement, #fixedban').forEach(e => e.remove())
    Execute JavaScript    document.getElementById('RightSide_Advertisement').remove()
    Execute JavaScript    document.querySelectorAll('footer').forEach(e => e.remove())

Select Gender
    [Arguments]   ${gender}
    Scroll Element Into View    xpath://label[@for="gender-radio-1"]
    Click Element    xpath://label[@for="gender-radio-${gender}"]

Select Date Of Birth
    [Arguments]   ${birthdate}
    Scroll Element Into View    id:dateOfBirthInput
    Click Element    id:dateOfBirthInput
    Press Keys    id:dateOfBirthInput    CTRL+A   ${birthdate}    RETURN

Select Subjects
    [Arguments]    ${SUBJECTS}
    ${SUBJECTS}=    Evaluate    "${subjects}".split("|")
    FOR    ${subject}    IN    @{SUBJECTS}
        Click Element    id:subjectsInput
        Press Keys    id:subjectsInput    ${subject}
        Mouse Over    id:subjectsInput
        Click Element   id:react-select-2-option-0
    END

Select Hobbies
    [Arguments]    ${hobbies}
    @{HOBBIES}=    Evaluate    "${hobbies}".split("|")
    FOR    ${hobbie}    IN    @{HOBBIES}
        ${locator}=    Set Variable    xpath://label[@for="hobbies-checkbox-${hobbie}"]
        Scroll Element Into View    ${locator}
        Wait Until Element Is Visible    ${locator}    timeout=5s
        Click Element   ${locator}
    END

Upload File From Local
    [Arguments]    ${FILE_PATH}
    Execute JavaScript    window.scrollTo(0, 500)
    Choose File    xpath=//*[@id="uploadPicture"]    ${FILE_PATH} 

Select State And City
    [Arguments]    ${state}    ${city}
    Execute JavaScript    window.scrollTo(0, 600)
    Wait Until Element Is Visible    id:submit    timeout=5s
    Click Element   id:state
    Click Element    xpath=//div[contains(@id,'react-select') and text()='${state}']

    Click Element   id:city
    Click Element   xpath=//div[contains(@id,'react-select') and text()='${city}']

Submit Form
    Execute JavaScript    document.getElementById('submit').click()
    Execute JavaScript    document.getElementById('closeLargeModal').click()

Type In TextField
    [Arguments]   ${id}   ${text}
    Scroll Element Into View    id:${id}
    Input Text    id:${id}   ${text}
