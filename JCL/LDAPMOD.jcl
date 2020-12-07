//00000000 JOB 0-000-0-000,'LDAP Modify     ',
//             CLASS=D,REGION=0M,MSGCLASS=X,TIME=NOLIMIT,
//             NOTIFY=&SYSUID
//**********************************************************************
//*
//* LDAP Modify
//*
//**********************************************************************
//*
//        EXPORT SYMLIST=*
//*
//        SET HOST='127.0.0.1'             Hostname to test
//        SET UID='xxxxxxxx'               User ID
//        SET PASSWD='xxxxxxxx'            User Password
//        SET LPAR='xxxx'                  Name of LPAR
//        SET LDIF='/var/ldap/schema/unload.ldif'    Name of LDIF file
//*
//STEP01  EXEC PGM=BPXBATCH
//STDOUT   DD SYSOUT=*
//STDERR   DD SYSOUT=*
//STDPARM  DD *,SYMBOLS=JCLONLY
sh
export GSK_PROTOCOL_TLSV1_2=ON;

ldapmodify -h &host -Z -v
 -K /var/ldap/certs
 -P file:///var/ldap/certs.sth
 -D racfid=&UID,profiletype=user,cn=&LPAR
 -w &PASSWD
 -f &LDIF
;
/*
