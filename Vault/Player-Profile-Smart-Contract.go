package contracts

type PlayerProfile struct {
    playerID     string
    level        uint8
    xp           uint64
    inventory    []string // List of item IDs
    questStatus  map[string]string // questID → status
}

// Initialize a new profile
func (p *PlayerProfile) Init(playerID string) {
    p.playerID = playerID
    p.level = 1
    p.xp = 0
    p.inventory = []string{}
    p.questStatus = make(map[string]string)
}

// Gain experience
func (p *PlayerProfile) AddXP(xpEarned uint64) {
    p.xp += xpEarned
    if p.xp > uint64(p.level)*100 {
        p.level += 1
        p.xp = 0
    }
}

// Add item to inventory
func (p *PlayerProfile) AddItem(itemID string) {
    p.inventory = append(p.inventory, itemID)
}

// Update quest status
func (p *PlayerProfile) UpdateQuest(questID string, status string) {
    p.questStatus[questID] = status
}
