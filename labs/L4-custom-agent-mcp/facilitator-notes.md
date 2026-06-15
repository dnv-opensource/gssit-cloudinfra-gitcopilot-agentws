# L4 Facilitator Notes — Shared

Coaching that applies to **both tracks**. Track-specific notes live in:
- [track-a-powershell-mcp/solution/facilitator-notes.md](./track-a-powershell-mcp/solution/facilitator-notes.md)
- [track-b-azure-terraform/facilitator-notes.md](./track-b-azure-terraform/facilitator-notes.md)

---

## Opening the slot (first 90 seconds)

L4 is **two parallel tracks**, not sequential. Show the [parent README picker table](./README.md#-pick-your-track) on the projector for 30 seconds and let attendees self-select before they touch the keyboard. The picker exists to prevent the worst failure mode: attendees who chose the wrong track 10 minutes in and feel stuck.

**Heuristics for choosing:**
- **Default → Track A.** Fewer moving parts, no cloud auth, no destroy step, matches M12-B.
- **Track B is the right choice when:**
  - The attendee said "I came for Azure" or "we're standardising on Terraform" during introductions
  - They got the M12-A cloud-MCP segment energised
  - They already have `az login` working and a sandbox sub
- **Push back on Track B if** the attendee never used Terraform before AND doesn't have `az` ready. Track A delivers the same conceptual payoff (you-decide-what-is-callable) without auth risk.

Both tracks land at the same place: *the agent calls something you built.* Encourage attendees that this is a real choice, not a difficulty ladder.

---

## Shared talking points (after both tracks finish)

Even though attendees did different tracks, the debrief is the same. Ask the room:

1. **Where did *you* set the boundary?** (Track A: `ValidateSet`. Track B: the Terraform resource block + Azure RBAC on the sandbox sub.)
2. **What did the agent *not* do that surprised you?** (Track A: refused the off-set value. Track B: needed an explicit RG name; couldn't guess sub context.)
3. **What's the smallest thing you'd ship at DNV on Monday?** (Track A: wrap an existing internal cmdlet. Track B: wire Azure MCP into your existing landing-zone repo for read-only queries first.)

The bridge to L5: *both tracks were one tool. L5 stitches multiple tools into a workflow with an agent persona.*

---

## When attendees switch tracks mid-slot

Sometimes a Track B attendee will hit an auth wall and want to switch. Sometimes a Track A attendee will finish at minute 15 and ask for more.

- **Switching B → A at < 10 min in:** Fine. They have time. Point them at Track A's setup validation.
- **Switching B → A after 10 min in:** Don't. Have them join a neighbour on Track B and finish as a pair.
- **Track A finishers with time left:** Offer the Track A stretch (second cmdlet with `ValidateRange`). If they've done that too, point them at Track B Step 4 onwards as a *read-only* exploration (the agent calls Azure MCP against the *facilitator's* RG — no deploy, no destroy).

---

## Don't let cleanup slip (Track B)

The single most important facilitator job for Track B is **make sure every attendee runs `terraform destroy`** before the slot ends. Shared sandbox sub means orphaned RGs become tomorrow's cost report.

Build in a 2-minute "cleanup check-in" at the 23-minute mark:

> "If you're on Track B, run `terraform destroy` now. Show me a green ✅ in chat when your RG is gone."

Track each attendee in the chat. Anyone who didn't ✅ before L5 starts gets a quick desk-visit during the break.

---

## Common shared issues

| Issue | Cause | Fix |
|-------|-------|-----|
| MCP servers don't show up after reload | `.vscode/mcp.json` is in the wrong folder, or VS Code wasn't reloaded | Confirm file location matches the track's README; **Developer: Reload Window** |
| Agent uses generic knowledge instead of the MCP tool | Agent persona's `tools:` list doesn't include the tool (or wildcard) covering it | Tool names are `{ServerName}/{Tool_Name}`; matching is case-insensitive and wildcards (e.g. `workshopdemo/*`) work, but the explicit `WorkshopDemo/Get_WorkshopDemoServiceStatus` form is the recommended default |
| Plan Mode produced a perfect plan but Agent Mode ignored it | Attendee clicked "Continue in Agents Window" instead of "Start Implementation" | Re-run, click **Start Implementation** |
| Multiple terminal-approval prompts mid-run | Normal Agent Mode behaviour during self-correction loop | Click **Allow** each time; it's the same loop the L3 lab demonstrated |
