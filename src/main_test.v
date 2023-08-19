module west

import dracks.vest
import vweb

[path: '/my_profile']
struct MyProfile {
	vweb.Context
}

pub fn test_module() {
	mut mod := WebModule{}
	mod.register_controller[MyProfile]()

	assert mod == mod
}
