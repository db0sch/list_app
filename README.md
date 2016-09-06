# Minimal

## What is it?
a resource sharing app

## Details
Name : Minimal
Url : mnmlist.co / mnmlist.io

## What can you do with it? What do we want to achieve?
Create collection of links about a specific subject.
Each collection has one :
Title
Summary
Several resource
Can be starred
Can be followed
Upvoted or downvoted

Each resource in a collection can be :
Upvoted
Downvoted
Commented

Each resource has its own page => tbd

A collection is public by default.
Though it can be set to private, but is not sharable than.

A collection is shareable, via social network, to any person, even to user not signed in.
To star or comment a collection, to vote or comment a resource, you must be signed in.

Extra features :
Users can submit links to other user collection
A collection can be forked
Get an email with a resume of the activity of the week (list you watch, people you follow).

## User stories

AS A USER, I can create a list, and give it a title and a description.
AS A USER, I can add resource to links to a list, and give the resource a title and a description.
AS A USER, I can edit a resource and hist title and description.
AS A USER, I can see, star, watch, and comment other's lists.
AS A USER, I can upvote links inside a list, and comment on them.
AS A USER, I can share my lists or other's list on social network (or mail...)
AS A USER, I can search for lists and links, through a search engine.
AS A USER, I can suggest a resource to an other user's list, and he can agree or not to publish it in the list.
AS A VISITOR, I can search through a search engine, to see portfolio and links.
AS A VISITOR, I cannot create a portfolio, add a resource, star or comment.

## db schema

The database schema xml file is provided in the root folder of this repo => file_name: `mnmlist_db_schema.xml`
You can view the schema by importing this xml code to : [db.lewagon.org](http://db.lewagon.org)

---

Rails app generated with [lewagon/rails-templates](https://github.com/lewagon/rails-templates), created by the [Le Wagon coding bootcamp](https://www.lewagon.com) team.

