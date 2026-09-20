# LDAP — OpenLDAP Directory Service

OpenLDAP server with pre-seeded users for the secure chat application.

## Seeded Users

| User | DN | Password |
|---|---|---|
| juan | `cn=juan,dc=lab,dc=local` | `LabPass-@juan` |
| maria | `cn=maria,dc=lab,dc=local` | `LabPass-@maria` |
| svc-backend | `cn=svc-backend,dc=lab,dc=local` | `initial-lab-ldap-0000` |

## Stack

- OpenLDAP (slapd) on Alpine Linux
- Bootstrap via `10-people.ldif` (auto-loaded on first start)
- Persistent data stored in Docker volume `ldap-data`

## Run

```bash
docker compose up -d --build ldap
```

LDAP server listens on `http://localhost:389`.

## Notes

- To change the `svc-backend` password, edit `bootstrap/10-people.ldif` and run `docker compose down -v && docker compose up -d`
- The rotator updates `svc-backend`'s password automatically every 2 minutes
