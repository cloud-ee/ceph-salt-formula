{% from "ceph/map.jinja" import ceph with context %}

{% set oscodename = salt['config.get']('oscodename') -%}

ceph_repo:
  pkgrepo.managed:
    - humanname: ceph repository
    - name: deb http://ceph.com/debian-{{ ceph.version }}/ {{ oscodename }} main
    - file: /etc/apt/sources.list.d/ceph.list
    - key_url: https://raw.github.com/ceph/ceph/master/keys/release.asc
    - require_in: 
      - pkg: {{ ceph.pkg }}

