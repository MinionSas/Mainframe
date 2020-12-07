//00000000 JOB 0-000-0-000,'Name            ',
//             CLASS=D,REGION=0M,MSGCLASS=X,TIME=NOLIMIT,
//             NOTIFY=&SYSUID
//**********************************************************************
//*
//* LDAP Reload
//*
//**********************************************************************
//        EXPORT SYMLIST=*
//*
//        SET HOST='127.0.0.1'             Hostname to test
//        SET UID='xxxxxxxx'               User ID
//        SET PASSWD='xxxxxxxx'            User Password
//        SET LPAR='xxx'                   Name of LPAR
//        SET LDIFFILE='/var/ldap/schema/unload.ldif'
//        SET SCHEMA='/var/ldap/schema/schema.db'
//*******************************************************************
//* Apply ldap schema changes back
//*******************************************************************
//SCHEMA1 EXEC PGM=BPXBATCH
//STDOUT   DD SYSOUT=*
//STDERR   DD SYSOUT=*
//STDPARM  DD *,SYMBOLS=EXECSYS
sh
export GSK_PROTOCOL_TLSV1_2=ON;

ldapmodify -h &host -Z -v
 -K /var/ldap/certs
 -P file:///var/ldap/certs.sth
 -D racfid=&UID,profiletype=user,cn=&LPAR
 -w &PASSWD
 -f &LDIFFILE
;
/*
