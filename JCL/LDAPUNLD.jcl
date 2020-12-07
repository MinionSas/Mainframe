//00000000 JOB 0-000-0-000,'Name            ',
//             CLASS=D,REGION=0M,MSGCLASS=X,TIME=NOLIMIT,
//             NOTIFY=&SYSUID
//**********************************************************************
//*
//* LDAP Unload
//*
//**********************************************************************
//         EXPORT SYMLIST=*
//*
//         SET SCHEMA='/var/ldap/schema/schema.db'
//         SET SCHEMAF='/var/ldap/schema'
//         SET TCPCONF='TCPIP.CONF.FILE'
//         SET OUTLDIF='-o /var/ldap/schema/unload.BK200308.ldif'
//         SET OUTFILE='/var/ldap/schema/unload.BK200308.out'
//         SET PARMS='-s cn=schema'
//*
//*******************************************************************
//* Change Permissions
//*******************************************************************
//STEP01   EXEC PGM=BPXBATCH,COND=(0,LT)
//STDOUT   DD SYSOUT=*
//STDERR   DD SYSOUT=*
//STDPARM  DD *,SYMBOLS=EXECSYS
sh
chown &SYSUID &SCHEMAF;
chgrp GROUP   &SCHEMAF;
chown &SYSUID &SCHEMA;
chgrp GROUP   &SCHEMA;
/*
//*******************************************************************
//* Create an Unload LDIF File
//*******************************************************************
//STEP02   EXEC PGM=GLDUNL64,COND=(0,NE),
//  PARM=('/&OUTLDIF &PARMS > DD:DSOUT 2>&1')
//CONFIG   DD DISP=SHR,DSN=&TCPCONF.(LDAPCFG)
//ENVVAR   DD DISP=SHR,DSN=&TCPCONF.(LDAPENV)
//DSOUT    DD PATH='&OUTFILE',
//         PATHOPTS=(OWRONLY,OCREAT,OTRUNC),
//         PATHMODE=SIRWXU
//*******************************************************************
//* See output from the unload
//*******************************************************************
//STEP03    EXEC PGM=IKJEFT1A
//SYSTSPRT  DD DUMMY
//HFSOUT    DD PATHDISP=DELETE,PATH='&OUTFILE'
//STDOUT    DD SYSOUT=*,DCB=(RECFM=VB,LRECL=133,BLKSIZE=137)
//SYSPRINT  DD DUMMY
//SYSTSIN   DD DATA,DLM='/>'
 ocopy indd(HFSOUT) outdd(STDOUT)
/>
//*
//*******************************************************************
//* Change Permissions Back
//*******************************************************************
//STEP04   EXEC PGM=BPXBATCH,COND=(0,LT)
//STDOUT   DD SYSOUT=*
//STDERR   DD SYSOUT=*
//STDPARM  DD *,SYMBOLS=EXECSYS
sh
chown LDAPSRV &SCHEMAF;
chgrp LDAPGRP &SCHEMAF;
chown LDAPSRV &SCHEMA;
chgrp LDAPGRP &SCHEMA;
/*
//*******************************************************************
//* Take a backup of the ldap schema db file
//*******************************************************************
//BKSCHEMA EXEC PGM=BPXBATCH,COND=(0,LT)
//STDOUT   DD SYSOUT=*
//STDERR   DD SYSOUT=*
//STDPARM  DD *,SYMBOLS=EXECSYS
sh mv &SCHEMA
&SCHEMA..BK&LYYMMDD..T&LHHMMSS.
/*
