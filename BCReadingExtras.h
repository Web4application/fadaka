//===--- FadakaBCExtrasFull.h - Bitcode + Blockchain Cursor Helpers -*- C++20 -*-===//
//
// Part of the Fadaka Blockchain Project
// (c) 2025 Seriki Yakub / Fadaka Team
//
// License: Apache 2.0
//
//===----------------------------------------------------------------------===//

#ifndef FADAKA_SERIALIZATION_BCFULLHELPERS_H
#define FADAKA_SERIALIZATION_BCFULLHELPERS_H

#include "llvm/Bitstream/BitstreamReader.h"
#include <optional>
#include <cstdint>
#include <vector>

namespace fadaka {
namespace serialization {

/// RAII helper for blockchain cursors or bitcode readers.
/// Saves/restores cursor position safely for Fadaka ledger reading.
class BCOffsetRAII {
    std::optional<llvm::BitstreamCursor*> Cursor;
    uint64_t Offset;

public:
    explicit BCOffsetRAII(llvm::BitstreamCursor &cursor)
        : Cursor(&cursor), Offset(cursor.GetCurrentBitNo()) {}

    void reset() { if (Cursor) Offset = (*Cursor)->GetCurrentBitNo(); }
    void cancel() { Cursor.reset(); }
    [[nodiscard]] uint64_t getOffset() const { return Offset; }

    ~BCOffsetRAII() {
        if (Cursor) {
            cantFail((*Cursor)->JumpToBit(Offset),
                     "Fadaka BCOffsetRAII must restore cursor position");
        }
    }
};

//==============================================================================
// Transaction Cursor - lightweight wrapper to scan transactions in a block
//==============================================================================

class TxCursor {
    llvm::BitstreamCursor &Cursor;

public:
    explicit TxCursor(llvm::BitstreamCursor &cursor) : Cursor(cursor) {}

    /// Move to next transaction, return false if none left
    bool nextTransaction() {
        if (Cursor.AtEndOfStream())
            return false;
        // Custom parsing logic here...
        Cursor.advance(); // placeholder
        return true;
    }

    /// Peek current transaction ID
    uint64_t peekTxID() {
        // Implement actual bitstream transaction ID extraction
        return Cursor.GetCurrentBitNo(); // placeholder
    }
};

//==============================================================================
// Ledger Snapshot - save and restore ledger state
//==============================================================================

struct LedgerSnapshot {
    uint64_t cursorBitOffset;
    std::vector<uint8_t> blockHash;

    explicit LedgerSnapshot(llvm::BitstreamCursor &cursor)
        : cursorBitOffset(cursor.GetCurrentBitNo()) {}

    void restore(llvm::BitstreamCursor &cursor) {
        cantFail(cursor.JumpToBit(cursorBitOffset),
                 "LedgerSnapshot restore failed");
    }
};

//==============================================================================
// Flag alias (for Fadaka block reading)
//==============================================================================

static constexpr auto AF_DontPopBlockAtEnd =
    llvm::BitstreamCursor::AF_DontPopBlockAtEnd;

} // namespace serialization
} // namespace fadaka

#endif // FADAKA_SERIALIZATION_BCFULLHELPERS_H

