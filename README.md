# Test App
A simple iOS application with a TabBar controller, where the first tab contains a local table of editable items, and the second tab displays a list of data fetched from a network request in XML format.

Implemented entirely without the use of third-party libraries. Core Data is used for storage, URLSession for network requests, and XMLParser for parsing the response.

# Architecture
VIPER/Clean Swift architecture with distinct layers of the application:

* App
* VIPER Modules: Main, List, Item, Service
* Common, Persistence, Networking
* Core (Models)

# Code Generation
[Generamba](https://github.com/strongself/Generamba) and a modified [swifty_viper](https://github.com/strongself/generamba-catalog) template are used for code generation of the basic structure of VIPER modules.
