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

## Social
For the following system, we use this gem [acts_as_follower](https://github.com/tcocca/acts_as_follower)
For the votation system (upvote...), we use this gem [acts_as_votable](https://github.com/ryanto/acts_as_votable)
=> There is probably a cache column to add to the votable models, to increase performance, on the votation system. Cf. gem's doc.

## Collections

### Status
For the collections status, we used the enumerated types.
An integer is stored in the database in the column 'status'.
And interpreted by the enum methods in the model Collection, so that:
* 1 - `:is_public`
* 2 - `:is_open`
* 3 - `:is_private`

At first, we would like to use `:public` and `:private`, but the enum methods generates class and instance methods with this names that conflicted with active record.

Now, the following methods are available:
```
# Query method
collection.ìs_public?
collection.is_open?
collection.is_private?

# Action method
collection.ìs_public!
collection.is_open!
collection.is_private!

# List of statuses and their corresponding values in the database.
Collection.statuses
```

There should be some scope methods as well. Must dig into docs and posts for more information.
Some resources :
[Enumerated Types with ActiveRecord and PostgreSQL (SitePoint)](https://www.sitepoint.com/enumerated-types-with-activerecord-and-postgresql/)
[What's New in Edge Rails: Active Record enums (ThoughtBot)](https://robots.thoughtbot.com/whats-new-in-edge-rails-active-record-enum)
[ActiveRecord::Enum](http://edgeapi.rubyonrails.org/classes/ActiveRecord/Enum.html)

## Testing (RSpec)

For testing, we use RSpec framework.

To launch test: `bundle exec rspec`
You can also trigger specific test, like `bundle exec rspec spec/models` for instance.
See `rspec-rails` doc for more information: [rspec-rails](https://github.com/rspec/rspec-rails)

Each new feature and new code must be tested before any merge into the master branch.
If you notice some legacy code without any test, please pull a branch and write the specs, then pull request. I'll appreciate it.

---

Rails app generated with [lewagon/rails-templates](https://github.com/lewagon/rails-templates), created by the [Le Wagon coding bootcamp](https://www.lewagon.com) team.

