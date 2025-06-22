package run

import (
	"context"
	"testing"

	"gitea.com/gitea/act_runner/internal/pkg/labels"
	"github.com/stretchr/testify/assert"
)

func TestLabelUpdate(t *testing.T) {
	ctx := context.Background()
	ls := labels.Labels{}

	initialLabel, err := labels.Parse("testlabel:docker://alpine")
	assert.NoError(t, err)
	ls = append(ls, initialLabel)

	newLs := labels.Labels{}

	newLabel, err := labels.Parse("next label:host")
	assert.NoError(t, err)
	newLs = append(newLs, initialLabel)
	newLs = append(newLs, newLabel)

	runner := Runner{
		labels: ls,
	}

	assert.Contains(t, runner.labels, initialLabel)
	assert.NotContains(t, runner.labels, newLabel)

	runner.Update(ctx, newLs)

	assert.Contains(t, runner.labels, initialLabel)
	assert.Contains(t, runner.labels, newLabel)
}
