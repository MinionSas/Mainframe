//00000000 JOB 0-000-0-000,'Test CSSMTP     ',
//             CLASS=D,REGION=0M,MSGCLASS=X,TIME=NOLIMIT,
//             NOTIFY=&SYSUID
//**********************************************************************
//*
//* Test SMTP
//*
//**********************************************************************
//SMTPBAT  EXEC PGM=IEBGENER
//SYSIN    DD  DUMMY
//SYSPRINT DD  SYSOUT=*
//SYSOUT   DD  SYSOUT=*
//SYSUT2   DD  SYSOUT=(DUMMY,SMTP)
//SYSUT1   DD  *
HELO CSSMTP
MAIL FROM:<email@domain.net>
RCPT TO:<email@domain.net>
DATA
From:     email@domain.net
To:       email@domain.net
Subject:  Testing E-mail

Hello this is an email.
/*
