Rails + MongoDB tutorial, demonstrated through a Todo app

requirements: Ubuntu

1./ Install Ruby on Rails

For Rails development, it is a good practice to use a version manager, because there are major differences between the versions of both the Ruby language and the Rails framework. The most popular version manager is RVM.

System preparation:

First update the package manager:

    $sudo apt-get update

Install curl, wich is used to install RVM:

    $sudo apt-get install curl

Install RVM and Ruby:

    $ \curl -L https://get.rvm.io | bash -s stable --ruby

Install Node.js, which is a JavaScript runtime, and needed for the Rails asset pipline.

    $ sudo apt-get install nodejs

Instruct RVM to use the global gemset:

    $ rvm gemset use global

Install Rails:

Instead of installing Rails globally, it is better to install it for a specific project (to avoid version conflicts).

So first create a folder for the project, 

    $ mkdir todo
    $ cd todo

create a project specific gemset, install Rails and ceate the new application:

    $ rvm use ruby-2.1.5@todo --ruby-version --create
    $ gem install rails
    $ rails new . --skip-active-record

The --skip-active-record flag is important, because by defult a new rails project uses the ActiveRecord model layer, but we don't need it for MongoDB.


Install MongoDB

First import the public GPG key, which ensures the consistency and authenticity of the package:

    $ sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10

Create a /etc/apt/sources.list.d/10gen.list file:

    $ echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/10gen.list

Update the repository:
     
    $ sudo apt-get update

Install the package:

    $ sudo apt-get install mongodb-10gen

Now open the Gemfile and add these two lines:

    $ gem 'mongoid', '~> 4', github: 'mongoid/mongoid'
    $ gem 'bson_ext'

The Gemfile stores the gems, used by the application. (A gem is like a lib or package in other envrionments). The first gem is the mongoid gem, that is a wrapper around mongoDB and offers a convinient abstraction to interact with the database. The other is a C extension, which makes the database handling faster.

Configure mongoid:

    $ rails g mongoid:config

With these, mongoDB is connected to the app.

The following command generates the base application for the Todo app.

    $ rails g scaffold post title:string body:string starred:boolean

It creates the model, and the corresponding controller and views, so you get a fully functional app, where todos can be added/edited/deleted and listed.
