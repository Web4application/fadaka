Fadaka Smart Contract: ARC-inspired Resource Management
=======================================================

Overview
--------
This smart contract simulates Automatic Reference Counting (ARC) inspired
resource management for Ethereum-like blockchains. It handles retained,
unowned, and bridge-like resources with safe operations for null addresses
and external calls.

Contract Definition
-------------------
.. code-block:: solidity

    contract ResourceARC {

Storage
-------
- **retainedResources**: Mapping of user addresses to retained resource amounts.
- **unownedResources**: Mapping of user addresses to unowned resource amounts.

.. code-block:: solidity

        mapping(address => uint256) public retainedResources;
        mapping(address => uint256) public unownedResources;

Events
------
- **Retain**: Emitted when resources are retained for a user.
- **Release**: Emitted when resources are released.
- **BorrowUnowned**: Emitted when unowned resources are borrowed.
- **ReturnUnowned**: Emitted when unowned resources are returned.

.. code-block:: solidity

        event Retain(address indexed owner, uint256 amount);
        event Release(address indexed owner, uint256 amount);
        event BorrowUnowned(address indexed borrower, uint256 amount);
        event ReturnUnowned(address indexed borrower, uint256 amount);

Functions
---------

Trivial Retain / Release
^^^^^^^^^^^^^^^^^^^^^^^
.. code-block:: solidity

        function trivialRetainRelease(address user, uint256 amount) public {
            retain(user, amount);
            release(user, amount);
        }

Internal Resource Management
^^^^^^^^^^^^^^^^^^^^^^^^^^
.. code-block:: solidity

        function retain(address user, uint256 amount) internal {
            require(user != address(0), "Cannot retain null address");
            retainedResources[user] += amount;
            emit Retain(user, amount);
        }

        function release(address user, uint256 amount) internal {
            require(user != address(0), "Cannot release null address");
            uint256 held = retainedResources[user];
            require(held >= amount, "Not enough resources to release");
            retainedResources[user] -= amount;
            emit Release(user, amount);
        }

Unowned / Bridge Resources
^^^^^^^^^^^^^^^^^^^^^^^^^
.. code-block:: solidity

        function borrowUnowned(address borrower, uint256 amount) public {
            require(borrower != address(0), "Invalid borrower");
            unownedResources[borrower] += amount;
            emit BorrowUnowned(borrower, amount);
        }

        function returnUnowned(address borrower, uint256 amount) public {
            require(borrower != address(0), "Invalid borrower");
            uint256 held = unownedResources[borrower];
            require(held >= amount, "Nothing to return");
            unownedResources[borrower] -= amount;
            emit ReturnUnowned(borrower, amount);
        }

Safe Null Operation Example
^^^^^^^^^^^^^^^^^^^^^^^^^^
.. code-block:: solidity

        function safeRetainRelease(address user, uint256 amount) public {
            if (user == address(0)) return;  // skip nulls
            retain(user, amount);
            release(user, amount);
        }

Complex Operation / Retain Motion
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. code-block:: solidity

        function retainMotion(address user, uint256 amount, uint256 extra) public {
            retain(user, amount);
            // Perform operations while holding resources
            retainedResources[user] += extra;
            release(user, amount);
        }

Unknown / External Calls
^^^^^^^^^^^^^^^^^^^^^^
.. code-block:: solidity

        function unknownCallMotion(address user, uint256 amount, address externalAddr) public {
            retain(user, amount);
            // Call external contract (like Swift's unknown_func)
            IExternal(externalAddr).doSomething(user, amount);
            release(user, amount);
        }

External Interface
------------------
.. code-block:: solidity

    interface IExternal {
        function doSomething(address user, uint256 amount) external;
    }
