# conan-build-info-example


```

     liba
      /\
   libb libc
      \/
     libd
      |
   consumer
```

You need an artifactory instance running to upload packages

```
docker run --name artifactory-cpp -d -p 8081:8081 -p 8082:8082 docker.bintray.io/jfrog/artifactory-cpp-ce:latest
```

Then create a Conan local repo in Artifactory and add it to conan remotes with name artifactory

```
conan remote add artifactory http://localhost:8081/artifactory/api/conan/<name_of_the_local_repo>

```

Set the user and password for the repo

```
conan user -p admin -r artifactory password
```

Run the example: will remove the packages from cache and artifactory if already created. Will create a build info using a lockfile and the publishing it to Artifactory.

```
./run_example.sh
```
