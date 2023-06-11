module west

import vweb
import dracks.vest

[heap]
pub struct WebModule {
	vest.Module
mut:
	controllers []&vweb.ControllerPath
}

struct VwebApp {
	vweb.Context
	vweb.Controller
}


pub struct App {
	server VwebApp
	app_module &WebModule
}

pub fn create_server(app_module &WebModule) &App {
	mut west_app := App{
		app_module: app_module
		server: VwebApp{
			controllers: app_module.controllers
		}
	}
	return &west_app
}

pub fn (self &App) run(port int){
	vweb.run(self.server, port)
}

