module west

import dracks.vest
import vweb

@[path: '/my_profile']
struct MyProfile {
	vweb.Context
	vweb.Controller
}

pub fn test_module() {
	mut mod := WebModule{}
	mod.register_controller[MyProfile]()

	mod.init()!

	println('Finish test')
	assert mod == mod
	println('Finish test')
}
