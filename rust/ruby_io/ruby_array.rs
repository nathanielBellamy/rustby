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
