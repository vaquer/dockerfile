### CKAN-POSTGRES
Dockerizacion del serivicio de base de datos que utiliza CKAN.

# Deployment Kubernetes

### Postgres-CKAN Transaccional
Para levantar el servicio de base de datos CKAN transaccional se debe correr el siguiente comando:

```sh
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
 name: ckan-postgres
spec:
 replicas: 1
 template:
   metadata:
     labels:
       db: postgres
       app: ckan-postgres
       tier: backend
   spec:
     containers:
       - name: ckan-postgres
         image: mxabierto/ckan-postgres
         ports:
           - containerPort: 5432
         env:
           - name: POSTGRES_DB
             value: "ckan_default"
           - name: USER_DATASTORE
             value: "ckan_default"
           - name: USER_DATASTORE_PWD
           	 value: "pwd_user_datastore_write"
       	   - name: USER_DATASTORE_READ
             value: "user_read_datastore"
           - name: DATABASE_DATASTORE
             value: "datastore_default"
           - name: POSTGRES_USER
             value: "ckan_default"
           - name: POSTGRES_PASSWORD
             value: "xxxxxxxxxxxxxx"
         volumeMounts:
           - mountPath: "/var/lib/postgresql/data"
             name: postgres-data
     volumes:
       - name: postgres-data
         hostPath:
path: "/path/in/host"
```

### Postgres-CKAN Datastore
Para levantar el servicio de base de datos CKAN Datastore se debe correr el siguiente comando:

```sh
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
 name: ckan-postgres-datstore
spec:
 replicas: 1
 template:
   metadata:
     labels:
       db: postgres
       app: ckan-postgres-datstore
       tier: backend
   spec:
     containers:
       - name: ckan-postgres
         image: mxabierto/ckan-postgres
         ports:
           - containerPort: 5432
         env:
           - name: POSTGRES_DB
             value: "ckan_default"
           - name: USER_DATASTORE
             value: "ckan_default"
           - name: USER_DATASTORE_PWD
           	 value: "pwd_user_datastore_write"
       	   - name: USER_DATASTORE_READ
             value: "user_read_datastore"
           - name: DATABASE_DATASTORE
             value: "datastore_default"
           - name: POSTGRES_USER
             value: "ckan_default"
           - name: POSTGRES_PASSWORD
             value: "xxxxxxxxxxxxxx"
         volumeMounts:
           - mountPath: "/var/lib/postgresql/data"
             name: postgres-data
     volumes:
       - name: postgres-datastore-data
         hostPath:
path: "/path/in/host"
```