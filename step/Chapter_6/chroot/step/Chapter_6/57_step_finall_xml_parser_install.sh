#!/bin/bash
#########
#########57 step. Final XML::Parser install.
#########
step_57_finall_xml_parser_install ()
{
#6.43. XML::Parser-2.43


XMLPARSER="XML-Parser-2.43"
XMLPARSER_SRC_FILE="$XMLPARSER.tar.gz"

if [ ! -f /sources/$XMLPARSER_SRC_FILE ]; then
   wget -O /sources/$XMLPARSER_SRC_FILE $REPOSITORY/$XMLPARSER_SRC_FILE
fi

cd /sources
tar zxf $XMLPARSER_SRC_FILE
cd $XMLPARSER
perl Makefile.PL
make -j$STREAM
if [ "$1" == "test" ] ; then
	make test
fi
make install
cd ..
rm -rf $XMLPARSER
}