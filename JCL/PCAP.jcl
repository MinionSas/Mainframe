//00000000 JOB 0-000-0-000,'Convert Trc to PCAP',
//             CLASS=D,REGION=0M,MSGCLASS=X,TIME=NOLIMIT,
//             NOTIFY=&SYSUID
//*
//*  This job converts TCPIP packet trace to PCAP format
//*  to be read by products like Wireshark
//*
//STEP01   EXEC PGM=IKJEFT1A
//SYSTSPRT DD SYSOUT=*
//SYSPRINT DD SYSOUT=*
//IPCSPRNT DD SYSOUT=*
//IPCSTOC  DD SYSOUT=*
//IPCSDDIR DD DISP=SHR,DSN=DDIR
//INDUMP   DD DISP=SHR,DSN=&SYSUID..TCP.PACKET.TRACE
//SNIFFER  DD DISP=(NEW,CATLG),DSN=&SYSUID..TCPIP.PACKET.PCAP,
//            UNIT=3390,SPACE=(CYL,(200,150),RLSE),
//            DCB=(LRECL=1560,RECFM=VB,BLKSIZE=0)
//IPCSDUMP DD DUMMY
//SYSTSIN  DD *
 IPCS NOPARM
 SETD PRINT NOTERM LENGTH(160000) NOCONFIRM FILE(INDUMP)
 DROPD
 CTRACE COMP(SYSTCPDA) SUB((TCPIP)) -
  OPTIONS((SNIFFER(1500 TCPDUMP) -
  NOREASSEMBLY)) ENTIDLIST(4)
 END
/*
//*
