*** Settings ***
Library    SeleniumLibrary
Variables    ../resources/testData.py


*** Test Cases ***
Login Successful
    Open Browser    ${BASE_URL}   chrome
    Input Text    id=user-name    ${STANDARD_USER}
    Input Text    id=password    ${PASSWORD}
    Click Button    id=login-button
    Page Should Contain Element    class=product_sort_container
    Close Browser

Password is incorrect
    Open Browser    ${BASE_URL}   chrome
    Input Text    id=user-name    ${STANDARD_USER}
    Input Text    id=password    ${INCORRECT_PASSWORD}
    Click Button    id=login-button
    ${error_text}=    Get Text    xpath=//*[@id="login_button_container"]/div/form/div[3]
    Should Contain    ${error_text}    ${INCORRECT_PASSWORD_ERROR}
#    Page Should Contain Element    xpath=//*[@id="login_button_container"]/div/form/div[3]
    Close Browser

User locked
    Open Browser    ${BASE_URL}   chrome
    Input Text    id=user-name    ${LOCKED_OUT_USER}
    Input Text    id=password    ${PASSWORD}
    Click Button    id=login-button
    ${error_text}=    Get Text    xpath=//*[@id="login_button_container"]/div/form/div[3]
    Should Contain    ${error_text}    ${LOCKED_OUT_USER_ERROR}
#    Page Should Contain Element    xpath=//*[@id="login_button_container"]/div/form/div[3]
    Close Browser