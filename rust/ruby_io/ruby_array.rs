use rutie::{Array, Integer};

pub struct RubyArray {}

impl RubyArray {
    pub fn from_vec_i64(vector: Vec<i64>) -> Array {
        let mut result = Array::new();
        for k in vector.iter() {
            result.push(Integer::new(*k));
        }
        result
    }
}

#[cfg(test)]
mod ruby_array_spec {

    #[test]
    #[allow(non_snake_case)]
    fn from_vec_i64__returns_rutie_array_of_integers() {
        // TODO: rutie::VM::init() in multiple tests
        // VM::init();
        // let test_vec: Vec<i64> = vec![2, 3, 5, 7];
        // let res_arr = RubyArray::from_vec_i64(test_vec);

        // assert_eq!("[2, 3, 5, 7]", res_arr.to_s().to_str());
        // VM::exit(0);
    }
}
