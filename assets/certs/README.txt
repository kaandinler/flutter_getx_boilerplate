Place your backend server certificate (PEM or DER) files here for TLS pinning.

Recommendations
- Prefer SPKI pinning; for PEM pinning, be ready to rotate pins when cert changes.
- Include at least two pins (primary + backup) to avoid lockouts during rotation.

Config
- Enable by setting in your env file (e.g., assets/env/.env.prod):
  TLS_PINNING_ENABLED=true
  TLS_PIN_ASSETS=assets/certs/api_prod.pem,assets/certs/api_backup.pem

Notes
- Do NOT store secrets here. Certificates are public material used for pinning, not private keys.

