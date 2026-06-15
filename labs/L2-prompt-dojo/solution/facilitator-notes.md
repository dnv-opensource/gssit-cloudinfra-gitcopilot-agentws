# L2 — Facilitator Notes

Use this only for the Day 2 standard path or if you want a tighter debrief after the bonus run.

## What to listen for

- Did attendees add the actual file snippet or variable schema?
- Did they name constraints instead of saying "make it valid"?
- Did they specify cloud, version, defaults, or outputs?
- Did they describe the return contract and error logging pattern?

## Fast debrief prompts

- What did you add to the prompt that the vague version was missing?
- Which detail changed Copilot's answer the most?
- What did Copilot still guess, even after you improved the prompt?
- Which context was essential versus just nice to have?

## Common patterns to highlight

- **Round 1:** The strongest prompts include the variable block and the full constraint list.
- **Round 2:** The strongest prompts remove ambiguity about Azure versus another cloud and name the module interface.
- **Round 3:** The strongest prompts include the function code, specific exception types, and the success/failure contract.

## Intervention lines if someone is stuck

- What would a human need to do this correctly on the first try?
- What is the one thing Copilot is most likely to guess wrong here?
- If the answer needs to fit a house style, what is that style?
- If you want a safer answer, what default or guardrail should you state?
