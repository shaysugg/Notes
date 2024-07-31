## Define new version
* Select the data model
* On Xcode top menu bar select `Editor` -> `Add New Model Version`
* 
## Things that acceptable for lightweight migration
- Deleting entities, attributes or relationships
- Renaming entities, attributes or relationships using the `renamingIdentifier`
- Adding a new, optional attribute
- Adding a new, required attribute with a default value
- Changing an optional attribute to non-optional and specifying a default value
- Changing a non-optional attribute to optional
- Changing the entity hierarchy
- Adding a new parent entity and moving attributes up or down the hierarchy
- Changing a relationship from to-one to to-many
- Changing a relationship from non-ordered to-many to ordered to-many (and vice versa)

https://developer.apple.com/documentation/coredata/migrating_your_data_model_automatically

Further investigation:
Is it necessary to manually setup the container to perform the migration? (last section in apple doc)
	I don't think so but it's worth to check link below if it's needed
https://stackoverflow.com/a/17475215