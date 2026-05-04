# Agent Guide

## Rules
- Be concise.
- Do only what is asked.
- Prefer safe, non-destructive actions.

## Folder Layout
Current stack format:
`<resource-group>/<env>/<region>/<optional project>/<resource>`

Examples:
`cc/dev/eastus2/national/ai-foundry`
`cc/g/tenant/verified_domains`

Envs:
- `g` (global)
- `dev`

Regions:
- `tenant`
- `eastus2`
- others as needed

## Legacy Layout (Deprecated)
`chechia/<resource-group>` is legacy layout without clear layering.
Mark as deprecated in new changes, but do not remove existing stacks.
