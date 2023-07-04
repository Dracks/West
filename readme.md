# West: The Modular web framework for V
West is a wrapper of vweb dessigned to emulate the way nestjs works. Currently only supports some basic stuff, as register services (using the [vest module system](http://github.com/Dracks/vest/)) and vweb controllers.


This is a simple example of how to use west:
```vlang 
module main
import vweb

import dracks.west

// We create some service
struct HomeService {
mut:
	counter int
}

fn (mut self HomeService) on_init()! {
    self.counter = 0
}

fn (mut self HomeService) count() int {
	self.counter = self.counter +1
	return self.counter
}

// This struct will be our controller
struct HomePage {
	vweb.Context
	vweb.Controller
mut:
	service &HomeService [inject; vweb_global]
}

['/']
fn (mut self HomePage) main() vweb.Result{
	counter := self.service.count()
	return self.html("Hello world user ${counter}")
}


fn main() {
    // Create a new module
	mut app_module := west.WebModule{}
    // register in this module the service, you can use also register_and_export to export this service and make it available to other modules
	app_module.register[HomeService]()

    // Register the controller
	app_module.register_controller[HomePage]()

    // Init everything, this will inject the service, and also call the on_init functions in all the structs
	app_module.init()!

    // Create the server
	web_app := west.create_server(app_module)

    // Runs on the port 8020
	web_app.run(8020)
}
```
