*** Settings ***
Library    SeleniumLibrary
Variables    ../resources/testData.py
Resource    ../resources/resources.robot
Test Setup    Login To site
Test Teardown    Close Browser

*** Test Cases ***
Inventory Page shown successfully
    [Documentation]    Проверка cart

   Reset app state

    Wait Until Element Is Visible    class=inventory_item    timeout=10s

    Wait Until Element Is Visible    xpath=//*[@id="add-to-cart-sauce-labs-backpack"]    timeout=10s
    Wait Until Element Is Enabled    xpath=//*[@id="add-to-cart-sauce-labs-backpack"]    timeout=5s
    Click Element    xpath=//*[@id="add-to-cart-sauce-labs-backpack"]

    Wait Until Element Is Visible    class=shopping_cart_link    timeout=5s
    ${amount}=    Get Text    xpath=//*[@id="shopping_cart_container"]/a/span
    ${name}=    Get Text    class=inventory_item_name
    Should Be Equal As Integers    ${amount}    1

    Click Element    class=shopping_cart_link
    Wait Until Element Is Visible    class=cart_footer    timeout=5s
    Log    Cart footer visible

    ${added_name}=    Get Text    class=inventory_item_name
    Should Be Equal As Strings    ${name}    ${added_name}


Check cart checkout
    Reset app state

    Wait Until Element Is Visible    xpath=//*[@id="add-to-cart-sauce-labs-backpack"]    timeout=10s
    Wait Until Element Is Enabled    xpath=//*[@id="add-to-cart-sauce-labs-backpack"]    timeout=5s
    Click Element    xpath=//*[@id="add-to-cart-sauce-labs-backpack"]

    Click Element    class=shopping_cart_link
    Capture Page Screenshot    1.jpg
    ${price}=    Get Text    xpath=//*[@id="cart_contents_container"]/div/div[1]/div[3]/div[2]/div[2]/div

    Capture Page Screenshot    2.jpg
    Page Should Contain Element    id=checkout
    Click Element    id=checkout

    Capture Page Screenshot    3.jpg
    Input Text    id=first-name    ${FIRST_NAME}
    Input Text    id=last-name    ${LAST_NAME}
    Input Text    id=postal-code    ${POSTAL_CODE}

    Capture Page Screenshot    4.jpg
    Click Element    xpath=//*[@id="continue"]
    Page Should Contain Element    xpath=//*[@id="checkout_summary_container"]/div/div[2]/div[6]
    ${actual_price_text}=    Get Text    xpath=//*[@id="checkout_summary_container"]/div/div[2]/div[6]

    Should Be Equal As Strings    Item total: ${price}    ${actual_price_text}
