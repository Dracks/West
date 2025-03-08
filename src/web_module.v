module west

import veb
import dracks.vest

@[heap]
pub struct WebModule {
	vest.Module
mut:
	controllers []&veb.ControllerPath
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

struct VebContext {
	veb.Context
}

pub struct VebApp {
	veb.Controller
}

pub struct App {
	app_module &WebModule
mut:
	server VebApp
}

pub fn create_server(app_module &WebModule) &App {
	mut west_app := App{
		app_module: app_module
		server:     VebApp{
			controllers: app_module.controllers
		}
	}
	return &west_app
}

pub fn (mut self App) run(port int) {
	veb.run[VebApp, VebContext](mut self.server, port)
}
