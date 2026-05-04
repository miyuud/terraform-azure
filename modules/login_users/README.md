# login_users

Assign tenant-scope Azure RBAC roles for users.

## Inputs
- `role_assignment_scope`: role assignment scope (default `/`, tenant root scope)
- `resource_group_name`: deprecated compatibility input (unused)
- `console_login_users`: users to assign

User entry fields:
- `user_principal_name` (required)
- `role_definition_name` (optional, default `Reader`)
- `principal_object_id` (optional, bypass user lookup)
- `invite_external_user` (optional)
- `invitation_redirect_url` (optional)

## Behavior
- If user domain is verified in tenant, treat as internal user lookup.
- If user domain is not verified (for example `gmail.com`), invite as guest by default.
- `invite_external_user` can override auto behavior.
