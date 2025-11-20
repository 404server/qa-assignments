*** Settings ***
Library    SeleniumLibrary
Variables    ../resources/testData.py
Resource    ../resources/resources.robot
Suite Setup    Login To site
Suite Teardown    Close All Browsers

*** Test Cases ***
Inventory Page shown successfully
    [Documentation]    Проверка что старница отображается нормально

    Page Should Contain Element    class=inventory_list
    Page Should Contain Element    class=inventory_item_img
    Page Should Contain Element    class=inventory_item_description


Addede to cart successfully
    [Documentation]    Проверка что товар добавлятся в корзину

    Page Should Contain Element    class=inventory_item
    Click Button    xpath=//*[@id="add-to-cart-sauce-labs-onesie"]

    Page Should Contain Element    class=shopping_cart_link
    ${amount}=    Get Text    xpath=//*[@id="shopping_cart_container"]/a/span

    Should Be Equal As Integers    ${amount}    1

Removed from cart successfully
    [Documentation]    Проверка что товар удаляется из корзины

    Page Should Contain Element    class=inventory_item
    Page Should Contain Element    class=shopping_cart_link

    Click Button    xpath=//*[@id="remove-sauce-labs-onesie"]
    Page Should Not Contain Element    xpath=//*[@id="shopping_cart_container"]/a/span


#Go to item page successfully
#    [Documentation]    Проверка что переходит на страницу товара по нажатию
#
#    Page Should Contain Element    class=inventory_item
#    Scroll Element Into View       xpath=//*[@id="item_4_title_link"]
#    Wait Until Element Is Visible  xpath=//*[@id="item_4_title_link"]    10s
#    Click Element                  xpath=//*[@id="item_4_title_link"]
#
#    Page Should Contain Element    class=inventory_item_container
#
#    Scroll Element Into View       xpath=//*[@id="back-to-products"]
#    Click Element                  xpath=//*[@id="back-to-products"]


Check filters
    [Documentation]    Проверка фильтра по цене
    Page Should Contain Element    class=product_sort_container

    Click Element    class=product_sort_container

    Click Element    xpath=//*[@id="header_container"]/div[2]/div/span/select/option[4]

    ${highest}=    Get Text    xpath=//*[@id="inventory_container"]/div/div[1]/div[2]/div[2]/div[1]
    ${lowest}=    Get Text    xpath=//*[@id="inventory_container"]/div/div[6]/div[2]/div[2]/div
    
    Should Be Equal As Strings    ${highest}    ${HIGHEST_REAL}
    Should Be Equal As Strings    ${lowest}    ${LOWEST_REAL}