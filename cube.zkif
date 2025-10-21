examples meilof$ PYSNARK_BACKEND=zkifbellman python3 cube.py 44
The cube of 44 is 85184
*** zkinterface: writing circuit
*** zkinterface: writing witness
*** zkinterface: writing constraints
*** zkinterface circuit, witness, constraints written to 'computation.zkif'
*** zkinterface: writing circuit
*** zkinterface: writing constraints
*** zkinterface circuit, constraints written to 'circuit.zkif'
examples meilof$ cat circuit.zkif | zkif_bellman setup
Written parameters into /Users/meilof/Subversion/pysnark/examples/bellman-pk
examples meilof$ cat computation.zkif | zkif_bellman prove
Reading parameters from /Users/meilof/Subversion/pysnark/examples/bellman-pk
Written proof into /Users/meilof/Subversion/pysnark/examples/bellman-proof
examples meilof$ cat circuit.zkif | zkif_bellman verify
Reading parameters from /Users/meilof/Subversion/pysnark/examples/bellman-pk
Reading proof from /Users/meilof/Subversion/pysnark/examples/bellman-proof
The proof is valid.
examples meilof$ PYSNARK_BACKEND=zkifbellman python3 cube.py 55
The cube of 55 is 166375
*** zkinterface: writing circuit
*** zkinterface: writing witness
*** zkinterface: writing constraints
*** zkinterface circuit, witness, constraints written to 'computation.zkif'
*** zkinterface: writing circuit
*** zkinterface: writing constraints
*** zkinterface circuit, constraints written to 'circuit.zkif'
examples meilof$ cat computation.zkif | zkif_bellman prove
Reading parameters from /Users/meilof/Subversion/pysnark/examples/bellman-pk
Written proof into /Users/meilof/Subversion/pysnark/examples/bellman-proof
examples meilof$ cat circuit.zkif | zkif_bellman verify
Reading parameters from /Users/meilof/Subversion/pysnark/examples/bellman-pk
Reading proof from /Users/meilof/Subversion/pysnark/examples/bellman-proof
The proof is valid.
