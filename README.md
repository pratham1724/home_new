The project Title is "Future U"

	Technologies used :- 
Programming Languages: ruby ( version - 3.2.2 )

framework: ruby on rails

Frontend: HTML, CSS

Backend: ruby on rails ( version - 7.0.6 )

Database: SQLite3 ( version - 1.4 )

  Description :- 
Hello guys, this is a Fitness app.

Where a user wlll have 2 roles ( "Trainer", "Client" ).

- If a user is Trainer. 

1) He can sign up to the site.

2) Trainer can create his/her profile.

3) Trainer can create and destroy post for clients.

4) Can Destroy comments on his post.

5) Trainer can Approve his pending appointments of clients.

6) Trainer can chat with his clients.

7) can view his Client List.



- If User is a Client.

1) Can sign up to the site

2) can create his own profile.

3) can see all trainer's profiles.

4) can comment on their posts.

5) can destroy his own comments.

6) can schedule appointment with the Trainer.

7) can chat with his Trainer after Trainer approves his appointment.

8) can rate trainer from 1 to 5 and can also update his ratings.

9) can view his Trainer List.

  Gem Used

Letter Opener - to see all the mails.
Devise - to handel authentication.
wil_paginate - to divide the content in multiple pages.
redis - for chat functionality.
byebug - to resolve bugs.
cancancan - for authorization.
image_processing - for resizig images.
active_storage - for uploading photos.
bourbon - for design.
bitters - for design.
sassc - to use of the original Ruby Sass library.

  Before running project do this necessary commends.

1) bundle install - to install all the gems.

2) rails db:migrate  - to make the schema.

3) rails db:seed to create admin user and testing data.

