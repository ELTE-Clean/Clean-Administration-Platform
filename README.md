# Clean-Administration-Platform

## Technologies

## Front-End:
 - Next.JS 
 - React.JS
 - Typescript


## Back-End:
 - Express.js
 - Postgresql
 - Auth: keycloak
 - To test if the Keycloak Authentication works: 
    * `docker exec -it clean_administration_platform_backend_1 sh`
    * `wget -O - --header 'Content-Type: application/x-www-form-urlencoded' --post-data "username=teacher-1&password=123&client_id=cap-app&client_secret=aQX4Vdbe7PhQTPCwRdeOwIdQzbpGkOdw&grant_type=password" "http://nginx/auth/realms/CAP/protocol/openid-connect/token"`
    * Means: 
    * You will get an access_token + refresh_token. The previous means that the authentication was valid as a teacher. You can access the application freely.


Env: Docker K8S
Automation: Python

## Application architecture
![Untitled Diagram drawio](https://user-images.githubusercontent.com/48254077/153008152-10429da8-3431-4b5e-a9b9-46ac501ccd35.png)

## Example student report for now

<details>
<summary>MI3JG2</summary>
<br>
<ul>
<li>
      <details>
      <summary>addInt</summary>
      <br>
      Test case: 1 2<br>
      Teacher result: 3<br>
      Student result: 3<br>
      --------------------------------------------------<br>
      Test case: 1 3<br>
      Teacher result: 4<br>
      Student result: 4<br>
      </details>
</li>
<li>
      <details>
      <summary>subInt</summary>
      <br>
      Test case: 1 2<br>
      Teacher result: 3<br>
      Student result: 3<br>
      --------------------------------------------------<br>
      Test case: 1 3<br>
      Teacher result: 4<br>
      Student result: 4<br>
      </details>
</li>
<ul>
</details>

<details>
<summary>HJ3FT6</summary>
<br>
<ul>
<li>
      <details>
      <summary>addInt</summary>
      <br>
      Test case: 1 2<br>
      Teacher result: 3<br>
      Student result: 3<br>
      --------------------------------------------------<br>
      Test case: 1 3<br>
      Teacher result: 4<br>
      Student result: 4<br>
      </details>
</li>
<ul>
</details>
<details>
<summary>HU5TY7</summary>
<br>
<ul>
<li>
      <details>
      <summary>addInt</summary>
      <br>
      Test case: 1 2<br>
      Teacher result: 3<br>
      Student result: 3<br>
      --------------------------------------------------<br>
      Test case: 1 3<br>
      Teacher result: 4<br>
      Student result: 4<br>
      </details>
</li>
<li>
      <details>
      <summary>subInt</summary>
      <br>
      Test case: 1 2<br>
      Teacher result: 3<br>
      Student result: 3<br>
      --------------------------------------------------<br>
      Test case: 1 3<br>
      Teacher result: 4<br>
      Student result: 4<br>
      </details>
</li>
<ul>
</details>

To view the full debug logs add the following lines to the keycloak .env file.
* KEYCLOAK_LOGLEVEL=DEBUG
* ROOT_LOGLEVEL=DEBUG
