#!/bin/sh
tlmgr option repository https://mirrors.tuna.tsinghua.edu.cn/CTAN/systems/texlive/tlnet
if [ ! -e 'update-tlmgr-latest.sh' ]; then
    wget https://mirrors.tuna.tsinghua.edu.cn/CTAN/systems/texlive/tlnet/update-tlmgr-latest.sh
    chmod +x update-tlmgr-latest.sh
fi
./update-tlmgr-latest.sh

su $HOSTUSER -s /bin/sh -c "tlmgr init-usertree;  
kpsewhich titlesec.sty || tlmgr install --usermode titlesec; 
kpsewhich enumitem.sty || tlmgr install --usermode enumitem; 
kpsewhich fontawesome.sty || tlmgr install --usermode fontawesome; 
kpsewhich xifthen.sty || tlmgr install --usermode xifthen; 
kpsewhich nth.sty || tlmgr install --usermode nth; 
kpsewhich xltxtra.sty || tlmgr install --usermode xltxtra; 
id"

arr="$@"
echo "$arr"
su -s /bin/sh $HOSTUSER -c "$arr"
