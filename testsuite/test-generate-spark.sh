#!/bin/bash

source test-generate-common.sh
source test-common.sh
source test-config.sh
source ../magpie/lib/magpie-lib-helper
source ../magpie/lib/magpie-lib-version-helper

__CheckForSparkNoLocalDirMinimum() {
    local projectversion=$1

    # Sets magpie_sparkmajorminorversion
    Magpie_get_spark_major_minor_version ${projectversion}

    # Returns 0 for ==, 1 for $1 > $2, 2 for $1 < $2
    Magpie_vercomp ${magpie_sparkmajorminorversion} "1.2"
    if [ $? == "2" ]
    then
        #echo "Cannot generate Spark tests for ${projectversion}, No Local Dir not supported in that version"
        return 1
    fi

    return 0
}

__CheckForSparkYarnMinimum() {
    local testfunction=$1
    local projectversion=$2

    # Sets magpie_sparkmajorminorversion
    Magpie_get_spark_major_minor_version ${projectversion}

    if echo ${testfunction} | grep -q "requireyarn"
    then
        # Returns 0 for ==, 1 for $1 > $2, 2 for $1 < $2
        Magpie_vercomp ${magpie_sparkmajorminorversion} "1.2"
        if [ $? == "2" ]
        then
            #echo "Cannot generate Spark ${projectversion} tests, it depends on Yarn, Spark minimum needed for tests is 1.2.0"
            continue
        fi
    fi
}

__GenerateSparkStandardTests_BasicTests() {
    local sparkversion=$1
    local javaversion=$2

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-${sparkversion}-run-sparkpi

    if __CheckForSparkNoLocalDirMinimum ${sparkversion}
    then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-${sparkversion}-run-sparkpi-no-local-dir
    fi
        
    sed -i -e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="'"${sparkversion}"'"/' magpie.${submissiontype}-spark-${sparkversion}*
    
    JavaCommonSubstitution ${javaversion} `ls magpie.${submissiontype}-spark-${sparkversion}*`
}

__GenerateSparkStandardTests_WordCount() {
    local sparkversion=$1
    local hadoopversion=$2
    local javaversion=$3

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}-hdfsoverlustre-run-sparkwordcount-copy-in
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}-hdfsovernetworkfs-run-sparkwordcount-copy-in
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-with-rawnetworkfs-spark-${sparkversion}-run-sparkwordcount
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-with-rawnetworkfs-spark-${sparkversion}-run-pythonsparkwordcount

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}-hdfsoverlustre-localscratch-single-path-run-sparkwordcount-copy-in
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}-hdfsovernetworkfs-localscratch-single-path-run-sparkwordcount-copy-in
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-with-rawnetworkfs-spark-${sparkversion}-localscratch-single-path-run-sparkwordcount

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}-hdfsoverlustre-localscratch-multiple-paths-run-sparkwordcount-copy-in
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}-hdfsovernetworkfs-localscratch-multiple-paths-run-sparkwordcount-copy-in
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-with-rawnetworkfs-spark-${sparkversion}-localscratch-multiple-paths-run-sparkwordcount

    if __CheckForSparkNoLocalDirMinimum ${sparkversion}
    then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}-hdfsoverlustre-run-sparkwordcount-copy-in-no-local-dir
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}-hdfsovernetworkfs-run-sparkwordcount-copy-in-no-local-dir
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-with-rawnetworkfs-spark-${sparkversion}-run-sparkwordcount-no-local-dir
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-with-rawnetworkfs-spark-${sparkversion}-run-pythonsparkwordcount-no-local-dir

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}-hdfsoverlustre-localscratch-single-path-run-sparkwordcount-copy-in-no-local-dir
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}-hdfsovernetworkfs-localscratch-single-path-run-sparkwordcount-copy-in-no-local-dir
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-with-rawnetworkfs-spark-${sparkversion}-localscratch-single-path-run-sparkwordcount-no-local-dir

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}-hdfsoverlustre-localscratch-multiple-paths-run-sparkwordcount-copy-in-no-local-dir
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}-hdfsovernetworkfs-localscratch-multiple-paths-run-sparkwordcount-copy-in-no-local-dir
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-with-rawnetworkfs-spark-${sparkversion}-localscratch-multiple-paths-run-sparkwordcount-no-local-dir
    fi

    sed -i \
        -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' \
        magpie.${submissiontype}-spark-with-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}*

    sed -i \
        -e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="'"${sparkversion}"'"/' \
        magpie.${submissiontype}-spark-with-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}* \
        magpie.${submissiontype}-spark-with-rawnetworkfs-spark-${sparkversion}*

    sed -i \
        -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
        magpie.${submissiontype}-spark-with-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}-hdfsoverlustre*

    sed -i \
        -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
        magpie.${submissiontype}-spark-with-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}-hdfsovernetworkfs*

    sed -i \
        -e 's/export SPARK_MODE="\(.*\)"/export SPARK_MODE="sparkwordcount"/' \
        magpie.${submissiontype}-spark-with-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}* \
        magpie.${submissiontype}-spark-with-rawnetworkfs-spark-${sparkversion}*run-sparkwordcount*

    sed -i \
        -e 's/# export SPARK_SPARKWORDCOUNT_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_FILE=\"hdfs:\/\/\/user\/\${USER}\/test-wordcountfile\"/' \
        magpie.${submissiontype}-spark-with-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}*run-sparkwordcount*

    sed -i \
        -e 's/# export SPARK_SPARKWORDCOUNT_COPY_IN_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_COPY_IN_FILE=\"file:\/\/'"${magpiescriptshomesubst}"'\/testsuite\/testdata\/test-wordcountfile\"/' \
        magpie.${submissiontype}-spark-with-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}*run-sparkwordcount*

    sed -i -e 's/# export SPARK_SPARKWORDCOUNT_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_FILE=\"file:\/\/'"${magpiescriptshomesubst}"'\/testsuite\/testdata\/test-wordcountfile\"/' \
        magpie.${submissiontype}-spark-with-rawnetworkfs-spark-${sparkversion}*run-sparkwordcount*

    sed -i \
        -e 's/export SPARK_MODE="\(.*\)"/export SPARK_MODE="script"/' \
        -e 's/# export SPARK_SCRIPT_PATH="\(.*\)"/export SPARK_SCRIPT_PATH="'"${magpiescriptshomesubst}"'\/testsuite\/testscripts\/test-pythonsparkwordcount-sparkstandalone.sh"/' \
        magpie.${submissiontype}-spark-with-rawnetworkfs-spark-${sparkversion}*run-pythonsparkwordcount*
    
    sed -i \
        -e 's/# export SPARK_LOCAL_SCRATCH_DIR="\(.*\)"/export SPARK_LOCAL_SCRATCH_DIR="'"${ssddirpathsubst}"'\/sparklocalscratch\/"/' \
        magpie.${submissiontype}-spark-with-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}*localscratch-single-path*

    sed -i \
        -e 's/export SPARK_LOCAL_SCRATCH_DIR="\(.*\)"/export SPARK_LOCAL_SCRATCH_DIR="'"${ssddirpathsubst}"'\/sparklocalscratch\/"/' \
        magpie.${submissiontype}-spark-with-rawnetworkfs-spark-${sparkversion}*localscratch-single-path*

    sed -i \
        -e 's/# export SPARK_LOCAL_SCRATCH_DIR="\(.*\)"/export SPARK_LOCAL_SCRATCH_DIR="'"${ssddirpathsubst}"'\/sparklocalscratch\/a,'"${ssddirpathsubst}"'\/sparklocalscratch\/b,'"${ssddirpathsubst}"'\/sparklocalscratch\/c"/' \
        magpie.${submissiontype}-spark-with-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}*localscratch-multiple-paths*

    sed -i \
        -e 's/export SPARK_LOCAL_SCRATCH_DIR="\(.*\)"/export SPARK_LOCAL_SCRATCH_DIR="'"${ssddirpathsubst}"'\/sparklocalscratch\/a,'"${ssddirpathsubst}"'\/sparklocalscratch\/b,'"${ssddirpathsubst}"'\/sparklocalscratch\/c"/' \
        magpie.${submissiontype}-spark-with-rawnetworkfs-spark-${sparkversion}*localscratch-multiple-paths*

    sed -i \
        -e 's/# export SPARK_LOCAL_SCRATCH_DIR_CLEAR="\(.*\)"/export SPARK_LOCAL_SCRATCH_DIR_CLEAR="yes"/' \
        magpie.${submissiontype}-spark-with-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}*localscratch* \
        magpie.${submissiontype}-spark-with-rawnetworkfs-spark-${sparkversion}*localscratch*

    JavaCommonSubstitution ${javaversion} `ls \
        magpie.${submissiontype}-spark-with-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}* \
        magpie.${submissiontype}-spark-with-rawnetworkfs-spark-${sparkversion}*`
}

__GenerateSparkStandardTests_YarnTests_requireyarn() {
    local sparkversion=$1
    local hadoopversion=$2
    local javaversion=$3

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}-hdfsoverlustre-run-sparkpi
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}-hdfsoverlustre-run-sparkpi-no-local-dir

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}-hdfsovernetworkfs-run-sparkpi
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}-hdfsovernetworkfs-run-sparkpi-no-local-dir

    sed -i -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' magpie.${submissiontype}-spark-with-yarn-and-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}*run-sparkpi*

    sed -i -e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="'"${sparkversion}"'"/' magpie.${submissiontype}-spark-with-yarn-and-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}*run-sparkpi*

    sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' magpie.${submissiontype}-spark-with-yarn-and-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}-hdfsoverlustre*run-sparkpi*
    sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' magpie.${submissiontype}-spark-with-yarn-and-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}-hdfsovernetworkfs*run-sparkpi*
    
    JavaCommonSubstitution ${javaversion} `ls magpie.${submissiontype}-spark-with-yarn-and-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}*run-sparkpi*`
}

__GenerateSparkStandardTests_YarnWordCount_requireyarn() {
    local sparkversion=$1
    local hadoopversion=$2
    local javaversion=$3

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}-hdfsoverlustre-run-sparkwordcount-copy-in
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}-hdfsovernetworkfs-run-sparkwordcount-copy-in
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-rawnetworkfs-spark-${sparkversion}-hadoop-${hadoopversion}-run-sparkwordcount
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-rawnetworkfs-spark-${sparkversion}-hadoop-${hadoopversion}-run-pythonsparkwordcount

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}-hdfsoverlustre-localscratch-single-path-run-sparkwordcount-copy-in
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}-hdfsovernetworkfs-localscratch-single-path-run-sparkwordcount-copy-in
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-rawnetworkfs-spark-${sparkversion}-hadoop-${hadoopversion}-localscratch-single-path-run-sparkwordcount

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}-hdfsoverlustre-localscratch-multiple-paths-run-sparkwordcount-copy-in
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}-hdfsovernetworkfs-localscratch-multiple-paths-run-sparkwordcount-copy-in
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-rawnetworkfs-spark-${sparkversion}-hadoop-${hadoopversion}-localscratch-multiple-paths-run-sparkwordcount
 
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}-hdfsoverlustre-run-sparkwordcount-copy-in-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}-hdfsovernetworkfs-run-sparkwordcount-copy-in-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-rawnetworkfs-spark-${sparkversion}-hadoop-${hadoopversion}-run-sparkwordcount-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-rawnetworkfs-spark-${sparkversion}-hadoop-${hadoopversion}-run-pythonsparkwordcount-no-local-dir

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}-hdfsoverlustre-localscratch-single-path-run-sparkwordcount-copy-in-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}-hdfsovernetworkfs-localscratch-single-path-run-sparkwordcount-copy-in-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-rawnetworkfs-spark-${sparkversion}-hadoop-${hadoopversion}-localscratch-single-path-run-sparkwordcount-no-local-dir

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}-hdfsoverlustre-localscratch-multiple-paths-run-sparkwordcount-copy-in-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}-hdfsovernetworkfs-localscratch-multiple-paths-run-sparkwordcount-copy-in-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-rawnetworkfs-spark-${sparkversion}-hadoop-${hadoopversion}-localscratch-multiple-paths-run-sparkwordcount-no-local-dir

    sed -i \
        -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' \
        magpie.${submissiontype}-spark-with-yarn-and-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}*run-sparkwordcount* \
        magpie.${submissiontype}-spark-with-yarn-and-rawnetworkfs-spark-${sparkversion}-hadoop-${hadoopversion}*run-sparkwordcount* \
        magpie.${submissiontype}-spark-with-yarn-and-rawnetworkfs-spark-${sparkversion}-hadoop-${hadoopversion}*run-pythonsparkwordcount*

    sed -i \
        -e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="'"${sparkversion}"'"/' \
        magpie.${submissiontype}-spark-with-yarn-and-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}*run-sparkwordcount* \
        magpie.${submissiontype}-spark-with-yarn-and-rawnetworkfs-spark-${sparkversion}-hadoop-${hadoopversion}*run-sparkwordcount* \
        magpie.${submissiontype}-spark-with-yarn-and-rawnetworkfs-spark-${sparkversion}-hadoop-${hadoopversion}*run-pythonsparkwordcount* 

    sed -i \
        -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
        magpie.${submissiontype}-spark-with-yarn-and-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}-hdfsoverlustre*run-sparkwordcount*

    sed -i \
        -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
        magpie.${submissiontype}-spark-with-yarn-and-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}-hdfsovernetworkfs*run-sparkwordcount*

    sed -i \
        -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="rawnetworkfs"/' \
        magpie.${submissiontype}-spark-with-yarn-and-rawnetworkfs-spark-${sparkversion}-hadoop-${hadoopversion}*run-sparkwordcount* \
        magpie.${submissiontype}-spark-with-yarn-and-rawnetworkfs-spark-${sparkversion}-hadoop-${hadoopversion}*run-pythonsparkwordcount*

    sed -i \
        -e 's/export SPARK_MODE="\(.*\)"/export SPARK_MODE="sparkwordcount"/' \
        magpie.${submissiontype}-spark-with-yarn-and-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}*run-sparkwordcount* \
        magpie.${submissiontype}-spark-with-yarn-and-rawnetworkfs-spark-${sparkversion}-hadoop-${hadoopversion}*run-sparkwordcount* 

    sed -i \
        -e 's/export SPARK_MODE="\(.*\)"/export SPARK_MODE="script"/' \
        -e 's/# export SPARK_SCRIPT_PATH="\(.*\)"/export SPARK_SCRIPT_PATH="'"${magpiescriptshomesubst}"'\/testsuite\/testscripts\/test-pythonsparkwordcount-yarn.sh"/' \
        magpie.${submissiontype}-spark-with-yarn-and-rawnetworkfs-spark-${sparkversion}-hadoop-${hadoopversion}*run-pythonsparkwordcount* 

    sed -i \
        -e 's/# export SPARK_SPARKWORDCOUNT_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_FILE=\"hdfs:\/\/\/user\/\${USER}\/test-wordcountfile\"/' \
        magpie.${submissiontype}-spark-with-yarn-and-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}*run-sparkwordcount*

    sed -i \
        -e 's/# export SPARK_SPARKWORDCOUNT_COPY_IN_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_COPY_IN_FILE=\"file:\/\/'"${magpiescriptshomesubst}"'\/testsuite\/testdata\/test-wordcountfile\"/' \
        magpie.${submissiontype}-spark-with-yarn-and-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}*run-sparkwordcount*

    sed -i -e 's/# export SPARK_SPARKWORDCOUNT_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_FILE=\"file:\/\/'"${magpiescriptshomesubst}"'\/testsuite\/testdata\/test-wordcountfile\"/' \
        magpie.${submissiontype}-spark-with-yarn-and-rawnetworkfs-spark-${sparkversion}-hadoop-${hadoopversion}*run-sparkwordcount*

    sed -i \
        -e 's/# export HADOOP_LOCALSTORE="\(.*\)"/export HADOOP_LOCALSTORE="'"${ssddirpathsubst}"'\/localstore\/"/' \
        magpie.${submissiontype}-spark-with-yarn-and-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}*localscratch-single-path* \
        magpie.${submissiontype}-spark-with-yarn-and-rawnetworkfs-spark-${sparkversion}-hadoop-${hadoopversion}*localscratch-single-path* 

    sed -i \
        -e 's/# export HADOOP_LOCALSTORE="\(.*\)"/export HADOOP_LOCALSTORE="'"${ssddirpathsubst}"'\/localstore\/a,'"${ssddirpathsubst}"'\/localstore\/b,'"${ssddirpathsubst}"'\/localstore\/c"/' \
        magpie.${submissiontype}-spark-with-yarn-and-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}*localscratch-multiple-paths* \
        magpie.${submissiontype}-spark-with-yarn-and-rawnetworkfs-spark-${sparkversion}-hadoop-${hadoopversion}*localscratch-multiple-paths* 

    sed -i \
        -e 's/# export HADOOP_LOCALSTORE_CLEAR="\(.*\)"/export HADOOP_LOCALSTORE_CLEAR="yes"/' \
        magpie.${submissiontype}-spark-with-yarn-and-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}*localscratch* \
        magpie.${submissiontype}-spark-with-yarn-and-rawnetworkfs-spark-${sparkversion}-hadoop-${hadoopversion}*localscratch* 

    sed -i \
	-e 's/# export SPARK_YARN_STAGING_DIR="\(.*\)"/export SPARK_YARN_STAGING_DIR="file:\/\/'"${rawnetworkfsdirpathsubst}"'\/sparkStaging\/'"${sparkversion}"'\/\"/' \
	magpie.${submissiontype}-spark-with-yarn-and-rawnetworkfs-spark-${sparkversion}-hadoop-${hadoopversion}*run-sparkwordcount* \
	magpie.${submissiontype}-spark-with-yarn-and-rawnetworkfs-spark-${sparkversion}-hadoop-${hadoopversion}*run-pythonsparkwordcount*

    JavaCommonSubstitution ${javaversion} `ls \
        magpie.${submissiontype}-spark-with-yarn-and-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}*run-sparkwordcount* \
        magpie.${submissiontype}-spark-with-yarn-and-rawnetworkfs-spark-${sparkversion}-hadoop-${hadoopversion}*run-sparkwordcount* \
        magpie.${submissiontype}-spark-with-yarn-and-rawnetworkfs-spark-${sparkversion}-hadoop-${hadoopversion}*run-pythonsparkwordcount*`
}

GenerateSparkStandardTests() {

    cd ${MAGPIE_SCRIPTS_HOME}/testsuite/

    echo "Making Spark Standard Tests"

    for testfunction in __GenerateSparkStandardTests_BasicTests
    do
        for testgroup in ${spark_test_groups}
        do
            local javaversion="${testgroup}_javaversion"
            for testversion in ${!testgroup}
            do
                ${testfunction} ${testversion} ${!hadoopversion} ${!javaversion}
            done
        done
    done

    for testfunction in __GenerateSparkStandardTests_WordCount __GenerateSparkStandardTests_YarnTests_requireyarn __GenerateSparkStandardTests_YarnWordCount_requireyarn
    do
        for testgroup in ${spark_test_groups}
        do
            local hadoopversion="${testgroup}_hadoopversion"
            local javaversion="${testgroup}_javaversion"
            CheckForDependency "Spark" "Hadoop" ${!hadoopversion}
            for testversion in ${!testgroup}
            do
                __CheckForSparkYarnMinimum ${testfunction} ${testversion}
                ${testfunction} ${testversion} ${!hadoopversion} ${!javaversion}
            done
        done
    done
}

__GenerateSparkDependencyTests_Dependency1HDFS_requiredecommissionhdfs() {
    local sparkversion=$1
    local hadoopversion=$2
    local javaversion=$3

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfsoverlustre-run-sparkwordcount-copy-in
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfsoverlustre-run-sparkwordcount-no-copy
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfs-more-nodes-hdfsoverlustre-run-sparkwordcount-no-copy
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfs-fewer-nodes-hdfsoverlustre-expected-failure
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfs-more-nodes-hdfsoverlustre-decommissionhdfsnodes

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfsovernetworkfs-run-sparkwordcount-copy-in
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfsovernetworkfs-run-sparkwordcount-no-copy
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfs-more-nodes-hdfsovernetworkfs-run-sparkwordcount-no-copy
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfs-fewer-nodes-hdfsovernetworkfs-expected-failure
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfs-more-nodes-hdfsovernetworkfs-decommissionhdfsnodes

    sed -i \
        -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' \
        -e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="'"${sparkversion}"'"/' \
        -e 's/export SPARK_MODE="\(.*\)"/export SPARK_MODE="sparkwordcount"/' \
        magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}*
    
    sed -i \
        -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
        -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Spark1A\/'"${sparkversion}"'"/' \
        magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}*hdfsoverlustre*

    sed -i \
        -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
        -e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Spark1A\/'"${sparkversion}"'"/' \
        magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}*hdfsovernetworkfs*

    sed -i \
        -e 's/# export SPARK_SPARKWORDCOUNT_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_FILE=\"hdfs:\/\/\/user\/\${USER}\/test-wordcountfile\"/' \
        -e 's/# export SPARK_SPARKWORDCOUNT_COPY_IN_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_COPY_IN_FILE=\"file:\/\/'"${magpiescriptshomesubst}"'\/testsuite\/testdata\/test-wordcountfile\"/' \
        magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}*run-sparkwordcount-copy-in*
    
    sed -i \
        -e 's/# export SPARK_SPARKWORDCOUNT_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_FILE=\"hdfs:\/\/\/user\/\${USER}\/test-wordcountfile\"/' \
        magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}*run-sparkwordcount-no-copy*

    # Need to set to get through magpie-check-inputs
    sed -i \
        -e 's/# export SPARK_SPARKWORDCOUNT_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_FILE=\"hdfs:\/\/\/user\/\${USER}\/test-wordcountfile\"/' \
        magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}*hdfs-fewer-nodes*expected-failure

    sed -i \
        -e 's/export MAGPIE_JOB_TYPE="\(.*\)"/export MAGPIE_JOB_TYPE="hadoop"/' \
        -e 's/export HADOOP_MODE="\(.*\)"/export HADOOP_MODE="decommissionhdfsnodes"/' \
        -e 's/# export HADOOP_DECOMMISSION_HDFS_NODE_SIZE=.*/export HADOOP_DECOMMISSION_HDFS_NODE_SIZE='"${basenodecount}"'/' \
        -e 's/export SPARK_SETUP=yes/export SPARK_SETUP=no/' \
        magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}*decommissionhdfsnodes*

    JavaCommonSubstitution ${javaversion} `ls magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}*`
}

__GenerateSparkDependencyTests_Dependency2HDFS_requiredecommissionhdfs() {
    local sparkversion=$1
    local hadoopversion=$2
    local javaversion=$3

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-DependencySpark2A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfs-more-nodes-hdfsoverlustre-run-sparkwordcount-copy-in
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-DependencySpark2A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfs-more-nodes-hdfsoverlustre-run-sparkwordcount-no-copy
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-DependencySpark2A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfs-fewer-nodes-hdfsoverlustre-expected-failure
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-DependencySpark2A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfs-more-nodes-hdfsoverlustre-decommissionhdfsnodes
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-DependencySpark2A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfsoverlustre-run-sparkwordcount-no-copy

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-DependencySpark2A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfs-more-nodes-hdfsovernetworkfs-run-sparkwordcount-copy-in
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-DependencySpark2A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfs-more-nodes-hdfsovernetworkfs-run-sparkwordcount-no-copy
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-DependencySpark2A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfs-fewer-nodes-hdfsovernetworkfs-expected-failure
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-DependencySpark2A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfs-more-nodes-hdfsovernetworkfs-decommissionhdfsnodes
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-DependencySpark2A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfsovernetworkfs-run-sparkwordcount-no-copy

    sed -i \
        -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' \
        -e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="'"${sparkversion}"'"/' \
        -e 's/export SPARK_MODE="\(.*\)"/export SPARK_MODE="sparkwordcount"/' \
        magpie.${submissiontype}-spark-with-hdfs-DependencySpark2A-hadoop-${hadoopversion}-spark-${sparkversion}*
    
    sed -i \
        -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
        -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Spark2A\/'"${sparkversion}"'"/' \
        magpie.${submissiontype}-spark-with-hdfs-DependencySpark2A-hadoop-${hadoopversion}-spark-${sparkversion}*hdfsoverlustre*

    sed -i \
        -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
        -e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Spark2A\/'"${sparkversion}"'"/' \
        magpie.${submissiontype}-spark-with-hdfs-DependencySpark2A-hadoop-${hadoopversion}-spark-${sparkversion}*hdfsovernetworkfs*

    sed -i \
        -e 's/# export SPARK_SPARKWORDCOUNT_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_FILE=\"hdfs:\/\/\/user\/\${USER}\/test-wordcountfile\"/' \
        -e 's/# export SPARK_SPARKWORDCOUNT_COPY_IN_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_COPY_IN_FILE=\"file:\/\/'"${magpiescriptshomesubst}"'\/testsuite\/\/testdata\/test-wordcountfile\"/' \
        magpie.${submissiontype}-spark-with-hdfs-DependencySpark2A-hadoop-${hadoopversion}-spark-${sparkversion}*run-sparkwordcount-copy-in*
    
    sed -i \
        -e 's/# export SPARK_SPARKWORDCOUNT_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_FILE=\"hdfs:\/\/\/user\/\${USER}\/test-wordcountfile\"/' \
        magpie.${submissiontype}-spark-with-hdfs-DependencySpark2A-hadoop-${hadoopversion}-spark-${sparkversion}*run-sparkwordcount-no-copy*

        # Need to set to get through magpie-check-inputs
    sed -i \
        -e 's/# export SPARK_SPARKWORDCOUNT_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_FILE=\"hdfs:\/\/\/user\/\${USER}\/test-wordcountfile\"/' \
        magpie.${submissiontype}-spark-with-hdfs-DependencySpark2A-hadoop-${hadoopversion}-spark-${sparkversion}*hdfs-fewer-nodes*expected-failure

    sed -i \
        -e 's/export MAGPIE_JOB_TYPE="\(.*\)"/export MAGPIE_JOB_TYPE="hadoop"/' \
        -e 's/export HADOOP_MODE="\(.*\)"/export HADOOP_MODE="decommissionhdfsnodes"/' \
        -e 's/# export HADOOP_DECOMMISSION_HDFS_NODE_SIZE=.*/export HADOOP_DECOMMISSION_HDFS_NODE_SIZE='"${basenodecount}"'/' \
        -e 's/export SPARK_SETUP=yes/export SPARK_SETUP=no/' \
        magpie.${submissiontype}-spark-with-hdfs-DependencySpark2A-hadoop-${hadoopversion}-spark-${sparkversion}*decommissionhdfsnodes*

    JavaCommonSubstitution ${javaversion} `ls magpie.${submissiontype}-spark-with-hdfs-DependencySpark2A-hadoop-${hadoopversion}-spark-${sparkversion}*`
}

__GenerateSparkDependencyTests_Dependency3YarnHDFS_requiredecommissionhdfs_requireyarn() {
    local sparkversion=$1
    local hadoopversion=$2
    local javaversion=$3

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-DependencySpark3A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfsoverlustre-run-sparkwordcount-copy-in
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-DependencySpark3A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfsoverlustre-run-sparkwordcount-no-copy
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-DependencySpark3A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfs-more-nodes-hdfsoverlustre-run-sparkwordcount-no-copy
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-DependencySpark3A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfs-fewer-nodes-hdfsoverlustre-expected-failure
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-DependencySpark3A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfs-more-nodes-hdfsoverlustre-decommissionhdfsnodes

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-DependencySpark3A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfsovernetworkfs-run-sparkwordcount-copy-in
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-DependencySpark3A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfsovernetworkfs-run-sparkwordcount-no-copy
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-DependencySpark3A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfs-more-nodes-hdfsovernetworkfs-run-sparkwordcount-no-copy
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-DependencySpark3A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfs-fewer-nodes-hdfsovernetworkfs-expected-failure
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-DependencySpark3A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfs-more-nodes-hdfsovernetworkfs-decommissionhdfsnodes

    sed -i \
        -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' \
        -e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="'"${sparkversion}"'"/' \
        -e 's/export SPARK_MODE="\(.*\)"/export SPARK_MODE="sparkwordcount"/' \
        magpie.${submissiontype}-spark-with-yarn-and-hdfs-DependencySpark3A-hadoop-${hadoopversion}-spark-${sparkversion}*
    
    sed -i \
        -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
        -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Spark3A\/'"${sparkversion}"'"/' \
        magpie.${submissiontype}-spark-with-yarn-and-hdfs-DependencySpark3A-hadoop-${hadoopversion}-spark-${sparkversion}*hdfsoverlustre*

    sed -i \
        -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
        -e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Spark3A\/'"${sparkversion}"'"/' \
        magpie.${submissiontype}-spark-with-yarn-and-hdfs-DependencySpark3A-hadoop-${hadoopversion}-spark-${sparkversion}*hdfsovernetworkfs*

    sed -i \
        -e 's/# export SPARK_SPARKWORDCOUNT_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_FILE=\"hdfs:\/\/\/user\/\${USER}\/test-wordcountfile\"/' \
        -e 's/# export SPARK_SPARKWORDCOUNT_COPY_IN_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_COPY_IN_FILE=\"file:\/\/'"${magpiescriptshomesubst}"'\/testsuite\/\/testdata\/test-wordcountfile\"/' \
        magpie.${submissiontype}-spark-with-yarn-and-hdfs-DependencySpark3A-hadoop-${hadoopversion}-spark-${sparkversion}*run-sparkwordcount-copy-in*
    
    sed -i \
        -e 's/# export SPARK_SPARKWORDCOUNT_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_FILE=\"hdfs:\/\/\/user\/\${USER}\/test-wordcountfile\"/' \
        magpie.${submissiontype}-spark-with-yarn-and-hdfs-DependencySpark3A-hadoop-${hadoopversion}-spark-${sparkversion}*run-sparkwordcount-no-copy*

    # Need to set to get through magpie-check-inputs
    sed -i \
        -e 's/# export SPARK_SPARKWORDCOUNT_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_FILE=\"hdfs:\/\/\/user\/\${USER}\/test-wordcountfile\"/' \
        magpie.${submissiontype}-spark-with-yarn-and-hdfs-DependencySpark3A-hadoop-${hadoopversion}-spark-${sparkversion}*hdfs-fewer-nodes*expected-failure

    sed -i \
        -e 's/export MAGPIE_JOB_TYPE="\(.*\)"/export MAGPIE_JOB_TYPE="hadoop"/' \
        -e 's/export HADOOP_MODE="\(.*\)"/export HADOOP_MODE="decommissionhdfsnodes"/' \
        -e 's/# export HADOOP_DECOMMISSION_HDFS_NODE_SIZE=.*/export HADOOP_DECOMMISSION_HDFS_NODE_SIZE='"${basenodecount}"'/' \
        -e 's/export SPARK_SETUP=yes/export SPARK_SETUP=no/' \
        magpie.${submissiontype}-spark-with-yarn-and-hdfs-DependencySpark3A-hadoop-${hadoopversion}-spark-${sparkversion}*decommissionhdfsnodes*
    
    JavaCommonSubstitution ${javaversion} `ls magpie.${submissiontype}-spark-with-yarn-and-hdfs-DependencySpark3A-hadoop-${hadoopversion}-spark-${sparkversion}*`
}

__GenerateSparkDependencyTests_Dependency4YarnHDFS_requiredecommissionhdfs_requireyarn() {
    local sparkversion=$1
    local hadoopversion=$2
    local javaversion=$3

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-DependencySpark4A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfs-more-nodes-hdfsoverlustre-run-sparkwordcount-copy-in
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-DependencySpark4A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfs-more-nodes-hdfsoverlustre-run-sparkwordcount-no-copy
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-DependencySpark4A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfs-fewer-nodes-hdfsoverlustre-expected-failure
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-DependencySpark4A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfs-more-nodes-hdfsoverlustre-decommissionhdfsnodes
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-DependencySpark4A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfsoverlustre-run-sparkwordcount-no-copy

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-DependencySpark4A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfs-more-nodes-hdfsovernetworkfs-run-sparkwordcount-copy-in
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-DependencySpark4A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfs-more-nodes-hdfsovernetworkfs-run-sparkwordcount-no-copy
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-DependencySpark4A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfs-fewer-nodes-hdfsovernetworkfs-expected-failure
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-DependencySpark4A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfs-more-nodes-hdfsovernetworkfs-decommissionhdfsnodes
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-DependencySpark4A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfsovernetworkfs-run-sparkwordcount-no-copy

    sed -i \
        -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' \
        -e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="'"${sparkversion}"'"/' \
        -e 's/export SPARK_MODE="\(.*\)"/export SPARK_MODE="sparkwordcount"/' \
        magpie.${submissiontype}-spark-with-yarn-and-hdfs-DependencySpark4A-hadoop-${hadoopversion}-spark-${sparkversion}*
    
    sed -i \
        -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
        -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Spark4A\/'"${sparkversion}"'"/' \
        magpie.${submissiontype}-spark-with-yarn-and-hdfs-DependencySpark4A-hadoop-${hadoopversion}-spark-${sparkversion}*hdfsoverlustre*

    sed -i \
        -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
        -e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Spark4A\/'"${sparkversion}"'"/' \
        magpie.${submissiontype}-spark-with-yarn-and-hdfs-DependencySpark4A-hadoop-${hadoopversion}-spark-${sparkversion}*hdfsovernetworkfs*

    sed -i \
        -e 's/# export SPARK_SPARKWORDCOUNT_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_FILE=\"hdfs:\/\/\/user\/\${USER}\/test-wordcountfile\"/' \
        -e 's/# export SPARK_SPARKWORDCOUNT_COPY_IN_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_COPY_IN_FILE=\"file:\/\/'"${magpiescriptshomesubst}"'\/testsuite\/\/testdata\/test-wordcountfile\"/' \
        magpie.${submissiontype}-spark-with-yarn-and-hdfs-DependencySpark4A-hadoop-${hadoopversion}-spark-${sparkversion}*run-sparkwordcount-copy-in*
    
    sed -i \
        -e 's/# export SPARK_SPARKWORDCOUNT_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_FILE=\"hdfs:\/\/\/user\/\${USER}\/test-wordcountfile\"/' \
        magpie.${submissiontype}-spark-with-yarn-and-hdfs-DependencySpark4A-hadoop-${hadoopversion}-spark-${sparkversion}*run-sparkwordcount-no-copy*

        # Need to set to get through magpie-check-inputs
    sed -i \
        -e 's/# export SPARK_SPARKWORDCOUNT_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_FILE=\"hdfs:\/\/\/user\/\${USER}\/test-wordcountfile\"/' \
        magpie.${submissiontype}-spark-with-yarn-and-hdfs-DependencySpark4A-hadoop-${hadoopversion}-spark-${sparkversion}*hdfs-fewer-nodes*expected-failure

    sed -i \
        -e 's/export MAGPIE_JOB_TYPE="\(.*\)"/export MAGPIE_JOB_TYPE="hadoop"/' \
        -e 's/export HADOOP_MODE="\(.*\)"/export HADOOP_MODE="decommissionhdfsnodes"/' \
        -e 's/# export HADOOP_DECOMMISSION_HDFS_NODE_SIZE=.*/export HADOOP_DECOMMISSION_HDFS_NODE_SIZE='"${basenodecount}"'/' \
        -e 's/export SPARK_SETUP=yes/export SPARK_SETUP=no/' \
        magpie.${submissiontype}-spark-with-yarn-and-hdfs-DependencySpark4A-hadoop-${hadoopversion}-spark-${sparkversion}*decommissionhdfsnodes*

    JavaCommonSubstitution ${javaversion} `ls magpie.${submissiontype}-spark-with-yarn-and-hdfs-DependencySpark4A-hadoop-${hadoopversion}-spark-${sparkversion}*`
}

__GenerateSparkDependencyTests_Dependency5rawnetworkfs() {
    local sparkversion=$1
    local javaversion=$2

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-with-rawnetworkfs-DependencySpark5A-spark-${sparkversion}-run-sparkwordcount-copy-in
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-with-rawnetworkfs-DependencySpark5A-spark-${sparkversion}-run-sparkwordcount-no-copy
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-with-rawnetworkfs-DependencySpark5A-spark-${sparkversion}-rawnetworkfs-more-nodes-run-sparkwordcount-no-copy

    sed -i \
        -e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="'"${sparkversion}"'"/' \
        -e 's/export SPARK_MODE="\(.*\)"/export SPARK_MODE="sparkwordcount"/' \
        magpie.${submissiontype}-spark-with-rawnetworkfs-DependencySpark5A-spark-${sparkversion}*

    sed -i \
        -e 's/# export SPARK_SPARKWORDCOUNT_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_FILE=\"file:\/\/'"${lustredirpathsubst}"'\/rawnetworkfs\/DEPENDENCYPREFIX\/Spark5A\/'"${sparkversion}"'\/test-wordcountfile\"/' \
        -e 's/# export SPARK_SPARKWORDCOUNT_COPY_IN_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_COPY_IN_FILE=\"file:\/\/'"${magpiescriptshomesubst}"'\/testsuite\/\/testdata\/test-wordcountfile\"/' \
        magpie.${submissiontype}-spark-with-rawnetworkfs-DependencySpark5A-spark-${sparkversion}*run-sparkwordcount-copy-in*

    sed -i \
        -e 's/# export SPARK_SPARKWORDCOUNT_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_FILE=\"file:\/\/'"${lustredirpathsubst}"'\/rawnetworkfs\/DEPENDENCYPREFIX\/Spark5A\/'"${sparkversion}"'\/test-wordcountfile\"/' \
        magpie.${submissiontype}-spark-with-rawnetworkfs-DependencySpark5A-spark-${sparkversion}*run-sparkwordcount-no-copy*

    JavaCommonSubstitution ${javaversion} `ls magpie.${submissiontype}-spark-with-rawnetworkfs-DependencySpark5A-spark-${sparkversion}*`
}

__GenerateSparkDependencyTests_Dependency6rawnetworkfs() {
    local sparkversion=$1
    local javaversion=$2

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-with-rawnetworkfs-DependencySpark6A-spark-${sparkversion}-rawnetworkfs-more-nodes-run-sparkwordcount-copy-in
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-with-rawnetworkfs-DependencySpark6A-spark-${sparkversion}-rawnetworkfs-more-nodes-run-sparkwordcount-no-copy
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-with-rawnetworkfs-DependencySpark6A-spark-${sparkversion}-run-sparkwordcount-no-copy
    
    sed -i \
        -e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="'"${sparkversion}"'"/' \
        -e 's/export SPARK_MODE="\(.*\)"/export SPARK_MODE="sparkwordcount"/' \
        magpie.${submissiontype}-spark-with-rawnetworkfs-DependencySpark6A-spark-${sparkversion}*
    
    sed -i \
        -e 's/# export SPARK_SPARKWORDCOUNT_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_FILE=\"file:\/\/'"${lustredirpathsubst}"'\/rawnetworkfs\/DEPENDENCYPREFIX\/Spark6A\/'"${sparkversion}"'\/test-wordcountfile\"/' \
        -e 's/# export SPARK_SPARKWORDCOUNT_COPY_IN_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_COPY_IN_FILE=\"file:\/\/'"${magpiescriptshomesubst}"'\/testsuite\/\/testdata\/test-wordcountfile\"/' \
        magpie.${submissiontype}-spark-with-rawnetworkfs-DependencySpark6A-spark-${sparkversion}*run-sparkwordcount-copy-in*
    
    sed -i \
        -e 's/# export SPARK_SPARKWORDCOUNT_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_FILE=\"file:\/\/'"${lustredirpathsubst}"'\/rawnetworkfs\/DEPENDENCYPREFIX\/Spark6A\/'"${sparkversion}"'\/test-wordcountfile\"/' \
        magpie.${submissiontype}-spark-with-rawnetworkfs-DependencySpark6A-spark-${sparkversion}*run-sparkwordcount-no-copy*
    
    JavaCommonSubstitution ${javaversion} `ls magpie.${submissiontype}-spark-with-rawnetworkfs-DependencySpark6A-spark-${sparkversion}*`
}

__GenerateSparkDependencyTests_Dependency7Yarnrawnetworkfs_requireyarn() {
    local sparkversion=$1
    local hadoopversion=$2
    local javaversion=$3

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-rawnetworkfs-DependencySpark7A-spark-${sparkversion}-hadoop-${hadoopversion}-run-sparkwordcount-copy-in
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-rawnetworkfs-DependencySpark7A-spark-${sparkversion}-hadoop-${hadoopversion}-run-sparkwordcount-no-copy
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-rawnetworkfs-DependencySpark7A-spark-${sparkversion}-hadoop-${hadoopversion}-rawnetworkfs-more-nodes-run-sparkwordcount-no-copy

    sed -i \
        -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' \
        -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="rawnetworkfs"/' \
        -e 's/export HADOOP_RAWNETWORKFS_PATH="\(.*\)"/export HADOOP_RAWNETWORKFS_PATH="'"${rawnetworkfsdirpathsubst}"'\/rawnetworkfs\/DEPENDENCYPREFIX\/Spark7A\/'"${sparkversion}"'\/\"/' \
        -e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="'"${sparkversion}"'"/' \
        -e 's/export SPARK_MODE="\(.*\)"/export SPARK_MODE="sparkwordcount"/' \
        magpie.${submissiontype}-spark-with-yarn-and-rawnetworkfs-DependencySpark7A-spark-${sparkversion}-hadoop-${hadoopversion}*

    sed -i \
        -e 's/# export SPARK_SPARKWORDCOUNT_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_FILE=\"file:\/\/'"${lustredirpathsubst}"'\/rawnetworkfs\/DEPENDENCYPREFIX\/Spark7A\/'"${sparkversion}"'\/test-wordcountfile\"/' \
        -e 's/# export SPARK_SPARKWORDCOUNT_COPY_IN_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_COPY_IN_FILE=\"file:\/\/'"${magpiescriptshomesubst}"'\/testsuite\/\/testdata\/test-wordcountfile\"/' \
        magpie.${submissiontype}-spark-with-yarn-and-rawnetworkfs-DependencySpark7A-spark-${sparkversion}-hadoop-${hadoopversion}*run-sparkwordcount-copy-in*

    sed -i \
        -e 's/# export SPARK_SPARKWORDCOUNT_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_FILE=\"file:\/\/'"${lustredirpathsubst}"'\/rawnetworkfs\/DEPENDENCYPREFIX\/Spark7A\/'"${sparkversion}"'\/test-wordcountfile\"/' \
        magpie.${submissiontype}-spark-with-yarn-and-rawnetworkfs-DependencySpark7A-spark-${sparkversion}-hadoop-${hadoopversion}*run-sparkwordcount-no-copy*

    sed -i \
	-e 's/# export SPARK_YARN_STAGING_DIR="\(.*\)"/export SPARK_YARN_STAGING_DIR="file:\/\/'"${rawnetworkfsdirpathsubst}"'\/sparkStaging\/DEPENDENCYPREFIX\/Spark7A\/'"${sparkversion}"'\/\"/' \
	magpie.${submissiontype}-spark-with-yarn-and-rawnetworkfs-DependencySpark7A-spark-${sparkversion}-hadoop-${hadoopversion}*

    JavaCommonSubstitution ${javaversion} `ls magpie.${submissiontype}-spark-with-yarn-and-rawnetworkfs-DependencySpark7A-spark-${sparkversion}-hadoop-${hadoopversion}*`
}

__GenerateSparkDependencyTests_Dependency8Yarnrawnetworkfs_requireyarn() {
    local sparkversion=$1
    local hadoopversion=$2
    local javaversion=$3

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-rawnetworkfs-DependencySpark8A-spark-${sparkversion}-hadoop-${hadoopversion}-rawnetworkfs-more-nodes-run-sparkwordcount-copy-in
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-rawnetworkfs-DependencySpark8A-spark-${sparkversion}-hadoop-${hadoopversion}-rawnetworkfs-more-nodes-run-sparkwordcount-no-copy
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-rawnetworkfs-DependencySpark8A-spark-${sparkversion}-hadoop-${hadoopversion}-run-sparkwordcount-no-copy
    
    sed -i \
        -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' \
        -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="rawnetworkfs"/' \
        -e 's/export HADOOP_RAWNETWORKFS_PATH="\(.*\)"/export HADOOP_RAWNETWORKFS_PATH="'"${rawnetworkfsdirpathsubst}"'\/rawnetworkfs\/DEPENDENCYPREFIX\/Spark8A\/'"${sparkversion}"'\/\"/' \
        -e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="'"${sparkversion}"'"/' \
        -e 's/export SPARK_MODE="\(.*\)"/export SPARK_MODE="sparkwordcount"/' \
        magpie.${submissiontype}-spark-with-yarn-and-rawnetworkfs-DependencySpark8A-spark-${sparkversion}-hadoop-${hadoopversion}*
    
    sed -i \
        -e 's/# export SPARK_SPARKWORDCOUNT_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_FILE=\"file:\/\/'"${lustredirpathsubst}"'\/rawnetworkfs\/DEPENDENCYPREFIX\/Spark8A\/'"${sparkversion}"'\/test-wordcountfile\"/' \
        -e 's/# export SPARK_SPARKWORDCOUNT_COPY_IN_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_COPY_IN_FILE=\"file:\/\/'"${magpiescriptshomesubst}"'\/testsuite\/\/testdata\/test-wordcountfile\"/' \
        magpie.${submissiontype}-spark-with-yarn-and-rawnetworkfs-DependencySpark8A-spark-${sparkversion}-hadoop-${hadoopversion}*run-sparkwordcount-copy-in*
    
    sed -i \
        -e 's/# export SPARK_SPARKWORDCOUNT_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_FILE=\"file:\/\/'"${lustredirpathsubst}"'\/rawnetworkfs\/DEPENDENCYPREFIX\/Spark8A\/'"${sparkversion}"'\/test-wordcountfile\"/' \
        magpie.${submissiontype}-spark-with-yarn-and-rawnetworkfs-DependencySpark8A-spark-${sparkversion}-hadoop-${hadoopversion}*run-sparkwordcount-no-copy*
    
    sed -i \
	-e 's/# export SPARK_YARN_STAGING_DIR="\(.*\)"/export SPARK_YARN_STAGING_DIR="file:\/\/'"${rawnetworkfsdirpathsubst}"'\/sparkStaging\/DEPENDENCYPREFIX\/Spark8A\/'"${sparkversion}"'\/\"/' \
	magpie.${submissiontype}-spark-with-yarn-and-rawnetworkfs-DependencySpark8A-spark-${sparkversion}-hadoop-${hadoopversion}*

    JavaCommonSubstitution ${javaversion} `ls magpie.${submissiontype}-spark-with-yarn-and-rawnetworkfs-DependencySpark8A-spark-${sparkversion}-hadoop-${hadoopversion}*`
}

GenerateSparkDependencyTests() {

    cd ${MAGPIE_SCRIPTS_HOME}/testsuite/

    echo "Making Spark Dependency Tests"

# Dependency 1 Tests, run after another, HDFS over Lustre/Networkfs
# Dependency 2 Tests, run after another, start with more nodes, HDFS over Lustre/Networkfs

    for testfunction in __GenerateSparkDependencyTests_Dependency1HDFS_requiredecommissionhdfs __GenerateSparkDependencyTests_Dependency2HDFS_requiredecommissionhdfs
    do
        for testgroup in ${spark_test_groups}
        do
            local hadoopversion="${testgroup}_hadoopversion"
            local javaversion="${testgroup}_javaversion"
            CheckForDependency "Spark" "Hadoop" ${!hadoopversion}
            CheckForHadoopDecomissionMinimum ${testfunction} "Spark" "Hadoop" ${!hadoopversion} ${hadoop_decomissionhdfs_minimum}
            for testversion in ${!testgroup}
            do
                ${testfunction} ${testversion} ${!hadoopversion} ${!javaversion}
            done
        done
    done

# Dependency 3 Tests, run after another, HDFS over Lustre/Networkfs w/ Yarn 
# Dependency 4 Tests, run after another, start with more nodes, HDFS over Lustre/Networkfs w/ Yarn

    for testfunction in __GenerateSparkDependencyTests_Dependency3YarnHDFS_requiredecommissionhdfs_requireyarn __GenerateSparkDependencyTests_Dependency4YarnHDFS_requiredecommissionhdfs_requireyarn
    do
        for testgroup in ${spark_test_groups}
        do
            local hadoopversion="${testgroup}_hadoopversion"
            local javaversion="${testgroup}_javaversion"
            CheckForDependency "Spark" "Hadoop" ${!hadoopversion}
            CheckForHadoopDecomissionMinimum ${testfunction} "Spark" "Hadoop" ${!hadoopversion} ${hadoop_decomissionhdfs_minimum}
            for testversion in ${!testgroup}
            do
                __CheckForSparkYarnMinimum ${testfunction} ${testversion}
                ${testfunction} ${testversion} ${!hadoopversion} ${!javaversion}
            done
        done
    done

# Dependency 5 Tests, run after another, rawnetworkfs
# Dependency 6 Tests, run after another, start with more nodes, rawnetworkfs

    for testfunction in __GenerateSparkDependencyTests_Dependency5rawnetworkfs __GenerateSparkDependencyTests_Dependency6rawnetworkfs
    do
        for testgroup in ${spark_test_groups}
        do
            local javaversion="${testgroup}_javaversion"
            for testversion in ${!testgroup}
            do
                ${testfunction} ${testversion} ${!javaversion}
            done
        done
    done

# Dependency 7 Tests, run after another, rawnetworkfs w/ Yarn
# Dependency 8 Tests, run after another, start with more nodes, rawnetworkfs w/ Yarn

    for testfunction in __GenerateSparkDependencyTests_Dependency7Yarnrawnetworkfs_requireyarn __GenerateSparkDependencyTests_Dependency8Yarnrawnetworkfs_requireyarn
    do
        for testgroup in ${spark_test_groups}
        do
            local hadoopversion="${testgroup}_hadoopversion"
            local javaversion="${testgroup}_javaversion"
            CheckForDependency "Spark" "Hadoop" ${!hadoopversion}
            for testversion in ${!testgroup}
            do
                __CheckForSparkYarnMinimum ${testfunction} ${testversion}
                ${testfunction} ${testversion} ${!hadoopversion} ${!javaversion}
            done
        done
    done
}

GenerateSparkPostProcessing () {
    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*run-sparkpi*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/run-sparkpi-FILENAMESEARCHREPLACEKEY/" ${files}
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*run-sparkwordcount*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/run-sparkwordcount-FILENAMESEARCHREPLACEKEY/" ${files}
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*run-pythonsparkwordcount*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/run-pythonsparkwordcount-FILENAMESEARCHREPLACEKEY/" ${files}
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*spark-with-yarn*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/usingyarn-FILENAMESEARCHREPLACEKEY/" ${files}
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*spark-with-rawnetworkfs*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/rawnetworkfs-FILENAMESEARCHREPLACEKEY/" ${files}
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*spark-with-yarn-and-rawnetworkfs*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/rawnetworkfs-FILENAMESEARCHREPLACEKEY/" ${files}
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}-spark*hdfs-more-nodes*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/hdfs-more-nodes-FILENAMESEARCHREPLACEKEY/" ${files}
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}-spark*hdfs-more-nodes*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/<my node count>/${basenodesmorenodescount}/" ${files}
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}-spark*hdfs-fewer-nodes*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/<my node count>/${basenodescount}/" ${files}
    fi
}
