db.setProfilingLevel(0);
db.system.profile.drop();
db.createCollection('system.profile', { capped: true, size: 4000000 });
db.system.profile.stats();
db.setProfilingLevel(2);
