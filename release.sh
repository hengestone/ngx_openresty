NAME=openresty
PPA=ppa:conrad-steenberg/ngx-openresty
RELEASES="trusty wily"

VERSION=`head -1 debian/changelog | grep -o '\((.*\))' | sed 's/[\(\)]*//g' | head -1`
ORIG_RELEASE=`head -1 debian/changelog | sed 's/.*) \(.*\);.*/\1/'`
for RELEASE in $RELEASES ;
do
  cp debian/changelog debian/changelog.backup
  sed -i "s/${ORIG_RELEASE}/${RELEASE}/g" debian/changelog
  NEWVERSION=`head -1 debian/changelog | grep -o '\((.*\))' | sed 's/[\(\)]*//g' | head -1`
  debuild -S
  dput -f ${PPA} ../${NAME}_${NEWVERSION}_source.changes
  mv debian/changelog.backup debian/changelog
done

