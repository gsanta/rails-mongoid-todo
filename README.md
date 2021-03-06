Rails + MongoDB tutorial, demonstrated through a Todo app

For these tutorial I use the Ubuntu 12.04 OS.

1./ Install Ruby on Rails

For Rails development, it is a good practice to use a version manager, because there are major differences between the versions of both the Ruby language and the Rails framework. The most popular version manager is RVM.

System preparation.

First update the package manager.

    $sudo apt-get update

Install curl, wich is used to install RVM.

    $sudo apt-get install curl

Install RVM and Ruby.

    $ \curl -L https://get.rvm.io | bash -s stable --ruby

Install Node.js, which is a JavaScript runtime, and needed for the Rails asset pipline.

    $ sudo apt-get install nodejs

Instruct RVM to use the global gemset.

    $ rvm gemset use global

Install Rails.

Instead of installing Rails globally, it is better to install it for a specific project (to avoid version conflicts).

So first create a folder for the project, 

    $ mkdir todo
    $ cd todo

create a project specific gemset, install Rails and ceate the new application.

    $ rvm use ruby-2.1.5@todo --ruby-version --create
    $ gem install rails
    $ rails new . --skip-active-record

The --skip-active-record flag is important, because by defult a new rails project uses the ActiveRecord model layer, but we don't need it for MongoDB.


2./ Install MongoDB

First import the public GPG key, which ensures the consistency and authenticity of the package.

    $ sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10

Create a /etc/apt/sources.list.d/10gen.list file.

    $ echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/10gen.list

Update the repository.
     
    $ sudo apt-get update

Install the package.

    $ sudo apt-get install mongodb-10gen

3./ Connect mongoDB to the Todo applicatioin.

Now open the Gemfile and add these two lines.

    $ gem 'mongoid', '~> 4', github: 'mongoid/mongoid'
    $ gem 'bson_ext'

The Gemfile stores the gems, used by the application. (A gem is like a lib or package in other programming envrionments). The first gem is the mongoid gem, that is a wrapper around mongoDB and offers a convinient abstraction to interact with the database. The other is a C extension, which makes the database handling faster.

Configure mongoid.

    $ rails g mongoid:config

With these, mongoDB is connected to the app.

The following command generates the base application for the Todo app.

    $ rails g scaffold post title:string body:string starred:boolean

It creates the model, and the corresponding controller and views, so you get a fully functional app, where todos can be added/edited/deleted and listed.

Rails + MongoDB Todo alkalmazás készítése.

A tutorial-hoz Ubuntu 12.04 operációs rendszert használok.

****************************************************************

1./ Ruby on Rails telepítése

Ruby on Rails-ben való fejelsztéshez célszerű egy verzió-kezelő rendszert használni, mert nagy különbségek vannak mind a Ruby nyelv, mind a Rails keretrendszer között. A legnépszerűbb verzió menedzsert RVM-nek hívják.

A rendszer előkészítése.

Frissítsük a csomagkezelőt.
    
    $sudo apt-get update

Telepítsük a curl nevű programot, amit az RVM installálásához fogunk használni.

    $sudo apt-get install curl

Telepítsük az RVM-et és a Ruby-t.

    $ \curl -L https://get.rvm.io | bash -s stable --ruby

Telepítsük a Node.js-t, ami egy JavaScript futtatókörnyezet, és a Rails "asset pipeline" használja (JavaScript fájlok tömörítésére és rendelkezésre bocsátására).

    $ sudo apt-get install nodejs

Állítsuk be, hogy az RVM a globális gemset-et használja. (A gemset gyakorlatilat könyvtárak egy csoportja, ami a felhasználó számára nyújt szolgáltatásokat, pl. adatbázis-elérés.)

    $ rvm gemset use global

Telepítsük a Rails-t.

Ahelyett, hogy a Rails-t globálisan telepítenénk, jobb ezt az adott projetre elkülönítve megtenni (hogy elkerüljük a verziók közötti ütközést).

Tehát először csináljunk egy külön könyvtárat az új projekthez.

    $ mkdir todo
    $ cd todo

Majd készítsünk egy projet-specifikus gemset-et és telepítsük a segítségével a Rails-t.

    $ rvm use ruby-2.1.5@todo --ruby-version --create
    $ gem install rails
    $ rails new . --skip-active-record

A --skip-active-record paraméter nagyon fontos, mert a Rails alapból egy ActiveRecord nevű csomagot használ az adatbázis kapcsolatok kezeléséhez, de ez a MongoDB-vel nem működik. 

2./ MongoDB telepítése

Először importáljuk be a publikus GPG kulcsot, ami biztosítja a csomag konziszteniáját és hitelességét.

    $ sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10

Készítsük el a /etc/apt/sources.list.d/10gen.list fájlt.

    $ echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/10gen.list

Frissítsük a repozitorit.
     
    $ sudo apt-get update

Telepítsünk a mongoDB csomagot.

    $ sudo apt-get install mongodb-10gen

3./ A mongoDB összekötése az alkalmazással.

Nyissuk meg a Gemfile-t és adjuk hozzá ezt a két sort.

    $ gem 'mongoid', '~> 4', github: 'mongoid/mongoid'
    $ gem 'bson_ext'

A Gemfile tartalmazza a gem-eket, amiket az alkalmazás használ. (Egy gem-et úgy lehet elképzelni mint egy lib vagy csomag más programozási környezetekben). Az első hozzáadott gem a mongoid gem, ami egy a mongoDB-vel való interakciót teszi lehetővé. A másik egy C nyelvű kiterjesztés, ami az adatbázis-kezelést gyorsítja.

Konfiguráljuk be a mongoid-ot.

    $ rails g mongoid:config

Ezzel hozzákapcsoltuk a mongoDB-t az alkalmazáshoz.

A következő parancs egy alap alkalmazást generál a Todo alkalmazáshoz.

    $ rails g scaffold post title:string body:string starred:boolean

A parancs megcsinálja a model-t, a hozzá tartozó kontroller-t és nézeteket (views), ezzel egy teljesen funkcionális alkalmazást hozva létre, ahol todo-k vehetők fel, módosíthatók, listázhatók vagy törölhetők.
