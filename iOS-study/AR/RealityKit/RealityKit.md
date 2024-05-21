## WWDC Fish video notes
Architect(ECS)
* entity
* components
* systems

Components represent states
We have model components that represent the shape of an entity
Entity Query is used to filter and reterive scene entities in systems
systems: three important parts
* init
* query
* dependencies
Components is a good place to store data
We can add or remove components from an entity (with subclassing this wouldn't be possible)

* Define a general setting
* wrap it in a components
* send the setting component to entities
## Systems
systems defines encapsulated logic
systems apply logic on entities based on their components
systems has two advantage in compare to traditional ARKit delegate implementations
1) Behaviors now go into one system and can be applied on multiple entities. no code duplication on entity implementation
2) instead of each entity performs a work which sometimes can be duplication of other entities that have the same behavior systems only run that work once in each frame and apply that to different entities.