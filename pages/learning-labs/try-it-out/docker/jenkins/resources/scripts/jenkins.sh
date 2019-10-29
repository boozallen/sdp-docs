#! /bin/bash -e

: "${JENKINS_WAR:="/usr/share/jenkins/jenkins.war"}"
: "${JENKINS_HOME:="/var/jenkins_home"}"
touch "${COPY_REFERENCE_FILE_LOG}" || { echo "Can not write to ${COPY_REFERENCE_FILE_LOG}. Wrong volume permissions?"; exit 1; }
echo "--- Copying files at $(date)" >> "$COPY_REFERENCE_FILE_LOG"
find /usr/share/jenkins/ref/ \( -type f -o -type l \) -exec bash -c '. /usr/local/bin/jenkins-support; for arg; do copy_reference_file "$arg"; done' _ {} +

# init groovy scripts 
cp $INIT_GROOVY_DIR/** $JENKINS_HOME/init.groovy.d/ 

# Jenkins Performance Tuning ##############################
CONTAINER_MEMORY_IN_BYTES=$(cat /sys/fs/cgroup/memory/memory.limit_in_bytes)
CONTAINER_MEMORY_IN_MB=$((CONTAINER_MEMORY_IN_BYTES/2**20))

# initialize java performance opts 
JAVA_PERFORMANCE_OPTS="-Dsun.zip.disableMemoryMapping=true -XX:+UnlockExperimentalVMOptions"

# set heap settings
CONTAINER_HEAP_PERCENT=0.50
CONTAINER_HEAP_MAX=$(echo "${CONTAINER_MEMORY_IN_MB} ${CONTAINER_HEAP_PERCENT}" | awk '{ printf "%d", $1 * $2 }')
JAVA_PERFORMANCE_OPTS="$JAVA_PERFORMANCE_OPTS -Xmx${CONTAINER_HEAP_MAX}m"

# set gc settings
JAVA_GC_OPTS="-server -XX:+AlwaysPreTouch -XX:+UseG1GC -XX:+ExplicitGCInvokesConcurrent -XX:+ParallelRefProcEnabled -XX:+UseStringDeduplication -XX:+UnlockDiagnosticVMOptions -XX:G1SummarizeRSetStatsPeriod=1"
JAVA_PERFORMANCE_OPTS="$JAVA_PERFORMANCE_OPTS $JAVA_GC_OPTS"

##########################################################
exec java -Duser.home="$JENKINS_HOME" "$JAVA_OPTS" "$JAVA_PERFORMANCE_OPTS" -jar ${JENKINS_WAR} "$JENKINS_OPTS"