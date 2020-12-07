//00000000 JOB 0-000-0-000,'Portlist     ',
//             CLASS=D,REGION=0M,MSGCLASS=X,TIME=NOLIMIT,
//             NOTIFY=&SYSUID
//**********************************************************************
//*
//* List all open ports
//*
//**********************************************************************
//PORTLIST EXEC PGM=BPXBATCH
//STDOUT   DD SYSOUT=*
//STDERR   DD SYSOUT=*
//STDPARM  DD *
sh

echo "UDP Connections\n";
netstat -a | grep UDP | awk '{print $1,$3}' |
 sed 's/\./ /g' | awk '{print $1,$6}' | sort -k2n              ;

echo "\nTCP Connections\n";
netstat -a | grep Listen | awk '{print $1,$3}' |
 sed 's/\./ /g' | awk '{print $1,$6}' | sort -k2n              ;
/*
//*
