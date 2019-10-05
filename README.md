# README
This application enables to upload files to Amazon S3. Can download the files uploaded to S3.
While uploading if the file is csv/text file an active job is triggered to process the data in the csv/text files into the database.
The data in the text/csv files should be related the states and counties info. A search option help to get the data filtered based on Zip code or state abbrevation. API's are also available for this search feature.

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
