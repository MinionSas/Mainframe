//00000000 JOB 0-000-0-000,'Test SSL Conn    ',
//             CLASS=D,REGION=0M,MSGCLASS=X,TIME=NOLIMIT,
//             NOTIFY=&SYSUID
//**********************************************************************
//*
//* Test a SSL Connection using Rocket openssl
//*
//**********************************************************************
//        EXPORT SYMLIST=*
//*
//        SET HOST='hostname.or.ip'        Hostname to test
//        SET PORT='992'                   Port to test
//*
//STEP01  EXEC PGM=BPXBATCH
//STDENV   DD *
OPENSSL_CONF=/usr/lpp/tools/ssl/openssl.cnf
//STDOUT   DD SYSOUT=*
//STDERR   DD SYSOUT=*
//STDPARM  DD *,SYMBOLS=JCLONLY
sh
openssl s_client -showcerts -state
 -connect &host:&port;
;
/*
