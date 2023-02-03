*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${URL_GET}    https://reqres.in/api
${ID_user}   12
${ID_Notfound}   1234

*** Keywords ***

GET API USER
    Create Session   test   ${URL_GET}
    ${reponse}=   get request   test   /user/12
    ${status_code}=   convert to String   ${reponse.status_code}
    ${content}=   get from dictionary   ${reponse.headers}   Content-Type
    should be Equal   ${status_code}   200
    should be Equal   ${content}   application/json; charset=utf-8

GET API USER NOT FOUND
    Create Session   GET_REQ   ${URL_GET}
    ${reponse}=   get request   GET_REQ   /user/${ID_Notfound}
    ${status_code}=   convert to String   ${reponse.status_code}
    ${content}=   get from dictionary   ${reponse.headers}   Content-Type
    should be Equal   ${status_code}   404
    should be Equal   ${content}   application/json; charset=utf-8

*** Test Cases ***
Get user profile success
   GET API USER

Get user profile not found
    GET API USER NOT FOUND