## Categories
* Core
* Data
	* DataSource
		* API URLS
		* DTO
	* Repository (Implementation)
* Domain
	* Entity
	* UseCase
	* Enum
	* Repository (abstraction)
* Presentation
	* Widget
	* Pages
	* Routers


## Dependencies
DATA 
-> Domain
-> Core

Presentation 
-> Domain
-> Data
-> Core

*Domain and Core should not depend on anything.*
*Each Layer can have its own Utilities and helpers.*
