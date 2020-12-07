//00000000 JOB 0-000-0-000,'FTP over TLS    ',
//             CLASS=D,REGION=0M,MSGCLASS=X,TIME=NOLIMIT,
//             NOTIFY=&SYSUID
//**********************************************************************
//*
//* FTP over TLS
//*
//**********************************************************************
//*
//FTP     EXEC PGM=FTP,PARM=' -r tls (EXIT'
//SYSTSPRT  DD SYSOUT=*
//OUTPUT    DD SYSOUT=*
//CEEOPTS  DD *
ENVAR("GSK_PROTOCOL_TLSV1_2=1")
/*
//SYSFTPD   DD *
CLIENTERRCODES    EXTENDED
EPSV4             TRUE
FWFRIENDLY        TRUE
PASSIVEIGNOREADDR TRUE
SECUREIMPLICITZOS FALSE
SECURE_FTP        REQUIRED
SECURE_MECHANISM  TLS
KEYRING           *AUTH*/*
SECURE_DATACONN   PRIVATE
SECURE_CTRLCONN   PRIVATE
SECURE_HOSTNAME   REQUIRED
//INPUT     DD *
 hostname
 userid
 password
 ls
 ascii
 quit
/*
//*
//
