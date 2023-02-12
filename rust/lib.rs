#[macro_use]
extern crate rutie;

use rutie::{Class, Object, RString};

class!(RUST);

methods!(
    RUST,
    _rtself,
    fn hello(_input: RString) -> RString {
        RString::new_utf8("!!!HELLO FROM RUST!!!")
    }
);

#[allow(non_snake_case)]
#[no_mangle]
pub extern "C" fn Init_rustby() {
    Class::new("RUST", None).define(|klass| {
        klass.def_self("hello", hello);
    });
}
