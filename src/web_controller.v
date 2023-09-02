module west

import vweb
import dracks.vest

struct Controller {
	instance &vweb.ControllerPath
	path     string
}

/*
fn (self Controller) to_web_controller() &vweb.ControllerPath{
	c := Controller{}
	return vweb.controller(self.path, c)
}*/

fn get_path[T]() ?string {
	mut paths := []string{}
	$for attr in T.attributes {
		$if attr.name == 'path' {
			paths << attr.arg
		}
	}
	assert paths.len <= 1

	if paths.len > 0 {
		return paths.first()
	}
	return none
}

pub fn (mut self WebModule) register_controller[T]() {
	new_controller := self.register[T]()
	if false {
		other := vest.Object(T{})
		println(other)
	}

	path_prefix := get_path[T]() or { '/' }

	self.controllers << vweb.controller(path_prefix, new_controller)
}

/*
fn (self &WebModule) get_all_controllers() []&vweb.ControllerPath {
	mut controllers := []Controller{}
	for controller in self.controllers{
		controllers << controller
	}

	return controllers.map(it.to_web_controller())
}*/
