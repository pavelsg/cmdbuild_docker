### Deploy by docker run
**CMDbuild with demo database**  
```bash
docker run --name cmdbuild_db -p 5432:5432 -d pavelsg/cmdbuild:db-3.0
docker run --name cmdbuild_app --link cmdbuild_db  -p 8090:8080 -d pavelsg/cmdbuild:app-3.1.1
```

**CMDbuild Ready2use 2.0**  
```bash  
docker run --name cmdbuild_db -p 5432:5432 -d pavelsg/cmdbuild:db-3.0
docker run --name cmdbuild_app --restart unless-stopped -e CMDBUILD_DUMP="ready2use_demo.dump.xz" --link cmdbuild_db  -p 8090:8080 -d pavelsg/cmdbuild:r2u-2.0-3.1.1
```  

#### CMDBUILD_DUMP values
* demo.dump.xz
* empty.dump.xz
* openmaint_demo.dump.xz
* openmaint_empty.dump.xz
* openmaint_empty_gis.dump.xz
* ready2use.dump.xz
* ready2use_demo.dump.xz
* ready2use_empty.dump.xz

