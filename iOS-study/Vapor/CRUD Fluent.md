# Benefits of using foreign keys

assume ==Category== contains bunch of ==Notes== s

* It ensures you can’t create ==Note== with ==Category== that don’t exist.
* You can’t delete ==Category== until you’ve deleted all their ====Note====s.
* You can’t delete the ==Category== table until you’ve deleted the ====Note==== table.