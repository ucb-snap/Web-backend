## README

Welcome to the new Snap! website and backend.

Please checkout http://snappage.herokuapp.com/ to see current progress that has been
made. This page will be used as a showcase of the current progress of the website.

This GitHub Repository will be used by the UC Berkeley Snap! Development team to build the
new web Application for UC Berkeley Snap!

This app will have a backend built in Ruby, and the necessary classes can be found in app/models.
The front end will be built using CSS, Html, Haml, and ERB.

In order to help develop, please contact Kyle Hotchkiss to gain access to the Pivotal Tracker project
for the website to see the current development progress and features currently in development.

## Initial Install

To install and run locally, please initially be familiar with using Rails, Ruby, and using them in a
Development environment.

For Mac - You will first need to install in order [Homebrew](http://brew.sh/), [Ruby Version Manager](https://rvm.io/rvm/install)
and Bundler (run 'gem install bundler') to be able to run the project.

For Linx/Ubuntu - You will need  [Ruby Version Manager](https://rvm.io/rvm/install), and Bundler (run 'gem install bundler')
to be able to run the project.

For Windows - We will add instructions for Windows machines shortly.

Once you have downloaded the source files, navigate to the directory, and in your terminal run
"bundle install --without production". This command installs all of the necessary Gems needed to
run a local version of the app. After this, running the the "rails server" command will launch the locally
running version of the app, along with the pre-seeded database. You will be able to view the web app at
"https://localhost:3000/", which is the default port for a local rails based app. From here, you will
be able to visualize the current progress that has been made.

If you have any other questions, please feel free to contact Kyle Hotchkiss or Natasha Sandy.

Thank you.


## Progress Log

As of April 27, 2015, Users have the ability to privately message multiple users, create and enroll in courses,
create projects, and comment on projects. The first refactoring of code was just finished, allowing for a more
uniform code base, that is not only easier to understand, but easier to program in, as it is less cluttered,
has shorter and more concise functions, and is follows favorable design patterns.
The current pipeline includes implementing assignments for classes, as well as search functionality for public
users, projects, and classes.

As of March 2nd, 2015, the "Devise" gem has been implemented to be used for user creation, updating user
information, and user authentication. This gem automates a lot of parts for user information, and thus,
we now use these routes for the appropriate actions as opposed to the ones that were previously implemented.

As of February 23rd, 2015, the appropriate databases for setting up projects, classes, and assignments are
configured. The appropriate models for these objects are also set up, as well as the appropriate routes and
associations. A couple buttons have been added to the user's information page, allowing for them to create
a new project, and if they are a teacher, they can create a new class. The necessary views have yet to be
completed, and while the controllers for these models have the necessary functions defined, they are not
completed. Work should begin shortly in bringing these features up and running correctly.

As of February 18th, 2015, Users have the ability to log in. Logging in allows them to edit their information,
or delete their account. WARNING: Password security is not implemented.

As of February 15th, 2014, there is a working app. From the snapuser page, a directory of the current
user database (as filled by seed.rb). From here, users can view more information about the users, or
create a new user. From the details page of a user, one can choose to edit the information of a user.

This current view is going to be used as a basic example on how the Rails Framework is used and how to
generate web views from data stored in a database. From here, we will begin adding basic log in and
authentication functionality, and start to design the proper web views.

## Primary Files
Models:
  User
  Project
  Course
  Conversation
  Message
  Comment

Controllers:
  User Controller     - Handles all User actions not handled by Devise
  Project Controller  - Handles all Project actions
  Course Controller   - Handles all Course actions
  Message Controller  - Handles all Conversation and Message actions
