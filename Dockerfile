FROM osixia/openldap:1.5.0

# Bootstrap LDIFs are auto-applied by the image on the first boot.
COPY bootstrap/10-people.ldif /container/service/slapd/assets/config/bootstrap/ldif/custom/10-people.ldif

# Replace the lab password placeholders with generated SSHA hashes so the
# directory never stores plain-text passwords. slappasswd ships with slapd.
RUN hash_juan="$(slappasswd -s 'LabPass-@juan' -h '{SSHA}')" \
    && hash_maria="$(slappasswd -s 'LabPass-@maria' -h '{SSHA}')" \
    && hash_svc="$(slappasswd -s 'initial-lab-ldap-0000' -h '{SSHA}')" \
    && sed -i \
        -e "s|__JUAN_PW__|$hash_juan|" \
        -e "s|__MARIA_PW__|$hash_maria|" \
        -e "s|__SVC_PW__|$hash_svc|" \
        /container/service/slapd/assets/config/bootstrap/ldif/custom/10-people.ldif