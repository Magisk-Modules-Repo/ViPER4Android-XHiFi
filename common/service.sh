if [ -d /system/priv-app ]; then SOURCE=priv_app; else SOURCE=system_app; fi

if [ "$SEINJECT" != "/sbin/sepolicy-inject" ]; then
  $SEINJECT --live "allow audioserver audioserver_tmpfs file { read write execute }" "allow audioserver system_file file execmod" "allow mediaserver mediaserver_tmpfs file { read write execute }" "allow mediaserver system_file file execmod" "allow audioserver unlabeled file { read write execute open getattr }" "allow hal_audio_default hal_audio_default process execmem" "allow hal_audio_default hal_audio_default_tmpfs file execute" "allow hal_audio_default audio_data_file dir search" "allow $SOURCE system_data_file file open"
else
  $SEINJECT -s audioserver -t audioserver_tmpfs -c file -p read,write,execute -l
  $SEINJECT -s audioserver -t system_file -c file -p execmod -l
  $SEINJECT -s mediaserver -t mediaserver_tmpfs -c file -p read,write,execute -l
  $SEINJECT -s mediaserver -t system_file -c file -p execmod -l
  $SEINJECT -s audioserver -t unlabeled -c file -p read,write,execute,open,getattr -l
  $SEINJECT -s $SOURCE -t system_data_file -c file -p open -l
  $SEINJECT -s hal_audio_default -t hal_audio_default -c process -p execmem -l
  $SEINJECT -s hal_audio_default -t hal_audio_default_tmpfs -c file -p execmem -l
  $SEINJECT -s hal_audio_default -t audio_data_file -c dir -p search -l
fi
am start -a android.intent.action.MAIN -n com.vipercn.viper4android.xhifi/.main.ViPER4Android_XHiFi
killall com.vipercn.viper4android.xhifi
killall audioserver
killall mediaserver
