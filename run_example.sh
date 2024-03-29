

# Need an artifactory instance to upload packages
# docker run --name artifactory-cpp -d -p 8081:8081 -p 8082:8082 docker.bintray.io/jfrog/artifactory-cpp-ce:latest
# then create a Conan local repo in Artifactory
# and add it to conan remotes with name artifactory
# conan remote add artifactory http://localhost:8081/artifactory/api/conan/<name_of_the_local_repo>
# set the user and password
# conan user -p admin -r artifactory password
# ./run_example.sh

echo "************************************"
echo "**   SET BUILD NAME AND NUMBER    **"
echo "************************************"

conan_build_info --v2 start BUILD_NAME BUILD_NUMBER

echo "************************************"
echo "**   REMOVE PACKAGES FROM CACHE   **"
echo "************************************"

conan remove "liba*" -f
conan remove "libb*" -f
conan remove "libc*" -f
conan remove "libd*" -f
conan remove "consumer*" -f

echo "*******************************************"
echo "**   REMOVE PACKAGES FROM ARTIFACTORY   ***"
echo "*******************************************"

conan remove "liba*" -f -r artifactory
conan remove "libb*" -f -r artifactory
conan remove "libc*" -f -r artifactory
conan remove "libd*" -f -r artifactory
conan remove "consumer*" -f -r artifactory

# Export dependencies
cd liba && conan export . && cd ..
cd libb && conan export . && cd ..
cd libc && conan export . && cd ..
cd libd && conan export . && cd ..
cd consumer && conan export . && cd ..

# Create lockfile
cd consumer && conan lock create conanfile.py

# some conan command that updates the lockfile with built nodes marked as modified

conan create . --lockfile=conan.lock --lockfile-out=updated.lock --build

# Upload to Artifactory

conan upload "liba" -c -r artifactory --all
conan upload "libb" -c -r artifactory --all
conan upload "libc" -c -r artifactory --all
conan upload "libd" -c -r artifactory --all
conan upload "consumer" -c -r artifactory --all

# generate build info
echo "***************************"
echo "**   CREATE BUILD INFO   **"
echo "***************************"

conan_build_info --v2 create buildinfo.json --lockfile updated.lock --user admin --password password

echo "***************************"
echo "**   PUBLISH BUILD INFO  **"
echo "***************************"

conan_build_info --v2 publish buildinfo.json --url http://localhost:8081/artifactory --user admin --password password
