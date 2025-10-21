Fadaka Smart Contract Test Suite
================================

Overview
--------
This document describes the test cases for the `ResourceARC` smart contract.
The tests simulate ARC-inspired resource management and validate retain, release,
unowned resource borrowing/returning, safe null operations, complex motions, and
external interactions.

Test Cases
----------

1. Trivial Retain / Release
~~~~~~~~~~~~~~~~~~~~~~~~~~~
**Purpose:** Verify that resources can be retained and released without errors.

.. code-block:: solidity

    function testTrivialRetainRelease() public {
        uint256 initial = resourceARC.retainedResources(user);
        resourceARC.trivialRetainRelease(user, 100);
        uint256 finalAmount = resourceARC.retainedResources(user);
        assert(finalAmount == initial); // Should balance after retain + release
    }

2. Retain Resources
~~~~~~~~~~~~~~~~~~
**Purpose:** Confirm that resources are added correctly when retained.

.. code-block:: solidity

    function testRetain() public {
        uint256 before = resourceARC.retainedResources(user);
        resourceARC.retain(user, 50);
        uint256 after = resourceARC.retainedResources(user);
        assert(after == before + 50);
    }

3. Release Resources
~~~~~~~~~~~~~~~~~~~
**Purpose:** Ensure resources can be released and prevent over-release.

.. code-block:: solidity

    function testRelease() public {
        resourceARC.retain(user, 100);
        uint256 held = resourceARC.retainedResources(user);
        resourceARC.release(user, 40);
        assert(resourceARC.retainedResources(user) == held - 40);
    }

4. Borrow / Return Unowned Resources
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
**Purpose:** Verify borrowing and returning unowned resources works properly.

.. code-block:: solidity

    function testBorrowReturnUnowned() public {
        resourceARC.borrowUnowned(user, 30);
        assert(resourceARC.unownedResources(user) == 30);

        resourceARC.returnUnowned(user, 20);
        assert(resourceARC.unownedResources(user) == 10);
    }

5. Safe Null Operations
~~~~~~~~~~~~~~~~~~~~~~
**Purpose:** Confirm that operations with null addresses do not revert.

.. code-block:: solidity

    function testSafeRetainReleaseNull() public {
        resourceARC.safeRetainRelease(address(0), 50);
        // Expect no revert and no change to retainedResources mapping
    }

6. Complex Retain Motion
~~~~~~~~~~~~~~~~~~~~~~~
**Purpose:** Test retain motion where resources are held during operations.

.. code-block:: solidity

    function testRetainMotion() public {
        uint256 before = resourceARC.retainedResources(user);
        resourceARC.retainMotion(user, 50, 25);
        assert(resourceARC.retainedResources(user) == before + 25);
    }

7. Unknown / External Call Motion
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
**Purpose:** Ensure ARC-like semantics are preserved across external calls.

.. code-block:: solidity

    function testUnknownCallMotion() public {
        IExternal mock = new MockExternal();
        uint256 before = resourceARC.retainedResources(user);
        resourceARC.unknownCallMotion(user, 50, address(mock));
        // Retain + release ensures balance after external call
        assert(resourceARC.retainedResources(user) == before);
    }

Mock External Contract
---------------------
To simulate external calls for testing `unknownCallMotion`:

.. code-block:: solidity

    contract MockExternal is IExternal {
        function doSomething(address user, uint256 amount) external override {
            // Simulate arbitrary external action
        }
    }

Event Verification
------------------
Each test can additionally verify that the correct events were emitted:

- `Retain` and `Release` for retain/release operations.
- `BorrowUnowned` and `ReturnUnowned` for unowned resource operations.
