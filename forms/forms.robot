*** Settings ***
Library   SeleniumLibrary
Library    OperatingSystem

*** Variables ***
${url}    https://demoqa.com/automation-practice-form
${browser}    firefox

# information
${firstname}    MyFirstName
${lastname}   MyLastName
${email}    test@test.com
${gender}   1    # Values: 1 (Male), 2 (Female), 3 (Other)
${number}   3002001000    # 10 digits
${birthdate}    10 May 2002

@{SUBJECTS}         Maths    Arts    Social Studies

@{HOBBIES}         1    2
${picture}    /path/of/picture
${currentAddress}   MySadAddress
${state}   ?   # Double DropDown
${city}
${FILE_NAME}    "robot.png"
${FILE_PATH}    ${EXECDIR}/forms/${FILE_NAME}

*** Test Cases ***
Test Basic Data
    Open Browser To Form
    Remove Shit
    Type In TextField   firstName   ${firstName}
    Type In TextField   lastName    ${lastname}
    Type In TextField   userEmail   ${email}
    Select Gender
    Type In TextField   userNumber    ${number}
    Select Date Of Birth
    Select Subjects
    Select Hobbies
    Upload File From Local
    Type In TextField   currentAddress    ${currentAddress}
    Select State And City
    Submit Form
    Sleep    5s
    [Teardown]    Close browser

*** Keywords ***
Open Browser To Form
    Open Browser    ${url}    ${browser}    options=add_argument("--log-level=3")
    Maximize Browser Window

Remove Shit
    Execute JavaScript    document.querySelectorAll('iframe, .advertisement, #fixedban').forEach(e => e.remove())
    Execute JavaScript    document.getElementById('RightSide_Advertisement').remove()
    Execute JavaScript    document.querySelectorAll('footer').forEach(e => e.remove())

Select Gender
    Scroll Element Into View    xpath://label[@for="gender-radio-${gender}"]
    Click Element    xpath://label[@for="gender-radio-${gender}"]

Select Date Of Birth
    Scroll Element Into View    id:dateOfBirthInput
    Click Element    id:dateOfBirthInput
    Press Keys    id:dateOfBirthInput    CTRL+A   ${birthdate}    RETURN

Select Subjects
    FOR    ${subject}    IN    @{SUBJECTS}
        Click Element    id:subjectsInput
        Press Keys    id:subjectsInput    ${subject}
        Mouse Over    id:subjectsInput
        Click Element   id:react-select-2-option-0
    END

Select Hobbies
    FOR    ${hobbie}    IN    @{HOBBIES}
        ${locator}=    Set Variable    xpath://label[@for="hobbies-checkbox-${hobbie}"]
        Scroll Element Into View    ${locator}
        Wait Until Element Is Visible    ${locator}    timeout=5s
        Click Element   ${locator}
    END

Upload File From Local
    Execute JavaScript    window.scrollTo(0, 500)
    Choose File    xpath=//*[@id="uploadPicture"]    ${FILE_PATH} 

Select State And City
    Scroll Element Into View    id:submit
    Click Element   id:state
    Click Element    react-select-3-option-1

    Click Element   id:city
    Click Element   react-select-4-option-0

Submit Form
    Execute JavaScript    document.getElementById('submit').click()
    Execute JavaScript    document.getElementById('closeLargeModal').click()

Type In TextField
    [Arguments]   ${id}   ${text}
    Scroll Element Into View    id:${id}
    Input Text    id:${id}   ${text}
