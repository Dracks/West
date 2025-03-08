module west

import veb

@[path: '/my_profile']
struct MyProfile {
}

struct MyProfileContext {
	veb.Context
}

pub fn test_module() ! {
	mut mod := WebModule{}
	mod.register_controller[MyProfile, MyProfileContext]()!

	mod.init()!

	println('Finish test')
	assert mod == mod
	println('Finish test')
}
