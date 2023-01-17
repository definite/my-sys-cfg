### An example rule showing that that external monitor should be on the left
### when Lenove V1003 and external monitor are connected
### To disable this rule, uncomment the following line
# return 1

MscDocks=$(msc_condition_met docked)
if [ $? -ne 0 -o ! $MscDocks = '17ef:30ba' ]; then
  unset MscDocks
  return 1
fi

### I only have one external monitor on V1003, so no need to handle multiple monitor
MscMonitorOutput=$(msc_condition_met external-monitors)
echo "MscMonitorOutput=$MscMonitorOutput" > /dev/stderr

if [ $? -eq 1 ]; then
  unset MscMonitorOutput
  return 1
fi 

echo -e "$MscMonitorOutput\t--auto --rotate normal --pos 0x0 --primary"
echo -e "eDP-1\t--auto --rotate normal --right-of $MscMonitorOutput"
unset MscDocks MscMonitorOutput
return 0
