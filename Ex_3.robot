*** Settings ***
Library    SeleniumLibrary
Library    BuiltIn
Library    String

Suite Teardown     Close Browser

*** Variables ***
${url}   https://the-internet.herokuapp.com/login
${username_pass}   tomsmith
${password_pass}   SuperSecretPassword!
${username_fail}   tomsmith
${password_fail}   Password!
${username_notfound}   tomholland
${Input_username}   //*[@id="username"]
${Input_password}   //*[@id="password"]
${btn_submit}   //*[@type="submit"]
${txt_message_success}   //*[contains(text(), "You logged into a secure area!")]
${txt_message_fail}   //*[contains(text(), "Your password is invalid!")]
${txt_message_notfound}   //*[contains(text(), "Your username is invalid!")]

*** Keywords ***
Input Username and Password
     [Arguments]      ${xpath_user}       ${xpath_pass}     ${username}       ${password}
     Element Should Be Visible    ${xpath_user}
     Element Should Be Visible    ${xpath_pass}
     Input Text       ${xpath_user}       ${username}
     Input Text       ${xpath_pass}       ${password}
Click Button Login
     [Arguments]       ${btn}
     Element Should Be Visible    ${btn}
     Click Element        ${btn}
Verify Login Fail
   [Arguments]        ${xpath}
   Element Should Be Visible        ${xpath}
Verify Login Success
   [Arguments]        ${xpath}
   Element Should Be Visible        ${xpath}


*** Test Cases ***
Login - success
    Open Browser    about:blank    chrome
    Go To           ${url}
    Input Username and Password    ${Input_username}     ${Input_password}       ${username_pass}      ${password_pass}
    Click Button Login          ${btn_submit}
    Verify Login Success           ${txt_message_success}

Login failed - Password incorrect
   Open Browser    about:blank    chrome
    Go To           ${url}
    Input Username and Password    ${Input_username}     ${Input_password}       ${username_fail}      ${password_fail}
    Click Button Login          ${btn_submit}
    Verify Login Success           ${txt_message_fail}

Login failed - user not found
   Open Browser    about:blank    chrome
    Go To           ${url}
    Input Username and Password    ${Input_username}     ${Input_password}       ${username_notfound}      ${password_fail}
    Click Button Login          ${btn_submit}
    Verify Login Success           ${txt_message_notfound}