Couchup
========

This is a command line interface to CouchDb.


Installaton
===========

gem install couchup

Tested on Ruby 1.9, 1.8.7, REE and Rubunius. (Does not work on jruby for reasons i have not debugged)

Usage
======

Couchup is a command line utility piggybacking on the irb. So you can do all the ruby stuff in it.
Type help on command line to list the stuff you can do with couchup.


$ couchup
> help


You see a bunch of commands that you can use.
Remember this is just an IRB, so the command syntax is a little verbose.

create :database, :riders (Note the commas and symbols)

Also symbols and strings can be used interchangebly, So the above is the same as

create "database", "riders"

Some Common Things to do with couchup
=====================================

Basics
--------

Connects to the couch server at foo.bar.com on the default port of 5984

> connect "foo.bar.com"

Connects to local couch on localhost at 5984

> connect

To use a specific database switch with.

> use :riders

Most Couchup commands need you to be on a specific database.


# Getting documents
--------------------

Get all documents from the current database.

> get

gets docucment by the given ID.

> get "id"


#Running views
--------------

There are 2 different commands.
map Will just run the map function
view : will run both the map and reduce.
They have very similar semantics, except for where noted.

> map "Rider/all"

Found 1 item(s)

{"id"=>"78ea2a07be87b6fa0e4afed5d81f3729", "key"=>"78ea2a07be87b6fa0e4afed5d81f3729", "value"=>1, "doc"=>{"_id"=>"78ea2a07be87b6fa0e4afed5d81f3729", "_rev"=>"2-fb5e1207a12f996e287fa23986ac7077", "number"=>"101", "start_time"=>"2011-02-17T18:18:58+05:30", "end_time"=>"2011-02-17T18:20:24+05:30", "type"=>"rider", "couchrest-type"=>"Rider"}}

> map "Rider/all", "78ea2a07be87b6fa0e4afed5d81f3729"

will return only only the document matching the above key.


The following will query the view with a post to get all the matching keys.

map "Rider/all", ["78ea2a07be87b6fa0e4afed5d81f3729", "ee23399aad3f8685e64f455504000d49"]

The following will query the view with a startkey and endkey semantics.

map "Rider/all", :startkey=> "78ea2a07be87b6fa0e4afed5d81f3729", :endkey=> "ee23399aad3f8685e64f455504000d49"


The same rules apply for *view* command as  well, and additionally it takes the group_level parameter as well.

view "Rider/all", :startkey=> "78ea2a07be87b6fa0e4afed5d81f3729", :endkey=> "ee23399aad3f8685e64f455504000d49"


# Creating and modifying views.
-------------------------------

It is important to set the EDITOR variable before running couchup, because we use the EDITOR to pop up an edit window

> create :view, "Rider/test"

Will pop a textmate/emacs/vi window with some templates. If the view exists it will show the existing code. So you can modify it.


To cancel creation of the view, just empty the contents of the file and save.




