# L4 — Facilitator Notes (Custom Agent Config & MCP Integration — Track A)

**Slot:** Day 2 · 16:40–17:05 · 25 min core (+ optional stretch)
**Backbone:** Same as the M12 InfraOps + MCPServerPS demo, shrunk to one attendee-built cmdlet that returns **live Windows service status** for a small allow-list.

> Credit on any slide/handout that names the module:
> **MCPServerPS** by **Dongbo Wang (daxian-dbw)** — https://github.com/daxian-dbw/MCPServerPS

---

## The one thing they should feel

Their **hand-built cmdlet shows up as a callable tool in their own agent** — ideally by minute 18 — and it returns **real data** (the status of the Print Spooler service from their own machine).
The closing beat: ask for a `-Name` outside the `ValidateSet`, watch the schema reject it.
Land the line: **"The LLM decides *when* to call. You decide *what* is callable."**

---

## Timeline (keep it moving)

| Min | Step | What you do as facilitator |
| --- | --- | --- |
| 0–5 | Setup validation | Everyone runs `Get-Module -ListAvailable MCPServerPS` and confirms the `starter\WorkshopDemo` folder. Anyone missing the module runs the install one-liner. |
| 5–13 | Build the cmdlet | They Copilot-fill `Get-WorkshopDemoServiceStatus` (comment help + `ValidateSet` allow-list, default `'Spooler'`, returns Get-Service output as a small object). Float the room; the import-and-call test is the checkpoint. |
| 13–17 | Wire MCPServerPS | Copy `mcp.json` to `.vscode\mcp.json`, fix the absolute path. |
| 17–20 | Agent config | Create `.github\agents\workshop-demo-agent.agent.md`, scope the `tools:` list to `WorkshopDemo/Get_WorkshopDemoServiceStatus`. |
| 20–22 | Reload + invoke | Reload window, `@Workshop Demo Agent`, watch the tool fire. **Wow moment** — they get a live status back, not a synthetic string. |
| 22–25 | Break the boundary | Ask for `MSSQLSERVER` (or any service not in the allow-list) → schema rejection → land the headline line. |

If you are tight on time, **cut the stretch entirely** — the core flow already delivers the wow moment and the boundary lesson. The stretch (expand the allow-list) is genuinely 5 minutes and a nice victory lap for fast attendees.

---

## Common snags

| Symptom | Fix |
| --- | --- |
| Tools don't appear after editing `mcp.json` | Reload the VS Code window (Command Palette → "Developer: Reload Window") or restart the MCP server from the MCP view. The server process caches the module at start. |
| `MCPServerPS\Start-MyMCP` not found | `Install-PSResource -Name MCPServerPS -Repository PSGallery` (or `Install-Module MCPServerPS`). Confirm with `Get-Command Start-MyMCP`. |
| Module imports but no tools (stderr: `Start-MyMCP: The module 'WorkshopDemo' doesn't expose any functions.`) | The cmdlet body got written but the manifest wasn't updated. Both `FunctionsToExport` in the `.psd1` and `Export-ModuleMember -Function ...` in the `.psm1` must name the function. After fixing either file, click **Restart** on the MCP server (the manifest is read on start). |
| Attendee is stuck on Step 2 with <5 min left in the slot | **Time-pressure fallback only:** change the `-Module` path in their `.vscode/mcp.json` from `starter\WorkshopDemo\WorkshopDemo.psd1` to `solution\WorkshopDemo\WorkshopDemo.psd1` so they at least see Steps 4–6 land. Default expectation is that attendees point at their **own** starter path — that is the point of the lab. Use the solution path as a rescue, never as the recommended path. |
| Agent can't find the tool | Tool name pattern is `{ServerName}/{Cmdlet_With_Underscores}` — e.g. `WorkshopDemo/Get_WorkshopDemoServiceStatus`. Matching is case-insensitive in practice (`workshopdemo/*` also resolves), but the explicit form is the safer default. |
| `Get-Service : Cannot find any service with service name 'Spooler'` | Rare; the attendee's machine has print spooler disabled at the OS level. Either start the service (`Start-Service Spooler` as admin) or have them swap the default to `wuauserv` (always present). |
| Path with spaces in `-Module` | Keep the single quotes inside the `-Command` string in `mcp.json`. |
| `Start-MyMCP` errors on launch | Run it by hand to surface the error: `pwsh -NoProfile -Command "MCPServerPS\Start-MyMCP -Module '<path>\WorkshopDemo\WorkshopDemo.psd1'"` |

---

## Solution reference

- `solution\WorkshopDemo\` — working module (one cmdlet: `Get-WorkshopDemoServiceStatus`). Verified: imports, the cmdlet returns a live Get-Service object for each of `Spooler`, `wuauserv`, `BITS`, and the `ValidateSet` rejects any service name not in the allow-list.
- `solution\.vscode\mcp.json` — canonical wiring (adjust the absolute path to the attendee's clone).
- `solution\.github\agents\workshop-demo-agent.agent.md` — scoped agent; `tools:` lists only the one WorkshopDemo tool, and the persona explicitly forbids start/stop/modify operations.

Quick self-test the solution (no MCP client needed):

```powershell
Import-Module .\solution\WorkshopDemo\WorkshopDemo.psd1 -Force
Get-WorkshopDemoServiceStatus                       # defaults to Spooler
Get-WorkshopDemoServiceStatus -Name wuauserv
Get-WorkshopDemoServiceStatus -Name MSSQLSERVER     # expect a ValidateSet rejection
```

---

## Safety to reinforce out loud

- **The cmdlet only READS service state.** It calls `Get-Service`, never `Start-Service`, `Stop-Service`, `Set-Service`, or anything mutating. The agent's persona reinforces this; the parameter block constrains *which* service can be queried; the cmdlet body constrains *what* can be done with it. **Two layers.**
- **`ValidateSet` is a teaching device, not production security.** Say it explicitly: a real deployment needs an **explicit ALLOW-list** *plus* identity, network, and audit controls on the targets. The schema keeps the *callable surface* small; it is not a substitute for real guardrails. The cmdlet running on the attendee's own machine with their own user token is the real boundary here — that token does not exist on a production server.
- **Don't expand the allow-list during the live session** to include sensitive services (auth, SQL, AD). The stretch deliberately suggests adding `Themes` or `BITS` — boring services that demonstrate the schema without raising the stakes.

---

## Theory follow-up

- **M12-A** — Azure + Terraform MCP (Haflidi): MCP intro and the "architect's tools" framing.
- **M12-B** — PowerShell + DrawIO MCP (Jan Egil): the InfraOps + MCPServerPS demo this lab is modeled on,
  including the `BareBoneServer.ps1` reveal (which is a *teaching moment*, not a lab task — attendees do
  **not** re-implement the JSON-RPC loop; MCPServerPS does that).
