#!/bin/bash

source test-generate-common.sh
source test-common.sh
source test-config.sh

__GeneratePhoenixStandardTests_Performanceeval() {
    local phoenixversion=$1
    local hbaseversion=$2
    local hadoopversion=$3
    local zookeeperversion=$4
    local javaversion=$5

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-zookeeper-not-shared-zookeeper-networkfs-run-phoenixperformanceeval
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-zookeeper-not-shared-zookeeper-local-run-phoenixperformanceeval
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-zookeeper-shared-zookeeper-networkfs-run-phoenixperformanceeval
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-zookeeper-shared-zookeeper-local-run-phoenixperformanceeval

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-zookeeper-not-shared-zookeeper-networkfs-run-phoenixperformanceeval
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-zookeeper-not-shared-zookeeper-local-run-phoenixperformanceeval
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-zookeeper-shared-zookeeper-networkfs-run-phoenixperformanceeval
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-zookeeper-shared-zookeeper-local-run-phoenixperformanceeval
    
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-zookeeper-not-shared-zookeeper-networkfs-run-phoenixperformanceeval-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-zookeeper-not-shared-zookeeper-local-run-phoenixperformanceeval-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-zookeeper-shared-zookeeper-networkfs-run-phoenixperformanceeval-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-zookeeper-shared-zookeeper-local-run-phoenixperformanceeval-no-local-dir

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-zookeeper-not-shared-zookeeper-networkfs-run-phoenixperformanceeval-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-zookeeper-not-shared-zookeeper-local-run-phoenixperformanceeval-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-zookeeper-shared-zookeeper-networkfs-run-phoenixperformanceeval-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-zookeeper-shared-zookeeper-local-run-phoenixperformanceeval-no-local-dir
    
    sed -i -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*
    sed -i -e 's/export HBASE_VERSION="\(.*\)"/export HBASE_VERSION="'"${hbaseversion}"'"/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*
    sed -i -e 's/export ZOOKEEPER_VERSION="\(.*\)"/export ZOOKEEPER_VERSION="'"${zookeeperversion}"'"/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*
    sed -i -e 's/export PHOENIX_VERSION="\(.*\)"/export PHOENIX_VERSION="'"${phoenixversion}"'"/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*
    
    sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*hdfsoverlustre*
    sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*hdfsovernetworkfs*

    sed -i -e 's/# export ZOOKEEPER_DATA_DIR_CLEAR="yes"/export ZOOKEEPER_DATA_DIR_CLEAR="yes"/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*zookeeper-local*

    sed -i -e 's/export ZOOKEEPER_DATA_DIR="\(.*\)"/export ZOOKEEPER_DATA_DIR="'"${ssddirpathsubst}"'\/zookeeper\/"/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*zookeeper-local*

    sed -i -e 's/export ZOOKEEPER_DATA_DIR_TYPE="\(.*\)"/export ZOOKEEPER_DATA_DIR_TYPE="networkfs"/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*zookeeper-networkfs*
    sed -i -e 's/export ZOOKEEPER_DATA_DIR_TYPE="\(.*\)"/export ZOOKEEPER_DATA_DIR_TYPE="local"/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*zookeeper-local*
    
    sed -i -e 's/# export ZOOKEEPER_SHARE_NODES=yes/export ZOOKEEPER_SHARE_NODES=no/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*zookeeper-not-shared*
    sed -i -e 's/# export ZOOKEEPER_SHARE_NODES=yes/export ZOOKEEPER_SHARE_NODES=yes/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*zookeeper-shared*

    JavaCommonSubstitution ${javaversion} `ls magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*`
}

GeneratePhoenixStandardTests() {

    cd ${MAGPIE_SCRIPTS_HOME}/testsuite/

    echo "Making Phoenix Standard Tests"
    
    for testfunction in __GeneratePhoenixStandardTests_Performanceeval
    do
        for testgroup in ${phoenix_test_groups}
        do
            local hbaseversion="${testgroup}_hbaseversion"
            local hadoopversion="${testgroup}_hadoopversion"
            local zookeeperversion="${testgroup}_zookeeperversion"
            local javaversion="${testgroup}_javaversion"
            CheckForDependency "Phoenix" "Hbase" ${!hbaseversion}
            CheckForDependency "Phoenix" "Hadoop" ${!hadoopversion}
            CheckForDependency "Phoenix" "Zookeeper" ${!zookeeperversion}
            for testversion in ${!testgroup}
            do
                ${testfunction} ${testversion} ${!hbaseversion} ${!hadoopversion} ${!zookeeperversion} ${!javaversion}
            done
        done
    done
}

__GeneratePhoenixDependencyTests_Dependency1() {
    local phoenixversion=$1
    local hbaseversion=$2
    local hadoopversion=$3
    local zookeeperversion=$4
    local javaversion=$5

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix1A-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-run-phoenixperformanceeval
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix1A-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-run-phoenixperformanceeval

    sed -i \
        -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' \
        -e 's/export HBASE_VERSION="\(.*\)"/export HBASE_VERSION="'"${hbaseversion}"'"/' \
        -e 's/export PHOENIX_VERSION="\(.*\)"/export PHOENIX_VERSION="'"${phoenixversion}"'"/' \
        -e 's/export ZOOKEEPER_VERSION="\(.*\)"/export ZOOKEEPER_VERSION="'"${zookeeperversion}"'"/' \
        -e 's/export ZOOKEEPER_DATA_DIR_TYPE="\(.*\)"/export ZOOKEEPER_DATA_DIR_TYPE="networkfs"/' \
        magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix1A-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*run-phoenixperformanceeval

    sed -i \
        -e 's/export ZOOKEEPER_DATA_DIR="\(.*\)"/export ZOOKEEPER_DATA_DIR="'"${zookeeperdatadirpathsubst}"'\/zookeeper\/DEPENDENCYPREFIX\/hdfsoverlustre\/Phoenix1A\/'"${phoenixversion}"'"/' \
        magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix1A-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*hdfsoverlustre*

    sed -i \
        -e 's/export ZOOKEEPER_DATA_DIR="\(.*\)"/export ZOOKEEPER_DATA_DIR="'"${zookeeperdatadirpathsubst}"'\/zookeeper\/DEPENDENCYPREFIX\/hdfsovernetworkfs\/Phoenix1A\/'"${phoenixversion}"'"/' \
        magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix1A-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*hdfsovernetworkfs*

    sed -i \
        -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
        -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Phoenix1A\/'"${phoenixversion}"'"/' \
        magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix1A-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*hdfsoverlustre*

    sed -i \
        -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
        -e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Phoenix1A\/'"${phoenixversion}"'"/' \
        magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix1A-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*hdfsovernetworkfs*
    
    JavaCommonSubstitution ${javaversion} `ls magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix1A-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*run-phoenixperformanceeval`
}

__GeneratePhoenixDependencyTests_Dependency2() {
    local phoenixversion=$1
    local hbaseversion=$2
    local hadoopversion=$3
    local zookeeperversion=$4
    local javaversion=$5

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix2A-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-run-phoenixperformanceeval
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix2A-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-run-hbaseperformanceeval

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix2A-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-run-phoenixperformanceeval
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix2A-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-run-hbaseperformanceeval

    sed -i \
        -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' \
        -e 's/export HBASE_VERSION="\(.*\)"/export HBASE_VERSION="'"${hbaseversion}"'"/' \
        -e 's/export PHOENIX_VERSION="\(.*\)"/export PHOENIX_VERSION="'"${phoenixversion}"'"/' \
        -e 's/export ZOOKEEPER_VERSION="\(.*\)"/export ZOOKEEPER_VERSION="'"${zookeeperversion}"'"/' \
        -e 's/export ZOOKEEPER_DATA_DIR_TYPE="\(.*\)"/export ZOOKEEPER_DATA_DIR_TYPE="networkfs"/' \
        magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix2A-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*

    sed -i \
        -e 's/export ZOOKEEPER_DATA_DIR="\(.*\)"/export ZOOKEEPER_DATA_DIR="'"${zookeeperdatadirpathsubst}"'\/zookeeper\/DEPENDENCYPREFIX\/hdfsoverlustre\/Phoenix2A\/'"${phoenixversion}"'"/' \
        magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix2A-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*hdfsoverlustre*

    sed -i \
        -e 's/export ZOOKEEPER_DATA_DIR="\(.*\)"/export ZOOKEEPER_DATA_DIR="'"${zookeeperdatadirpathsubst}"'\/zookeeper\/DEPENDENCYPREFIX\/hdfsovernetworkfs\/Phoenix2A\/'"${phoenixversion}"'"/' \
        magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix2A-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*hdfsovernetworkfs*

    sed -i \
        -e 's/export MAGPIE_JOB_TYPE="\(.*\)"/export MAGPIE_JOB_TYPE="hbase"/' \
        magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix2A-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*run-hbaseperformanceeval

    sed -i \
        -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
        -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Phoenix2A\/'"${phoenixversion}"'"/' \
        magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix2A-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*hdfsoverlustre*

    sed -i \
        -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
        -e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Phoenix2A\/'"${phoenixversion}"'"/' \
        magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix2A-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*hdfsovernetworkfs*

    JavaCommonSubstitution ${javaversion} `ls magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix2A-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*`
}

GeneratePhoenixDependencyTests() {

    cd ${MAGPIE_SCRIPTS_HOME}/testsuite/

    echo "Making Phoenix Dependency Tests"

# Dependency 1 Tests, run after another, HDFS over Lustre / NetworkFS
# Dependency 2 Tests, run after another with hbase, HDFS over Lustre / NetworkFS

    for testfunction in __GeneratePhoenixDependencyTests_Dependency1 __GeneratePhoenixDependencyTests_Dependency2
    do
        for testgroup in ${phoenix_test_groups}
        do
            local hbaseversion="${testgroup}_hbaseversion"
            local hadoopversion="${testgroup}_hadoopversion"
            local zookeeperversion="${testgroup}_zookeeperversion"
            local javaversion="${testgroup}_javaversion"
            CheckForDependency "Phoenix" "Hbase" ${!hbaseversion}
            CheckForDependency "Phoenix" "Hadoop" ${!hadoopversion}
            CheckForDependency "Phoenix" "Zookeeper" ${!zookeeperversion}
            for testversion in ${!testgroup}
            do
                ${testfunction} ${testversion} ${!hbaseversion} ${!hadoopversion} ${!zookeeperversion} ${!javaversion}
            done
        done
    done
}

GeneratePhoenixPostProcessing () {
    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*run-phoenixperformanceeval*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/run-phoenixperformanceeval-FILENAMESEARCHREPLACEKEY/" ${files}
    fi
}

