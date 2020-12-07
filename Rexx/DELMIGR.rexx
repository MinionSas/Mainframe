/* rexx */

parse arg hlq

num = 0
dsList.0 = num

if hlq == '' then do
  call progExit 8 'You must specify dataset qualifier as first argument!'
end

x = outtrap(output.)
"listcat level('"hlq"')"
outRc = rc
x = outtrap(off)

if outRc = 0 then do
  do i = 1 to output.0
    if (word(output.i,1) == "NONVSAM") then do
      dsn = strip(word(output.i,3))
      x = listdsi("'"dsn"' NORECALL")

      if x == 16 then do
        num = num + 1
        dsList.num = ' HDELETE ''' || dsn || ''''
        address tso "HDELETE '"dsn"'"
      end
    end
  end

  dsList.0 = num

  "execio * diskw OUTPUT (stem dsList. finis)"
  if (rc > 0) then do
    call progExit rc 'Could not write to DD OUTPUT'
  end

  say ""
  say "*******  Processing Information ********"
  say ""
  say "Number of Datasets:" num
  say "DSName Processed:  " hlq
  say ""

end

else do
  call progExit outRc 'Listds command failed!'
end

exit 0

progExit:
   parse arg exitRc funcMsg
   say ""
   say "Error:" funcMsg
   say "RC:" exitRc
   ZISPFRC = exitRc
   "ISPEXEC VPUT (ZISPFRC)"
exit exitRc
