if ! $MAGISK || $SYSOVER; then
  for OFILE in ${CFGS}; do
    FILE="$UNITY$(echo $OFILE | sed "s|^/vendor|/system/vendor|g")"
    case $FILE in
      *.conf) sed -i "/v4a_standard_xhifi { #$MODID/,/} #$MODID/d" $FILE
              sed -i "/v4a_xhifi { #$MODID/,/} #$MODID/d" $FILE;;
      *.xml) sed -i "/<!--$MODID-->/d" $FILE;;
    esac
  done
fi
