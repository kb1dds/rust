!	IMAGES.COM
!
!	Install standard SHAREplus system images
!
run sy:image				! run image utility
install/system	sy:image.sav		! IMAGE utility
install/system	sy:dcl.sys		! DCL interpreter
!install/system	sy:accoun.sav		! Accounting utility
!install/system	sy:batch.sav		! BATCH utility
install/system	sy:queue.sav		! Spooler utility
!install/system	sy:queuex.sav		! Spooler utility
install/system	sy:mount.sav		! MOUNT utility
install/log_io	sy:vir.sav		! DIRECTORY utility
install/log_io	sy:vip.sav		! COPY, etc
install/log_io	sy:srccom.sav		! DIFFERENCES
install/log_io	sy:bincom.sav		! DIFFERENCES/BINARY
!install/log_io	sy:erase.sav		! ERASE utility
!instal/log_io	sy:dump.sav		! DUMP utility
!install/system	sy:mcr.sav		! MCR - SHAREmcr only
exit					! exit image utility
                                                                                                                                                                                                                                     