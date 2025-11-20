*** Settings ***
Documentation    Keywords для логина на сайт

*** Keywords ***
Login To site
    [Arguments]    ${USERNAME}=${STANDARD_USER}    ${PASSWORD}=${PASSWORD}
    Open Browser    ${BASE_URL}    chrome
    Input Text      id=user-name     ${USERNAME}
    Input Text      id=password      ${PASSWORD}
    Click Button    id=login-button
    Location Should Contain    inventory.html

Log out
    Click Element    xpath=//*[@id="react-burger-menu-btn"]
    Wait Until Element Is Visible    xpath=//*[@id="logout_sidebar_link"]    timeout=5s
    Wait Until Element Is Enabled    xpath=//*[@id="logout_sidebar_link"]    timeout=5s
    Click Element    xpath=//*[@id="logout_sidebar_link"]


Login To site Error User
    [Arguments]    ${USERNAME}=${problem_user}    ${PASSWORD}=${PASSWORD}
    Open Browser    ${BASE_URL}    chrome
    Input Text      id=user-name     ${USERNAME}
    Input Text      id=password      ${PASSWORD}
    Click Button    id=login-button
    Location Should Contain    inventory.html

Reset app state
    Click Element    xpath=//*[@id="react-burger-menu-btn"]

    Wait Until Element Is Visible    xpath=//*[@id="reset_sidebar_link"]    timeout=10s
    Click Element    xpath=//*[@id="reset_sidebar_link"]

    Wait Until Element Is Visible    xpath=//*[@id="react-burger-cross-btn"]    timeout=5s
    Click Element    xpath=//*[@id="react-burger-cross-btn"]

    Reload Page