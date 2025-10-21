// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

// Import the ResourceARC contract
import "./ResourceARC.sol";

contract ResourceARCTest {

    ResourceARC arc;

    event TestResult(string testName, bool passed);

    constructor(address arcAddress) {
        arc = ResourceARC(arcAddress);
    }

    // ---- TRIVIAL RETAIN / RELEASE ----
    function testTrivialRetainRelease(address user) public {
        uint256 start = arc.retainedResources(user);
        arc.trivialRetainRelease(user, 10);
        uint256 end = arc.retainedResources(user);
        bool passed = (start == end); // Should be unchanged
        emit TestResult("trivialRetainRelease", passed);
    }

    // ---- NULL RETAIN / RELEASE ----
    function testSafeNullRetainRelease() public {
        try arc.safeRetainRelease(address(0), 10) {
            emit TestResult("safeNullRetainRelease", true);
        } catch {
            emit TestResult("safeNullRetainRelease", false);
        }
    }

    // ---- RETAIN MOTION TEST ----
    function testRetainMotion(address user) public {
        uint256 before = arc.retainedResources(user);
        arc.retainMotion(user, 5, 7);
        uint256 after = arc.retainedResources(user);
        bool passed = (after == before + 7); // extra added while retaining
        emit TestResult("retainMotion", passed);
    }

    // ---- UNOWNED / BRIDGE RESOURCE TEST ----
    function testBorrowReturnUnowned(address user) public {
        uint256 before = arc.unownedResources(user);
        arc.borrowUnowned(user, 12);
        arc.returnUnowned(user, 12);
        uint256 after = arc.unownedResources(user);
        bool passed = (before == after);
        emit TestResult("borrowReturnUnowned", passed);
    }

    // ---- UNKNOWN EXTERNAL CALL TEST ----
    function testUnknownExternal(address user, address ext) public {
        uint256 start = arc.retainedResources(user);
        try arc.unknownCallMotion(user, 10, ext) {
            uint256 end = arc.retainedResources(user);
            bool passed = (start == end); // retain/release balanced
            emit TestResult("unknownExternalCall", passed);
        } catch {
            emit TestResult("unknownExternalCall", false);
        }
    }

    // ---- MULTIPLE RETAIN / RELEASE TEST ----
    function testMultipleRetainRelease(address user) public {
        arc.retain(user, 10);
        arc.retain(user, 5);
        arc.release(user, 15);
        bool passed = (arc.retainedResources(user) == 0);
        emit TestResult("multipleRetainRelease", passed);
    }

    // ---- UNOWNED EDGE CASES ----
    function testUnownedEdge(address user) public {
        // Borrow unowned, perform operation, return unowned
        arc.borrowUnowned(user, 20);
        arc.borrowUnowned(user, 5);
        arc.returnUnowned(user, 25);
        bool passed = (arc.unownedResources(user) == 0);
        emit TestResult("unownedEdge", passed);
    }

}
