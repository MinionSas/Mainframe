//00000000 JOB 0-000-0-000,'List USS Files  ',
//             CLASS=D,REGION=0M,MSGCLASS=X,TIME=NOLIMIT,
//             NOTIFY=&SYSUID
//**********************************************************************
//*
//* List USS Files
//*
//**********************************************************************
//*
//STEP01  EXEC PGM=BPXBATCH
//STDOUT   DD   SYSOUT=*
//STDERR   DD   SYSOUT=*
//STDPARM  DD *
sh

echo '=================================';
echo '=      Filter by Jobname        =';
echo '=================================';
zlsof -j TCPIP,RESOLVER,FTPD1           ;

echo '';
echo '=================================';
echo '=     Tally of files types      =';
echo '=================================';
zlsof -t                                ;

echo '';
echo '=================================';
echo '=      Filter by User ID        =';
echo '=================================';
zlsof -u userid                         ;

/*
