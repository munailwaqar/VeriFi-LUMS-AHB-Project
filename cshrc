# Note: This cshrc is for client

setenv LM_LICENSE_FILE 5280@cadenceserver
setenv CDS_LIC_FILE $LM_LICENSE_FILE

setenv CDC_INST_DIR /mnt/cadence_tools/installs

echo "*************************************"
echo "Welcome to Cadence Tools Suite"
echo "*************************************"
echo "Following tools are available:"

############################################
#####		GENUS		       #####
############################################
setenv GENUSHOME $CDC_INST_DIR/GENUS211
set path = ($GENUSHOME/bin $GENUSHOME/share/bin $GENUSHOME/tools.lnx86/dfII/bin $path)
echo $GENUSHOME

############################################
#####		XCELIUM		       #####
############################################
setenv XLCHOME $CDC_INST_DIR/XCELIUM2203
set path = ($XLCHOME/tools.lnx86/xcelium/bin $XLCHOME/tools/bin $XLCHOME/bin $XLCHOME/tools.lnx86/bin $XLCHOME/tools.lnx86/dfII/bin $path)
echo $XLCHOME

############################################
#####		CONFORMAL	       #####
############################################
setenv LECHOME $CDC_INST_DIR/CONFRML221
set path = ($LECHOME/bin $LECHOME/tools.ln86/bin $LECHOME/share/bin $path)
echo $LECHOME

############################################
#####		JASPER		       #####
############################################
setenv JASP $CDC_INST_DIR/JASPER22/jasper_2022.06
set path = ($JASP/bin $JASP/tools.lnx86/bin $JASP/tools $path)
echo $JASP

############################################
#####		VMANAGER	       #####
############################################
setenv VMGR $CDC_INST_DIR/VMANAGER2109
set path = ($path $VMGR/bin $VMGR/tools/vmgr/admin $path)
echo $VMGR

############################################
#####		LICENSE MANAGER	       #####
############################################
setenv LCU $CDC_INST_DIR/LCU43_Hotfix
set path = ($path $LCU/bin $LCU/share/bin $LCU/tools.lnx86/bin $LCU/tools.lnx86/dfII/bin $path)
echo $LCU

############################################
#####		INNOVUS		       #####
############################################
setenv INNOVUS $CDC_INST_DIR/INNOVUS211
setenv LD_LIBRARY_PATH /lib/lib64:/usr/lib64:$INNOVUS/tools/lib64
setenv OA_HOME $INNOVUS/oa_v22.60.076
set path = ($path $INNOVUS/bin $INNOVUS/tools/bin $INNOVUS/share/bin $INNOVUS/tools.lnx86/bin $INNOVUS/tools.lnx86/dfII/bin $OA_HOME/bin $path)
echo $INNOVUS





###########################################
#####	    SPECTRE201	       #####
############################################
##setenv SPECTRE201 $CDC_INST_DIR/SPECTRE201
##setenv OA_HOME $SPECTRE201/oa_v22.60.038
##set path = ($path $SPECTRE201/bin $SPECTRE201/tools/bin $SPECTRE201/share/bin $SPECTRE201/tools.lnx86/bin $SPECTRE201/tools.lnx86/dfII/bin $OA_HOME/bin $path)
#set path = ($SPECTRE201/bin $SPECTRE201/tools.lnx86/bin $SPECTRE201/tools $path)
##echo $SPECTRE201

setenv SPECTRE_HOME $CDC_INST_DIR/SPECTRE201
setenv PATH {$PATH}:${SPECTRE_HOME}/bin:${SPECTRE_HOME}/share/bin:${SPECTRE_HOME}/tools.lnx86/bin





############################################
#####		Virtuoso	       #####
############################################
setenv CDS $CDC_INST_DIR/IC231
setenv CDSDIR ${CDS}
setenv CDSHOME ${CDS}
setenv CADENCE_DIR ${CDS}
setenv CDS_INST_DIR ${CDS}
setenv CDS_ROOT ${CDS}
setenv CDSROOT ${CDS}
echo $CDS
setenv PATH ${PATH}:${CDSDIR}/tools/dfII/bin:${CDSDIR}/tools/plot/bin
setenv OA_HOME $CDSDIR/oa_v22.61.007
##set path = ($path $IC/bin $IC/tools/bin $IC/share/bin $IC/tools.lnx86/bin $IC/tools.lnx86/dfII/bin $OA_HOME/bin $path)
##echo $IC




############################################
#####		Assura  	       #####
############################################


setenv ASSURAHOME $CDC_INST_DIR/ASSURA41
setenv PATH ${PATH}:${ASSURAHOME}/tools/bin:${ASSURAHOME}/tools/assura/bin
echo $ASSURAHOME



