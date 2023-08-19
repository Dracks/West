module west

import vweb
import dracks.vest

[heap]
pub struct WebModule {
	vest.Module
mut:
	controllers []&vweb.ControllerPath
}

pub fn (mut self WebModule) import_web_module(mut mod WebModule) {
	self.import_module(mut mod.Module)
	for controller in mod.controllers {
		if !self.controllers.contains(controller) {
			println('adding')
			self.controllers << controller
		}
	}
}

struct VwebApp {
	vweb.Context
	vweb.Controller
}

pub struct App {
	server     VwebApp
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

pub fn (self &App) run(port int) {
	vweb.run(self.server, port)
}
