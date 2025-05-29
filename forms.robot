*** Settings ***
Library   SeleniumLibrary

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

# SUBJECTS
${subjects}   Maths    Arts    Social Studies
@{HOBBIES}         1    2    
${picture}    /path/of/picture
${currentAddress}   MySadAddress
${StateAndCity}   ?   # Double DropDown

*** Test Cases ***
Test Basic Data
    Open Browser To Form
    Remove Adds

    Type In TextField   firstName   ${firstName}
    Type In TextField   lastName    ${lastname}
    Type In TextField   userEmail   ${email}
    Select Gender
    Type In TextField   userNumber    ${number}
    Select Date Of Birth
    # Subjects
    Select Hobbies
    # Picture
    Type In TextField   currentAddress    ${currentAddress}
    Execute JavaScript    document.getElementById('submit').click()
    Sleep    5s
    [Teardown]    Close browser

*** Keywords ***
Open Browser To Form
    Open Browser    ${url}    ${browser}    options=add_argument("--log-level=3")
    Maximize Browser Window

Remove Adds
    Execute JavaScript    document.querySelectorAll('iframe, .advertisement, #fixedban').forEach(e => e.remove())
    Execute JavaScript    document.getElementById('RightSide_Advertisement').remove()
    Sleep    1s

Select Gender
    Scroll Element Into View    xpath://label[@for="gender-radio-${gender}"]
    Click Element    xpath://label[@for="gender-radio-${gender}"]

Select Date Of Birth
    Scroll Element Into View    id:dateOfBirthInput
    Click Element    id:dateOfBirthInput
    Press Keys    id:dateOfBirthInput    CTRL+A   ${birthdate}    RETURN
    Sleep   2s

Select Subjects
    FOR    ${subject}    IN    ${subjects}
        Click Element    id:subjectsInput
        Press Keys    id:subjectsInput    ${subject}   RETURN
        Sleep            1s
    END

Select Hobbies
    FOR    ${hobbie}    IN    @{HOBBIES}
        ${locator}=    Set Variable    xpath://label[@for="hobbies-checkbox-${hobbie}"]
        Wait Until Element Is Visible    ${locator}    timeout=5s
        Scroll Element Into View    ${locator}
        Click Element               ${locator}
    END





Type In TextField
    [Arguments]   ${id}   ${text}
    Input Text    id:${id}   ${text}
