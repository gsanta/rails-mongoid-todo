Rails + MongoDB Todo alkalmazás készítése.

A tutorial-hoz Ubuntu 12.04 operációs rendszert használok.

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
