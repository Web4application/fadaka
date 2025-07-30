package contracts

type Proposal struct {
    id          string
    creator     string
    description string
    aiApproved  bool
    votesYes    uint64
    votesNo     uint64
    executed    bool
}

type DAO struct {
    proposals   map[string]Proposal
    members     []string
    treasury    uint64
    aiModerator string // e.g. Web4Node agent
}

// Submit proposal
func (d *DAO) SubmitProposal(id string, description string) {
    Require(sender in d.members)
    d.proposals[id] = Proposal{
        id: id, creator: sender, description: description,
        aiApproved: false, votesYes: 0, votesNo: 0, executed: false,
    }
}

// AI moderation
func (d *DAO) FlagProposal(id string, approved bool) {
    Require(sender == d.aiModerator)
    d.proposals[id].aiApproved = approved
}

// Vote
func (d *DAO) Vote(id string, support bool) {
    Require(sender in d.members)
    Require(d.proposals[id].aiApproved == true)
    if support { d.proposals[id].votesYes += 1 }
    else { d.proposals[id].votesNo += 1 }
}

// Execute if passed
func (d *DAO) Execute(id string) {
    Require(d.proposals[id].votesYes > d.proposals[id].votesNo)
    Require(d.proposals[id].executed == false)
    d.treasury -= 100 // example disbursement
    d.proposals[id].executed = true
}

// DAO contract adjusts vote weight based on identity score
func (d *DAO) WeightedVote(id string, support bool) {
    Require(sender in d.members)
    score := IdentityRegistry.GetScore(sender)
    if support { d.proposals[id].votesYes += score }
    else { d.proposals[id].votesNo += score }
}
