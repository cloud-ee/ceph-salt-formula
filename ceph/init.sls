{% from "ceph/map.jinja" import ceph, ceph_config with context -%}

{{ ceph.name }}:
  pkg.installed

/etc/ceph/ceph.conf:
  file.managed:
    - template: jinja
    - source: salt://ceph/files/ceph.conf
    - user: root
    - group: root
    - mode: 0644

{% for keyring in salt['pillar.get']('ceph:keyrings', []) %}
/etc/ceph/ceph.client.{{ keyring['name'] }}.keyring:
  file.managed:
    - template: jinja
    - source: salt://ceph/files/keyring.jinja
    - user: root
    - group: root
    - mode: 0644
    - defaults:
      keyring: {{ keyring }}
{% endfor %}

