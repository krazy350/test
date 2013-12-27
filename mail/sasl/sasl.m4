divert(-1)dnl
####################################################################
##### This file is automagically generated -- edit at your own risk
#####
##### Copyright (c) 2002-2009 Richard Nelson.  All Rights Reserved.
#####
##### file: /etc/mail/sasl/sasl.m4
#####		  AUTH Configuration for Debian Sendmail
##### generated via: (/usr/bin/perl v5>10.1)
#####		/usr/share/sendmail/update_authm4
#####		version: 8.14.3 2010-09-21 11:05:34 cowboy
##### by: root@localhost
##### on: Mon Jun 17 15:30:55 2013
##### in: /
##### input files: /etc/mail/databases
#####
##### Usage:
#####	1) To get *ANY* AUTH support for sendmail you
#####		A) *MUST* Add this line to /etc/mail/sendmail.mc 
#####		   `include(`/etc/mail/sasl/sasl.m4')dnl'
#####		B) *MAY* Add the same line to /etc/mail/submit.mc
#####		   to get MSP<->MTA authentication/encryption 
#####	2) You may modify the marked portions of this file.
#####	   If you need finer control of AUTH options, use the access
#####	   database.
#####
####################################################################
divert(0)dnl
VERSIONID(`$Id: sasl.m4,v 8.14.3-9.4 2010-09-21 11:05:34 cowboy Exp $')
dnl #
dnl #---------------------------------------------------------------------
dnl # Bring in Autoconf results
dnl #---------------------------------------------------------------------
ifdef(`sm_version', `dnl',
`include(`/usr/share/sendmail/cf/debian/autoconf.m4')dnl')
dnl #
dnl #---------------------------------------------------------------------
dnl # SMTP AUTH (SASL) support (sendmail 8.10.0 +)
dnl # PLAIN/LOGIN needed to support SASL auth via PAM ;(
dnl # if this bothers you, you allow them only in conjunction w/STARTTLS !
dnl #---------------------------------------------------------------------
ifelse(eval(sm_version_math >= 526848), `1', `dnl
ifelse(sm_enable_auth, `yes', `dnl
dnl #
dnl #             ...Do not touch anything above this line...
dnl #
dnl # Set a more reasonable timeout on negotiation
dnl #
define(`confTO_AUTH',     `2m')dnl   # <= EDIT
dnl #
dnl # Define the REALM passed to sasl (8.13.0+)
ifelse(eval(sm_version_math >= 527616), `1', `dnl
define(`confAUTH_REALM', `')dnl   # <= EDIT
')dnl
dnl #
dnl # Available Authentication methods
dnl #
define(`confAUTH_MECHANISMS',dnl
`DIGEST-MD5 CRAM-MD5 NTLM LOGIN PLAIN')dnl   # <= EDIT
dnl #
dnl # These, we will trust for relaying
dnl #
TRUST_AUTH_MECH(`DIGEST-MD5 CRAM-MD5 NTLM LOGIN PLAIN')dnl   # <= EDIT
dnl #
dnl #             ...Do not touch anything below this line...
dnl #
dnl #
dnl # for 8.12.0+, add EXTERNAL as an available & trusted mech (w/STARTTLS)
dnl # and allow sharing of /etc/sasldb(2) file, allow group read/write
dnl #
ifelse(eval(sm_version_math >= 527360), `1', `dnl
define(`confAUTH_MECHANISMS',dnl
`EXTERNAL 'defn(`confAUTH_MECHANISMS'))dnl
TRUST_AUTH_MECH(`EXTERNAL')
dnl #
dnl # To support some SASL use, we need the DB to be group readable
dnl #
define(`confDONT_BLAME_SENDMAIL',dnl
defn(`confDONT_BLAME_SENDMAIL')`,GroupReadableSASLDBFile,GroupWritableSASLDBFile')dnl
')dnl
dnl #
dnl # To support SMTP AUTH in `sendmail -bs' :
dnl # Sigh: SASLV1 MSP AUTH does not work in -bs mode (/etc/sasldb !o+r)
dnl # so, we have the MSP not use Auth (or ETRN)
dnl # SASLV2 (w/saslauth) chose to prohibit user authentication - it can
dnl # be made to work by:
dnl # 1) changing /etc/sasldb2 {root,sasl,smmta}:smmsp 0660
dnl # 2) dpkg-statoverride --remove /var/run/saslauthd
dnl # 3) dpkg-statoverride --add root sasl 711 /var/run/saslauthd
dnl #
ifelse(eval(sm_auth_lib < 2), `1', `dnl
ifdef(`DEBIAN_MSP', `dnl
ifelse(defn(`_DPO_'), `', `dnl
DAEMON_OPTIONS(`Name=NoMTA, Addr=0.0.0.0, M=EA')dnl
')')')dnl
dnl #
')')dnl
