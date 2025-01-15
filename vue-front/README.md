<!--NOTA PARA MI MISMA:
For local development: Set up the PHP API files in C:\xampp\htdocs\api. Initialize the connection with XAMPP. The API stablishes a connection to a remote MySQL hosted in (https://console.aiven.io/)[Aiven]-->

## newsMagazine
Online news portal with capacity for a robust amount of articles. Common users are able to read an unlimited amount of essays and news uploaded by the organization's writers. Collaborators can access and edit their public profiles and create their pieces from inside the webpage.

</br>
This website is yet to be released! Follow to see the project updates
<br>

### :wrench: Built With
<b>[VueJS](https://vuejs.org/)</b> - An approachable, performant and versatile JavaScript framework for building web user interfaces.
<br>
<b>Custom PHP Rest API</b> which purpose is to communicate the Front-End with the database and allow the user to Create, Read, Update and Delete (CRUD) registries.

### Technical knowledge used in this project:
- Custom Rest API built from scratch with PHP
- Web and Database Architecture
- Production Deployment (Firebase and Aiven)
- Custom Carousels based on [@luveqz tutorial](https://dev.to/luvejo/how-to-build-a-carousel-from-scratch-using-vue-js-4ki0)
- Implement UI design and expand it to create new layouts
- Full responsiveness and adaptability


##  :warning: THIS PROJECT IS A WORK IN PROGRESS :warning:
Currently working on the Minimun Viable Product phase

### :computer: Set up
REQUIREMENTS: VueJS, Xampp control panel, MySQL


 Clone the repository ``git clone https://github.com/MartinaFSA/newsMagazine``

 Install the dependencies and modules ``npm install``

 Run the Front-End side of the app ``npm run dev``

 Copy the api folder into htdocs inside your xampp folder and initialize Apache in the control panel

 Create a database using the queries located in the scripts folder (first createTables, then insertDummyData, lastly create the Stored Procedures)

 Stablish the connection between your database and API by updating the credentials.
