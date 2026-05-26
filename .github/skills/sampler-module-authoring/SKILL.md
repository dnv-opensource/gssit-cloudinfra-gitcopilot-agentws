---
name: sampler-module-authoring
description: 'Scaffold new PowerShell module projects with Gael Colas''s Sampler module (gaelcolas/Sampler). Use when the user asks to create a PowerShell module with Sampler, run New-SampleModule, scaffold a SimpleModule / CompleteSample / dsccommunity / GCPackage / CustomModule / SimpleModule_NoBuild template, bootstrap a Sampler-based InvokeBuild pipeline, or set up a DSC Community module. Verifies the Sampler module is installed (prompts user to run Install-PSResource -Name Sampler -TrustRepository if missing) and picks the right template based on the user''s intent. Defaults to SimpleModule when no template is specified.'
---

# Sampler Module Authoring

Scaffold a new PowerShell module project using the [Sampler](https://github.com/gaelcolas/Sampler) module by Gael Colas. Sampler generates an opinionated project layout with an InvokeBuild-based pipeline (build / test / pack / publish), Pester tests, PSScriptAnalyzer config, and CI templates.

## When to Use

- User wants to create a new PowerShell module using Sampler / `New-SampleModule`.
- User asks for a Sampler-based scaffold (SimpleModule, CompleteSample, dsccommunity, GCPackage, etc.).
- User wants a module with a ready-made InvokeBuild pipeline and PowerShell Gallery publishing flow.

Do **not** use this skill for:
- Hand-rolled module scaffolding without Sampler → use `powershell-module-scaffold` instead.
- Editing an existing Sampler project's `build.yaml` / tasks (this skill is for *new* projects).

## Procedure

### 1. Verify Sampler is installed

Run this in a PowerShell terminal:

```powershell
Get-Module -ListAvailable -Name Sampler |
    Sort-Object Version -Descending |
    Select-Object -First 1 Name, Version, Path
```

If nothing is returned, **stop and prompt the user** with the exact command:

> Sampler is not installed. Run the following, then I'll continue:
>
> ```powershell
> Install-PSResource -Name 'Sampler' -TrustRepository
> ```
>
> (On systems without PSResourceGet, fall back to: `Install-Module -Name Sampler -Scope CurrentUser -Force`.)

Wait for confirmation before proceeding. Re-run the check.

### 2. Gather required inputs

`New-SampleModule` requires the parameters below. For any value the user has **not already provided in the conversation**, you MUST call the ask-questions tool (`vscode_askQuestions`) to prompt them — do not invent placeholders like `MyModule` or `Author Name`, and do not silently default the required fields.

| Parameter           | Required | How to obtain                                                                                       |
|---------------------|----------|------------------------------------------------------------------------------------------------------|
| `DestinationPath`   | Yes      | Ask the user. Suggest the current workspace folder as a default option.                              |
| `ModuleName`        | Yes      | **Ask the user** via ask-questions. No default.                                                      |
| `ModuleAuthor`      | Yes      | **Ask the user** via ask-questions. Suggest `git config user.name` output as a recommended option.   |
| `ModuleDescription` | Yes      | **Ask the user** via ask-questions. No default.                                                      |
| `ModuleType`        | No       | Template to use. **Default: `SimpleModule`** (see Step 3). Confirm via ask-questions if uncertain.   |
| `ModuleVersion`     | No       | Defaults to `0.0.1`. Only ask if the user mentions versioning.                                       |
| `LicenseType`       | No       | E.g. `MIT`, `Apache`. Only ask if the user mentions licensing.                                       |
| `SourceDirectory`   | No       | Defaults to `source`. Don't ask unless raised.                                                       |
| `CustomRepo`        | No       | Don't ask unless the user mentions a private/internal PSResource repository.                         |

**Batch the questions into a single `vscode_askQuestions` call** with one entry per missing required value (`ModuleName`, `ModuleAuthor`, `ModuleDescription`, `DestinationPath`, and `ModuleType` if not obvious). Use the parameter name as the question `header` so answers map cleanly back. Leave `allowFreeformInput` enabled for free-text fields like name/description; provide template options for `ModuleType` (see Step 3).

### 3. Choose a template (`ModuleType`)

**Default is `SimpleModule`.** Only switch templates if the user describes a need that clearly maps to another option. Use this decision table:

| User signal                                                                 | `ModuleType`          |
|------------------------------------------------------------------------------|-----------------------|
| "simple module", "minimal", "just scaffolding", no specifics                | `SimpleModule` (default) |
| "no build pipeline", "no InvokeBuild", "just the module files"              | `SimpleModule_NoBuild` |
| "complete example", "show me everything", "full sample with examples"       | `CompleteSample`      |
| "DSC resource module", "class-based DSC", "MOF DSC", "DSC Community"        | `dsccommunity`        |
| "Azure Policy Guest Configuration", "Guest Config package", "GCPackage"     | `GCPackage`           |
| "I want to pick features interactively", "custom", "prompt me for options"  | `CustomModule`        |

When in doubt, confirm the template with the user before running the command.

### 4. Run `New-SampleModule`

Create `DestinationPath` first if it doesn't exist. Then splat the parameters:

```powershell
$DestinationPath = 'C:\source'
if (-not (Test-Path -LiteralPath $DestinationPath)) {
    New-Item -Path $DestinationPath -ItemType Directory | Out-Null
}

$NewSampleModuleParameters = @{
    DestinationPath   = $DestinationPath
    ModuleType        = 'SimpleModule'      # change per Step 3
    ModuleName        = 'MyModule'
    ModuleAuthor      = 'Author Name'
    ModuleDescription = 'Short description.'
}

Import-Module -Name Sampler
New-SampleModule @NewSampleModuleParameters
```

For the `CustomModule` template, Sampler will prompt interactively for `-Features`; let it run interactively rather than pre-supplying values.

### 5. Verify and report next steps

After scaffolding, confirm the project was created:

```powershell
Get-ChildItem -Path (Join-Path $DestinationPath $ModuleName) -Force
```

Then tell the user the standard Sampler next steps:

1. `cd <DestinationPath>\<ModuleName>`
2. `./build.ps1 -ResolveDependency` — bootstraps required modules into `./RequiredModules`.
3. `./build.ps1 -Tasks build` — compiles the module into `./output/<ModuleName>/<version>/`.
4. `./build.ps1 -Tasks test` — runs Pester tests and PSScriptAnalyzer (HQRM) checks.
5. Edit `build.yaml` to configure pipeline behavior, version strategy, and publish targets.

## References

- Sampler repo: <https://github.com/gaelcolas/Sampler>
- Sampler wiki (Getting Started, all templates, task reference): <https://github.com/gaelcolas/Sampler/wiki>
- InvokeBuild (underlying task engine): <https://github.com/nightroman/Invoke-Build>

## Anti-patterns

- Do **not** silently install Sampler — always prompt the user first with the `Install-PSResource` command.
- Do **not** invent template names. Only the six in Step 3 are valid `ModuleType` values.
- Do **not** edit the generated `build.yaml`, `RequiredModules.psd1`, or task files as part of scaffolding — those are user-tunable after creation.
- Do **not** use this skill to add Sampler to an *existing* hand-rolled module; Sampler expects to own the project layout.
