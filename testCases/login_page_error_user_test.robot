*** Settings ***
Library    SeleniumLibrary
Variables    ../resources/testData.py
Resource    ../resources/resources.robot
Suite Teardown    Close All Browsers


*** Test Cases ***
Cart works incorect
    [Documentation]    Проверка что cart рабоатет неверно кнопка удаления

    Login To Site Error User

    Page Should Contain Element    class=inventory_item
    Click Button    xpath=//*[@id="add-to-cart-sauce-labs-onesie"]

    Page Should Contain Element    class=shopping_cart_link
    ${amount}=    Get Text    xpath=//*[@id="shopping_cart_container"]/a/span

    Should Be Equal As Integers    ${amount}    1

    Click Button    xpath=//*[@id="remove-sauce-labs-onesie"]
    Page Should Contain Element    xpath=//*[@id="shopping_cart_container"]/a/span
    Log To Console   ${amount}


Check filters
    Login To Site Error User

    [Documentation]    Проверка фильтра по цене
    Page Should Contain Element    class=product_sort_container

    Click Element    class=product_sort_container

    Click Element    xpath=//*[@id="header_container"]/div[2]/div/span/select/option[4]

    ${highest}=    Get Text    xpath=//*[@id="inventory_container"]/div/div[1]/div[2]/div[2]/div[1]
    ${lowest}=    Get Text    xpath=//*[@id="inventory_container"]/div/div[6]/div[2]/div[2]/div

    Log To Console    ${highest}
    Log To Console    ${lowest}

    Should Not Be Equal As Strings    ${highest}    ${HIGHEST_REAL}
    Should Not Be Equal As Strings    ${lowest}    ${LOWEST_REAL}