package algorithms

import "testing"

func TestReverseString(t *testing.T) {

	input := "Expected"
	expected := "detcepxE"
	actual := Reverse(input)

	if actual != expected {
		t.Error("Expected " + expected + "; Actual " + actual)
	}
}
