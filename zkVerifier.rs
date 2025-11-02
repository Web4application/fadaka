use ark_groth16::{verify_proof, PreparedVerifyingKey, Proof};
use ark_serialize::CanonicalDeserialize;
use std::fs::File;

pub fn verify_zkfusion_proof(proof_bytes: Vec<u8>, pvk_path: &str, root: [u8; 32], leaf: [u8; 32]) -> bool {
    let pvk_file = File::open(pvk_path).expect("Unable to open verifying key");
    let pvk: PreparedVerifyingKey<_> = PreparedVerifyingKey::deserialize_unchecked(&pvk_file).unwrap();
    let proof: Proof<_> = Proof::deserialize_unchecked(&*proof_bytes).unwrap();
    verify_proof(&pvk, &proof, &[root.into(), leaf.into()]).unwrap_or(false)
}
