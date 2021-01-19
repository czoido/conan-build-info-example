# conan-build-info-example


```

     liba
      /\
   libb libc
      \/
     libd
      |
   consumer
   
# Need an artifactory instance to upload packages
# docker run --name artifactory-cpp -d -p 8081:8081 -p 8082:8082 docker.bintray.io/jfrog/artifactory-cpp-ce:latest

conan remove "liba" -f
conan remove "libb" -f
conan remove "libc" -f
conan remove "libd" -f
conan remove "consumer" -f

# Export dependencies
cd liba && conan export . && cd ..
cd libb && conan export . && cd ..
cd libc && conan export . && cd ..
cd libd && conan export . && cd ..
cd consumer && conan export . && cd ..

# Create lockfile
cd consumer && conan lock create conanfile.py
conan install . --lockfile=conan.lock --lockfile-out=updated.lock --build

# Upload to Artifactory

conan upload "liba" -c -r artifactory
conan upload "libb" -c -r artifactory
conan upload "libc" -c -r artifactory
conan upload "libd" -c -r artifactory
conan upload "consumer" -c -r artifactory

# generate build info
conan_build_info --v2 create buildinfo.json --lockfile updated.lock --user admin --password password
```
