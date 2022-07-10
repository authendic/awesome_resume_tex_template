#!/bin/sh
[ -e '/.dockerenv' ] || exit -1
[ -n "$HOSTUSER" ] || export HOSTUSER=root

tlmgr option repository https://mirrors.tuna.tsinghua.edu.cn/CTAN/systems/texlive/tlnet
if [ ! -e 'update-tlmgr-latest.sh' ]; then
    wget https://mirrors.tuna.tsinghua.edu.cn/CTAN/systems/texlive/tlnet/update-tlmgr-latest.sh
    chown $HOSTUSER update-tlmgr-latest.sh
    chmod +x update-tlmgr-latest.sh
fi
./update-tlmgr-latest.sh

install_ctex(){
# 官网的包竟然是源码，没有编译后的包,无法使用
[ -e ctex-v2.5.9.zip ] || curl -sSL https://github.com/CTeX-org/ctex-kit/releases/download/ctex-v2.5.9/ctex-v2.5.9.zip -o ctex-v2.5.9.zip && chown $HOSTUSER ctex-v2.5.9.zip
[ -e xecjk-v3.8.9.zip ] || curl -sSL https://github.com/CTeX-org/ctex-kit/releases/download/xeCJK-v3.8.9/xecjk-v3.8.9.zip -o xecjk-v3.8.9.zip && chown $HOSTUSER xecjk-v3.8.9.zip

mkdir -p /tmp/ctex /tmp/xecjk
texmf_dist=`kpsewhich -var-value=TEXMFDIST`
unzip ctex-v2.5.9.zip  -d /tmp/ctex && unzip /tmp/ctex/ctex.tds.zip -d $texmf_dist
unzip xecjk-v3.8.9.zip -d /tmp/xecjk && unzip /tmp/xecjk/xecjk.tds.zip -d $texmf_dist

texhash
kpsewhich ctexart.cls || exit -1
}

su $HOSTUSER -s /bin/sh -c "tlmgr init-usertree;  
kpsewhich titlesec.sty || tlmgr install --usermode titlesec; 
kpsewhich enumitem.sty || tlmgr install --usermode enumitem; 
kpsewhich fontawesome.sty || tlmgr install --usermode fontawesome; 
kpsewhich xifthen.sty || tlmgr install --usermode xifthen; 
kpsewhich nth.sty || tlmgr install --usermode nth; 
kpsewhich xltxtra.sty || tlmgr install --usermode xltxtra; 
kpsewhich realscripts.sty || tlmgr install --usermode realscripts; 
kpsewhich metalogo.sty || tlmgr install --usermode metalogo; 
kpsewhich ctexart.cls || tlmgr install --usermode ctex; 
kpsewhich xeCJK.sty || tlmgr install --usermode xecjk; 
kpsewhich zhnumber.sty || tlmgr install --usermode zhnumber; 
kpsewhich FandolSong-Regular.otf || tlmgr install --usermode fandol; 
kpsewhich -all expl3.sty|grep home|xargs sed -i 's/2022-/2021-/g';
id"

arr="$@"
echo "$arr"
su -s /bin/sh $HOSTUSER -c "$arr"
