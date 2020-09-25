#!/bin/bash
echo "sleeping for 10 seconds"
sleep 10

mongo <<EOF
  var cfg = {
    "_id": "rs0",
    "version": 1,
    "members": [
      {
        "_id": 0,
        "host": "192.168.1.15:27017",
        "priority": 2
      },
      {
        "_id": 1,
        "host": "192.168.1.16:27017",
        "priority": 1
      }
    ]
  };
  rs.initiate(cfg);
EOF

sleep 10

mongo <<EOF
   use admin;
   admin = db.getSiblingDB("admin");
   admin.createUser(
     {
	user: "admin",
        pwd: "24101991",
        roles: [ { role: "root", db: "admin" } ]
     });
     db.getSiblingDB("admin").auth("admin", "password");
     rs.status();
EOF
