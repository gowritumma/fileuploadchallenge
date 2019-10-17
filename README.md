# README
This application enables to upload files to Amazon S3. Can download the files uploaded to S3.
While uploading if the file is csv/text file an active job is triggered to process the data in the csv/text files into the database.
The data in the text/csv files should be related the states and counties info. A search option help to get the data filtered based on Zip code or state abbrevation. API's are also available for this search feature.

Heroku website link :
https://enigmatic-anchorage-31092.herokuapp.com/

Feature that are developed.
1. User login, authentication, edit user, sign_out features developed using devise.

2. Added a menu bar that shows Logout, Edit_profile, Upload a file, Search for counties and states, uploaded file info.

3. Upload a file : you can upload any file to Amazon S3 bucket. Here I did not work on showing the progess bar while uploading.

     If the uploading is successful, a back ground job is run to process the data of the file to put into the database.

4. Upload file info link shows all the files uploaded to S3 and can download file using the download link provided.

5. Search for counties and states link has two fields : state abbr and zip. 

If state abbrevation is given it will get the count of all the cities, counties and zip codes.
If zip is given, it will show the state, state_abbr, county and city.
6. API's for the above two search are developed.

https://enigmatic-anchorage-31092.herokuapp.com/api/v1/counties/get_counties_with_zip?zip=A00501A
https://enigmatic-anchorage-31092.herokuapp.com/api/v1/counties/get_counties_states_abbr?abbr=AK 

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
2.4.1

* System dependencies

* Configuration

* Database creation
Postgres

* Database initialization
run rails db:migrate
* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
Url to heroku website is 
https://enigmatic-anchorage-31092.herokuapp.com/
