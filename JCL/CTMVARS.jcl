//00000000 JOB 0-000-0-000,'Control-M Vars  ',
//             CLASS=D,REGION=0M,MSGCLASS=X,TIME=NOLIMIT,
//             NOTIFY=&SYSUID
//**********************************************************************
//*
//* Test all Control-M Variables available
//*
//**********************************************************************
//*
//STEP1    EXEC PGM=IEFBR14
//*
//*  Group:        %%GROUP
//*  Jobname:      %%JOBNAME
//*  OrderID:      %%ORDERID
//*  OWNER:        %%OWNER
//*  RUN Number:   %%RN
//*  Current Time: %%TIME
//*  Current Time: %%TIMEID
//*  Date Format:  %%$DATEFMT
//*  LPAR:         %%$L
//*  Member Name:  %%$MEMNAME
//*  Queue Name:   %%$QNAME
//*  RuleBased Cal: %%$RBC
//*  Sched Library:%%$SCHDLIB
//*  Sched Table:  %%$SCHDTAB
//*  Sched Env:    %%$SCHENV
//*  Affinity:     %%$SIGN
//*  SYS Name:     %%$SYSNAME
//*
//*  Date Variables (system)
//*
//*  Century:      %%$CENT
//*  Current Date: %%DATE
//*  Current Day:  %%DAY
//*  Current Month:%%MONTH
//*  Current Year: %%YEAR
//*  Current Week: %%WEEK
//*  Week Day:     %%WKDAY
//*  Julian Day:   %%JULDAY
//*
//*  Original Dates
//*
//*  Century:      %%$OCENT
//*  Current Date: %%ODATE
//*  Current Day:  %%ODAY
//*  Current Month:%%OMONTH
//*  Current Year: %%OYEAR
//*  Current Week: %%OWEEK
//*  Week Day:     %%OWKDAY
//*  Julian Day:   %%OJULDAY
//*
//*  Working Dates
//*
//*  Century:      %%$RCENT
//*  Current Date: %%RDATE
//*  Current Day:  %%RDAY
//*  Current Month:%%RMONTH
//*  Current Year: %%RYEAR
//*  Current Week: %%RWEEK
//*  Week Day:     %%RWKDAY
//*  Julian Day:   %%RJULDAY
//*
//*  Functions
//*
//*  %%SET %%PREVYRM = %%$CALCDTE %%$DATE -D1
//*  %%SET %%PREVDAY = %%$CALCDTE %%$DATE -D1
//*  %%SET %%PREVMONT = %%$CALCDTE %%$DATE -M1
//*  %%SET %%PREVYEAR = %%$CALCDTE %%$DATE -Y1
//*
//*  Prev Day:     %%PREVDAY
//*  Prev Month:   %%PREVMONT
//*  Prev Year:    %%PREVYEAR
//*
