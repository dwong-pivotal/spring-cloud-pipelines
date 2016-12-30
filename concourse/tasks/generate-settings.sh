#!/bin/bash

mkdir -p ${HOME}/.m2/
mkdir -p ${HOME}/.gradle/

ROOT_IN_M2_RESOURCE="${ROOT_FOLDER}/${M2_REPO}/root"
NEW_LOCAL_REPO="${ROOT_IN_M2_RESOURCE}/.m2/repository/"

echo "Writing settings xml to [${HOME}/.m2/settings.xml]"
echo "New local repository location ${NEW_LOCAL_REPO}"

set +x
cat > ${HOME}/.m2/settings.xml <<EOF

<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
      xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
      xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0
                          https://maven.apache.org/xsd/settings-1.0.0.xsd">
      <servers>
        <server>
          <id>${M2_SETTINGS_REPO_ID}</id>
          <username>${M2_SETTINGS_REPO_USERNAME}</username>
          <password>${M2_SETTINGS_REPO_PASSWORD}</password>
        </server>
      </servers>
      <localRepository>${NEW_LOCAL_REPO}</localRepository>
</settings>

EOF
set -x

echo "Settings xml written"

export GRADLE_USER_HOME="${ROOT_IN_M2_RESOURCE}/.gradle"

echo "Writing gradle.properties to [${GRADLE_USER_HOME}/gradle.properties]"

set +x
cat > ${GRADLE_USER_HOME}/gradle.properties <<EOF

repoUsername=${M2_SETTINGS_REPO_USERNAME}
repoPassword=${M2_SETTINGS_REPO_PASSWORD}

EOF
set -x

echo "gradle.properties written"
