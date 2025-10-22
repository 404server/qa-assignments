*** Settings ***
Library    SeleniumLibrary
Variables    ../resources/testData.py
Resource    ../resources/resources.robot
Suite Setup    Login To site
Suite Teardown    Close All Browsers

*** Test Cases ***
Inventory Page shown successfully
    [Documentation]    Проверка cart

    Page Should Contain Element    class=inventory_item
    Click Button    xpath=//*[@id="add-to-cart-sauce-labs-bike-light"]

    Page Should Contain Element    class=shopping_cart_link
    ${amount}=    Get Text    xpath=//*[@id="shopping_cart_container"]/a/span
    ${name}=    Get Text    class=inventory_item_name

    Should Be Equal As Integers    ${amount}    1

    Page Should Contain Element    class=shopping_cart_link
    Click Element    class=shopping_cart_link
    Page Should Contain Element    class=cart_footer


    Page Should Contain Element    class=cart_item
    ${added_name}=    Get Text    class=inventory_item_name
    
    Should Be Equal As Strings    ${name}     ${added_name}
    
    
