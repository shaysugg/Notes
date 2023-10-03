Elements are separated into two main categories: **Core Logic** and **User Interface** **Logic**.
## Core Logic
### Entity
Also known as data-model objects, are light-weight structured data containers.
### Data Store
They are responsible for CRUD operations and they abstract away underlying data storage mechanism.
### Remote API
Remote APIs talk to the network. They can create the endpoint and handle the response.
### UseCases
Use cases represent the **user stories** that make up your app.
After you build all the use cases, you should be able to build a command line interface for your app using the use cases you’ve defined.

### Broadcasters
Broadcasters notify subscribers when something in your app happens.
*As an example, you could create a reusable keyboard broadcaster that subscribes to the relevant system keyboard notifications*

## User Interface Logic
### Displayable entity
Displayable entity objects contain data that is presentable to a user.

## Observer
Observers are objects that receive external events. These events are input signals to view controllers. Observers know how to subscribe to events, process events and deliver processed events to view controllers
## User interface
## Interaction responder
User interfaces are dumb. They know when something happens but they don't know how to handle it. The user interface asks its interaction responder to do some operation and interaction responder knows which UseCase it needs to call.
Interaction responders are usually the ViewControllers.