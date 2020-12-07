//KAFKAPRO  PROC HOSTNAME='kafka.server.hostname',
//   PORT='9094',
//   TOPIC='topicname'
//*
//* Kafka Producer with Java
//*
//KAFKAPRO EXEC PGM=JVMLDM86,
//  PARM='/ KafProducer &HOSTNAME &PORT &TOPIC'
//SYSPRINT DD SYSOUT=*
//SYSIN    DD DUMMY
//SYSOUT   DD SYSOUT=*
//STDOUT   DD SYSOUT=*
//STDERR   DD SYSOUT=*
//STDENV   DD *
. /etc/profile
export JAVA_HOME=/usr/lpp/java/current_64
export PATH=/bin:"${JAVA_HOME}"/bin
LIBPATH=/lib:/usr/lib:"${JAVA_HOME}"/bin
LIBPATH="$LIBPATH":"${JAVA_HOME}"/lib/s390
LIBPATH="$LIBPATH":"${JAVA_HOME}"/lib/s390/j9vm
LIBPATH="$LIBPATH":"${JAVA_HOME}"/bin/classic
export LIBPATH="$LIBPATH":

# Customize your CLASSPATH here
APP_HOME=/var/kafka/kafka_2.13-2.5.0/libs
CLASSPATH=$APP_HOME:"${JAVA_HOME}"/lib:"${JAVA_HOME}"/lib/ext

# Add Application required jars to end of CLASSPATH
for i in "${APP_HOME}"/*.jar; do
    CLASSPATH="$CLASSPATH":"$i"
    done

CLASSPATH=$CLASSPATH:/var/kafka/classes
export CLASSPATH="$CLASSPATH":

# Configure JVM options
IJO="-Xms128m -Xmx2048m"
export IBM_JAVA_OPTIONS="$IJO "

/*
