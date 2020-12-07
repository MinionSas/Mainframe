//00000000 JOB 0-000-0-000,'IP Filter       ',
//             CLASS=D,REGION=0M,MSGCLASS=X,TIME=NOLIMIT,
//             NOTIFY=&SYSUID
//**********************************************************************
//*
//* Set IP Filtering Rules using IPSec
//*
//**********************************************************************
//*
//        EXPORT SYMLIST=*
//*
//        SET SRCIP='192.168.1.1'         Source IP Address
//        SET DESTIP='all'                Destination IP Address
//        SET PORT='21'                   Inbound Port
//        SET LIFETIME='3600'             Life Time in Minutes
//        SET POLNAME='BlockPort1'        Policy Name
//*
//STEP01  EXEC PGM=BPXBATCH
//STDOUT   DD SYSOUT=*
//STDERR   DD SYSOUT=*
//STDPARM  DD *,SYMBOLS=JCLONLY
sh

echo '=================================';
echo '=        Set Filter             =';
echo '=================================';
ipsec -G -F add
 destip &DESTIP
 srcip &SRCIP
 lifetime &LIFETIME
 prot tcp
 destport &PORT
 -N &POLNAME
;

echo '=================================';
echo '=        IPSec Policies         =';
echo '=================================';
ipsec -G -F display;

/*
//*
//
echo '=================================';
echo '=    Remove IPSec Policy        =';
echo '=================================';
ipsec -G -F delete -N &POLNAME;
