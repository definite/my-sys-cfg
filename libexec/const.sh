### Definition of constants
## To source this script, via msc-env-find is recommended 
MSC_VERSION=3.0.0

### Log severity levels
###     Based on syslog(3) log levels
###     Lower value means higher severity
###     If invokes other subroutine, it is caller to determine severity.
###
###  MSC_SEVERITY_EMERG  0
###      system is unusable, application must stop immediately.
MSC_SEVERITY_EMERG=0
###
###  MSC_SEVERITY_ALERT  1
###      action must be taken immediately
MSC_SEVERITY_ALERT=1
###
###  MSC_SEVERITY_CRIT  2
###      critical conditions
MSC_SEVERITY_CRIT=2
###
###  MSC_SEVERITY_ERR  3
###      error conditions
MSC_SEVERITY_ERR=3
###
###  MSC_SEVERITY_WARNING  4
###      warning conditions
MSC_SEVERITY_WARNING=4
###
###  MSC_SEVERITY_INFO  5
###      informational messages
MSC_SEVERITY_INFO=5
###
###  MSC_SEVERITY_NOTICE  6
###      normal but significant condition
MSC_SEVERITY_NOTICE=6
###
###  MSC_SEVERITY_DEBUG  7
###      debug-level messages
MSC_SEVERITY_DEBUG=7 
###
###  MSC_SEVERITY_DEBUG1  8
###      a little bit more verbose debug messages
MSC_SEVERITY_DEBUG1=8
###
###  MSC_SEVERITY_DEBUG2  9
###      most verbose debug messages
MSC_SEVERITY_DEBUG2=9
###
###  MSC_SEVERITY_NONE  20 
###      no logging
MSC_SEVERITY_NONE=20

### Return codes
###     Simply the reason to return.
###
###     0: Success
###     1-299: Standard POSIX error codes
###     300-499: Protocol MSC ID
###     500-799: Application MSC ID
###     800-899: Reserved for future use
###     900-999: MSC status codes 
###     1000+:  User defined status codes
### 
###  MSC_RETURN_OK  0
###      Run successfully
MSC_RETURN_OK=0
##{{{ errno status
###
###  MSC_RETURN_EPERM  1
###      Operation not permitted
MSC_RETURN_EPERM=1
###
###  MSC_RETURN_ENOENT  2
###      No such file or directory
MSC_RETURN_ENOENT=2
###
###  MSC_RETURN_ESRCH  3
###      No such process
MSC_RETURN_ESRCH=3
###
###  MSC_RETURN_EINTR  4
###      Interrupted system call
MSC_RETURN_EINTR=4
###
###  MSC_RETURN_EIO  5
###      Input/output error
MSC_RETURN_EIO=5
###
###  MSC_RETURN_ENXIO  6
###      No such device or address
MSC_RETURN_ENXIO=6
###
###  MSC_RETURN_E2BIG(7)
###      Argument list too long
MSC_RETURN_E2BIG=7
###
###  MSC_RETURN_ENOEXEC  8
###      Exec format error
MSC_RETURN_ENOEXEC=8
###
###  MSC_RETURN_EBADF  9
###      Bad file descriptor
MSC_RETURN_EBADF=9
###
###  MSC_RETURN_ECHILD  10
###      No child processes
MSC_RETURN_ECHILD=10
###
###  MSC_RETURN_EAGAIN  11
###      Resource temporarily unavailable
MSC_RETURN_EAGAIN=11
###
###  MSC_RETURN_ENOMEM  12
###      Cannot allocate memory
MSC_RETURN_ENOMEM=12
###
###  MSC_RETURN_EACCES  13
###      Permission denied
MSC_RETURN_EACCES=13
###
###  MSC_RETURN_EFAULT  14
###      Bad address
MSC_RETURN_EFAULT=14
###
###  MSC_RETURN_ENOTBLK  15
###      Block device required
MSC_RETURN_ENOTBLK=15
###
###  MSC_RETURN_EBUSY  16
###      Device or resource busy
MSC_RETURN_EBUSY=16
###
###  MSC_RETURN_EEXIST  17
###      File exists
MSC_RETURN_EEXIST=17
###
###  MSC_RETURN_EXDEV  18
###      Invalid cross-device link
MSC_RETURN_EXDEV=18
###
###  MSC_RETURN_ENODEV  19
###      No such device
MSC_RETURN_ENODEV=19
###
###  MSC_RETURN_ENOTDIR  20
###      Not a directory
MSC_RETURN_ENOTDIR=20
###
###  MSC_RETURN_EISDIR  21
###      Is a directory
MSC_RETURN_EISDIR=21
###
###  MSC_RETURN_EINVAL  22
###      Invalid argument
MSC_RETURN_EINVAL=22
###
###  MSC_RETURN_ENFILE  23
###      Too many open files in system
MSC_RETURN_ENFILE=23
###
###  MSC_RETURN_EMFILE  24
###      Too many open files
MSC_RETURN_EMFILE=24
###
###  MSC_RETURN_ENOTTY  25
###      Inappropriate ioctl for device
MSC_RETURN_ENOTTY=25
###
###  MSC_RETURN_ETXTBSY  26
###      Text file busy
MSC_RETURN_ETXTBSY=26
###
###  MSC_RETURN_EFBIG  27
###      File too large
MSC_RETURN_EFBIG=27
###
###  MSC_RETURN_ENOSPC  28
###      No space left on device
MSC_RETURN_ENOSPC=28
###
###  MSC_RETURN_ESPIPE  29
###      Illegal seek
MSC_RETURN_ESPIPE=29
###
###  MSC_RETURN_EROFS  30
###      Read-only file system
MSC_RETURN_EROFS=30
###
###  MSC_RETURN_EMLINK  31
###      Too many links
MSC_RETURN_EMLINK=31
###
###  MSC_RETURN_EPIPE  32
###      Broken pipe
MSC_RETURN_EPIPE=32
###
###  MSC_RETURN_EDOM  33
###      Numerical argument out of domain
MSC_RETURN_EDOM=33
###
###  MSC_RETURN_ERANGE  34
###      Numerical result out of range
MSC_RETURN_ERANGE=34
###
###  MSC_RETURN_EDEADLK  35
###      Resource deadlock avoided
MSC_RETURN_EDEADLK=35
###
###  MSC_RETURN_ENAMETOOLONG  36
###      File name too long
MSC_RETURN_ENAMETOOLONG=36
###
###  MSC_RETURN_ENOLCK  37
###      No locks available
MSC_RETURN_ENOLCK=37
###
###  MSC_RETURN_ENOSYS  38
###      Function not implemented
MSC_RETURN_ENOSYS=38
###
###  MSC_RETURN_ENOTEMPTY  39
###      Directory not empty
MSC_RETURN_ENOTEMPTY=39
###
###  MSC_RETURN_ELOOP  40
###      Too many levels of symbolic links
MSC_RETURN_ELOOP=40
###
###  MSC_RETURN_EWOULDBLOCK  11
###      Resource temporarily unavailable
MSC_RETURN_EWOULDBLOCK=11
###
###  MSC_RETURN_ENOMSG  42
###      No message of desired type
MSC_RETURN_ENOMSG=42
###
###  MSC_RETURN_EIDRM  43
###      Identifier removed
MSC_RETURN_EIDRM=43
###  MSC_RETURN_ECHRNG  44
###      Channel number out of range
MSC_RETURN_ECHRNG=44
###
###  MSC_RETURN_EL2NSYNC(45)
###      Level 2 not synchronized
MSC_RETURN_EL2NSYNC=45
###
###  MSC_RETURN_EL3HLT(46)
###      Level 3 halted
MSC_RETURN_EL3HLT=46
###
###  MSC_RETURN_EL3RST(47)
###      Level 3 reset
MSC_RETURN_EL3RST=47
###
###  MSC_RETURN_ELNRNG  48
###      Link number out of range
MSC_RETURN_ELNRNG=48
###
###  MSC_RETURN_EUNATCH  49
###      Protocol driver not attached
MSC_RETURN_EUNATCH=49
###
###  MSC_RETURN_ENOCSI  50
###      No CSI structure available
MSC_RETURN_ENOCSI=50
###
###  MSC_RETURN_EL2HLT(51)
###      Level 2 halted
MSC_RETURN_EL2HLT=51
###
###  MSC_RETURN_EBADE  52
###      Invalid exchange
MSC_RETURN_EBADE=52
###
###  MSC_RETURN_EBADR  53
###      Invalid request descriptor
MSC_RETURN_EBADR=53
###
###  MSC_RETURN_EXFULL  54
###      Exchange full
MSC_RETURN_EXFULL=54
###
###  MSC_RETURN_ENOANO  55
###      No anode
MSC_RETURN_ENOANO=55
###
###  MSC_RETURN_EBADRQC  56
###      Invalid request code
MSC_RETURN_EBADRQC=56
###
###  MSC_RETURN_EBADSLT  57
###      Invalid slot
MSC_RETURN_EBADSLT=57
###
###  MSC_RETURN_EDEADLOCK  35
###      Resource deadlock avoided
MSC_RETURN_EDEADLOCK=35
###
###  MSC_RETURN_EBFONT  59
###      Bad font file format
MSC_RETURN_EBFONT=59
###
###  MSC_RETURN_ENOSTR  60
###      Device not a stream
MSC_RETURN_ENOSTR=60
###
###  MSC_RETURN_ENODATA  61
###      No data available
MSC_RETURN_ENODATA=61
###
###  MSC_RETURN_ETIME  62
###      Timer expired
MSC_RETURN_ETIME=62
###
###  MSC_RETURN_ENOSR  63
###      Out of streams resources
MSC_RETURN_ENOSR=63
###
###  MSC_RETURN_ENONET  64
###      Machine is not on the network
MSC_RETURN_ENONET=64
###
###  MSC_RETURN_ENOPKG  65
###      Package not installed
MSC_RETURN_ENOPKG=65
###
###  MSC_RETURN_EREMOTE  66
###      Object is remote
MSC_RETURN_EREMOTE=66
###
###  MSC_RETURN_ENOLINK  67
###      Link has been severed
MSC_RETURN_ENOLINK=67
###
###  MSC_RETURN_EADV  68
###      Advertise error
MSC_RETURN_EADV=68
###
###  MSC_RETURN_ESRMNT  69
###      Srmount error
MSC_RETURN_ESRMNT=69
###
###  MSC_RETURN_ECOMM  70
###      Communication error on send
MSC_RETURN_ECOMM=70
###
###  MSC_RETURN_EPROTO  71
###      Protocol error
MSC_RETURN_EPROTO=71
###
###  MSC_RETURN_EMULTIHOP  72
###      Multihop attempted
MSC_RETURN_EMULTIHOP=72
###
###  MSC_RETURN_EDOTDOT  73
###      RFS specific error
MSC_RETURN_EDOTDOT=73
###
###  MSC_RETURN_EBADMSG  74
###      Bad message
MSC_RETURN_EBADMSG=74
###
###  MSC_RETURN_EOVERFLOW  75
###      Value too large for defined data type
MSC_RETURN_EOVERFLOW=75
###
###  MSC_RETURN_ENOTUNIQ  76
###      Name not unique on network
MSC_RETURN_ENOTUNIQ=76
###
###  MSC_RETURN_EBADFD  77
###      File descriptor in bad state
MSC_RETURN_EBADFD=77
###
###  MSC_RETURN_EREMCHG  78
###      Remote address changed
MSC_RETURN_EREMCHG=78
###
###  MSC_RETURN_ELIBACC  79
###      Can not access a needed shared library
MSC_RETURN_ELIBACC=79
###
###  MSC_RETURN_ELIBBAD  80
###      Accessing a corrupted shared library
MSC_RETURN_ELIBBAD=80
###
###  MSC_RETURN_ELIBSCN  81
###      .lib section in a.out corrupted
MSC_RETURN_ELIBSCN=81
###
###  MSC_RETURN_ELIBMAX  82
###      Attempting to link in too many shared libraries
MSC_RETURN_ELIBMAX=82
###
###  MSC_RETURN_ELIBEXEC  83
###      Cannot exec a shared library directly
MSC_RETURN_ELIBEXEC=83
###
###  MSC_RETURN_EILSEQ  84
###      Invalid or incomplete multibyte or wide character
MSC_RETURN_EILSEQ=84
###
###  MSC_RETURN_ERESTART  85
###      Interrupted system call should be restarted
MSC_RETURN_ERESTART=85
###
###  MSC_RETURN_ESTRPIPE  86
###      Streams pipe error
MSC_RETURN_ESTRPIPE=86
###
###  MSC_RETURN_EUSERS  87
###      Too many users
MSC_RETURN_EUSERS=87
###
###  MSC_RETURN_ENOTSOCK  88
###      Socket operation on non-socket
MSC_RETURN_ENOTSOCK=88
###
###  MSC_RETURN_EDESTADDRREQ  89
###      Destination address required
MSC_RETURN_EDESTADDRREQ=89
###
###  MSC_RETURN_EMSGSIZE  90
###      Message too long
MSC_RETURN_EMSGSIZE=90
###
###  MSC_RETURN_EPROTOTYPE  91
###      Protocol wrong type for socket
MSC_RETURN_EPROTOTYPE=91
###
###  MSC_RETURN_ENOPROTOOPT  92
###      Protocol not available
MSC_RETURN_ENOPROTOOPT=92
###
###  MSC_RETURN_EPROTONOSUPPORT  93
###      Protocol not supported
MSC_RETURN_EPROTONOSUPPORT=93
###
###  MSC_RETURN_ESOCKTNOSUPPORT  94
###      Socket type not supported
MSC_RETURN_ESOCKTNOSUPPORT=94
###
###  MSC_RETURN_EOPNOTSUPP  95
###      Operation not supported
MSC_RETURN_EOPNOTSUPP=95
###
###  MSC_RETURN_EPFNOSUPPORT  96
###      Protocol family not supported
MSC_RETURN_EPFNOSUPPORT=96
###
###  MSC_RETURN_EAFNOSUPPORT  97
###      Address family not supported by protocol
MSC_RETURN_EAFNOSUPPORT=97
###
###  MSC_RETURN_EADDRINUSE  98
###      Address already in use
MSC_RETURN_EADDRINUSE=98
###
###  MSC_RETURN_EADDRNOTAVAIL  99
###      Cannot assign requested address
MSC_RETURN_EADDRNOTAVAIL=99
###
###  MSC_RETURN_ENETDOWN  100
###      Network is down
MSC_RETURN_ENETDOWN=100
###
###  MSC_RETURN_ENETUNREACH  101
###      Network is unreachable
MSC_RETURN_ENETUNREACH=101
###
###  MSC_RETURN_ENETRESET  102
###      Network dropped connection on reset
MSC_RETURN_ENETRESET=102
###
###  MSC_RETURN_ECONNABORTED  103
###      Software caused connection abort
MSC_RETURN_ECONNABORTED=103
###
###  MSC_RETURN_ECONNRESET  104
###      Connection reset by peer
MSC_RETURN_ECONNRESET=104
###
###  MSC_RETURN_ENOBUFS  105
###      No buffer space available
MSC_RETURN_ENOBUFS=105
###
###  MSC_RETURN_EISCONN  106
###      Transport endpoint is already connected
MSC_RETURN_EISCONN=106
###
###  MSC_RETURN_ENOTCONN  107
###      Transport endpoint is not connected
MSC_RETURN_ENOTCONN=107
###
###  MSC_RETURN_ESHUTDOWN  108
###      Cannot send after transport endpoint shutdown
MSC_RETURN_ESHUTDOWN=108
###
###  MSC_RETURN_ETOOMANYREFS  109
###      Too many references: cannot splice
MSC_RETURN_ETOOMANYREFS=109
###
###  MSC_RETURN_ETIMEDOUT  110
###      Connection timed out
MSC_RETURN_ETIMEDOUT=110
###
###  MSC_RETURN_ECONNREFUSED  111
###      Connection refused
MSC_RETURN_ECONNREFUSED=111
###
###  MSC_RETURN_EHOSTDOWN  112
###      Host is down
MSC_RETURN_EHOSTDOWN=112
###
###  MSC_RETURN_EHOSTUNREACH  113
###      No route to host
MSC_RETURN_EHOSTUNREACH=113
###
###  MSC_RETURN_EALREADY  114
###      Operation already in progress
MSC_RETURN_EALREADY=114
###
###  MSC_RETURN_EINPROGRESS  115
###      Operation now in progress
MSC_RETURN_EINPROGRESS=115
###
###  MSC_RETURN_ESTALE  116
###      Stale file handle
MSC_RETURN_ESTALE=116
###
###  MSC_RETURN_EUCLEAN  117
###      Structure needs cleaning
MSC_RETURN_EUCLEAN=117
###
###  MSC_RETURN_ENOTNAM  118
###      Not a XENIX named type file
MSC_RETURN_ENOTNAM=118
###
###  MSC_RETURN_ENAVAIL  119
###      No XENIX semaphores available
MSC_RETURN_ENAVAIL=119
###
###  MSC_RETURN_EISNAM  120
###      Is a named type file
MSC_RETURN_EISNAM=120
###
###  MSC_RETURN_EREMOTEIO  121
###      Remote I/O error
MSC_RETURN_EREMOTEIO=121
###
###  MSC_RETURN_EDQUOT  122
###      Disk quota exceeded
MSC_RETURN_EDQUOT=122

###
###  MSC_RETURN_ENOMEDIUM  123
###      No medium found
MSC_RETURN_ENOMEDIUM=123

###
###  MSC_RETURN_EMEDIUMTYPE  124
###      Wrong medium type
MSC_RETURN_EMEDIUMTYPE=124
###
###  MSC_RETURN_ECANCELED  125
###      Operation canceled
MSC_RETURN_ECANCELED=125
###
###  MSC_RETURN_ENOKEY  126
###      Required key not available
MSC_RETURN_ENOKEY=126
###
###  MSC_RETURN_EKEYEXPIRED  127
###      Key has expired
MSC_RETURN_EKEYEXPIRED=127
###
###  MSC_RETURN_EKEYREVOKED  128
###      Key has been revoked
MSC_RETURN_EKEYREVOKED=128
###
###  MSC_RETURN_EKEYREJECTED  129
###      Key was rejected by service
MSC_RETURN_EKEYREJECTED=129
###
###  MSC_RETURN_EOWNERDEAD  130
###      Owner died
MSC_RETURN_EOWNERDEAD=130
###
###  MSC_RETURN_ENOTRECOVERABLE  131
###      State not recoverable
MSC_RETURN_ENOTRECOVERABLE=131
###
###  MSC_RETURN_ERFKILL  132
###      Operation not possible due to RF-kill
MSC_RETURN_ERFKILL=132
###
###  MSC_RETURN_EHWPOISON  133
###      Memory page has hardware error
MSC_RETURN_EHWPOISON=133
##}}} errno status
##{{{ Protocol MSC ID
###
###  MSC_RETURN_PROTO_HTTP  300
###      HTTP Protocol related
MSC_RETURN_PROTO_HTTP=300
###
###  MSC_RETURN_PROTO_KRB_LIB  301
###      Kerberos Library status code
MSC_RETURN_PROTO_KRB=301
###
###  MSC_RETURN_PROTO_LDAP  310
###      LDAP Protocol related
MSC_RETURN_PROTO_LDAP=310
##}}} Protocol MSC ID
##{{{ MSC status codes
###
###  MSC_RETURN_UNCHANGED  900
###      No change is done
MSC_RETURN_UNCHANGED=900
###
###  MSC_RETURN_FALSE  901
###      return value is false
MSC_RETURN_FALSE=901
###
###  MSC_RETURN_UNKNOWN  999
###      Unknown reason
MSC_RETURN_UNKNOWN=999
###}}} MSC return codes


declare -A MscExitMessageDict
### Exit Status (deprecated, use MSC_RETURN_* instead)
###     MSC_EXIT_OK(0)
###     Run successfully
export MSC_EXIT_OK=0
MscExitMessageDict[$MSC_EXIT_OK]="Done"

###
###     MSC_EXIT_RETURN_UNCHANGED(1)
###      Indicate that no change is done.
###      e.g. A recod to be created already exists, no need to change.
export MSC_EXIT_RETURN_UNCHANGED=1
MscExitMessageDict[$MSC_EXIT_RETURN_UNCHANGED]="Unchanged"
###
###     MSC_EXIT_RETURN_FALSE(2)
###      Nothing wrong, just a return value that means false.
###      Such as query whether a record exists.
export MSC_EXIT_RETURN_FALSE=2
MscExitMessageDict[$MSC_EXIT_RETURN_FALSE]="Return false"
###
###     MSC_EXIT_RETURN(30)
###      Nothing wrong, just need to return from execution.
export MSC_EXIT_RETURN=30
MscExitMessageDict[$MSC_EXIT_RETURN]="Generic Return"
###
###     MSC_EXIT_WARNING(60)
###      Something should be fixed, but can continue running
export MSC_EXIT_WARNING=60
MscExitMessageDict[$MSC_EXIT_WARNING]="Generic Warning"
###
###     MSC_EXIT_ERR(90)
###      Something wrong, thus program will fail eventurally.
export MSC_EXIT_ERR=90
MscExitMessageDict[$MSC_EXIT_ERR]="Generic Error"
###
###     MSC_EXIT_CRIT_ARGUMENTS_INVALID(91)
###      Invalid argument or option
export MSC_EXIT_CRIT_ARGUMENTS_INVALID=91
MscExitMessageDict[$MSC_EXIT_CRIT_ARGUMENTS_INVALID]="Arguments Invalid"
###
###     MSC_EXIT_CRIT_DEPENDENCIES_MISSING(92)
###      Dependencies missing, such as programs are not installed.
export MSC_EXIT_CRIT_DEPENDENCIES_MISSING=92
MscExitMessageDict[$MSC_EXIT_CRIT_DEPENDENCIES_MISSING]="Dependencies Missing"
###
###     MSC_EXIT_CRIT_DEVICE_MISSING(93)
###      Device missing, such as NIC missing.
export MSC_EXIT_CRIT_DEVICE_MISSING=93
MscExitMessageDict[$MSC_EXIT_CRIT_DEVICE_MISSING]="Device Missing"
###
###     MSC_EXIT_CRIT(120)
###      Generic Critical Error that must stop immediately
export MSC_EXIT_CRIT=120
MscExitMessageDict[$MSC_EXIT_CRIT]="Generic Critical"
export MscExitMessageDict

###
### Environment
###     MSC_LOG_LEVEL_DICT
###      Define log levels
###      It is based on loglevel from syslog(3)
declare -A MSC_LOG_LEVEL_DICT
###
###      none:
###          Initial level of outcome.
MSC_LOG_LEVEL_DICT['pending']=$MSC_SEVERITY_NONE
###
###      debug2:
###          A little bit more verbose debug messages
MSC_LOG_LEVEL_DICT['debug2']=$MSC_SEVERITY_DEBUG2
###
###      debug1:
###          A little bit more verbose debug messages
MSC_LOG_LEVEL_DICT['debug1']=$MSC_SEVERITY_DEBUG1
###
###      debug:
###          Only useful when debugging
MSC_LOG_LEVEL_DICT['debug']=$MSC_SEVERITY_DEBUG
###
###      info:
###          User may be interested.
MSC_LOG_LEVEL_DICT['info']=$MSC_SEVERITY_INFO
###
###      notice:
###          User needs to see.
MSC_LOG_LEVEL_DICT['notice']=$MSC_SEVERITY_NOTICE
###
###      warning:
###          The program may still return OK, but user need to be warned.
MSC_LOG_LEVEL_DICT['warning']=$MSC_SEVERITY_WARNING
###
###      err:
###          Error that is not severe to stop the program.
###          From this level, error messages need to be shown.
MSC_LOG_LEVEL_DICT['err']=$MSC_SEVERITY_ERR
###
###      crit:
###          The program should stop and return error immediately.
MSC_LOG_LEVEL_DICT['crit']=$MSC_SEVERITY_CRIT
MSC_LOG_LEVEL_DICT['alert']=$MSC_SEVERITY_ALERT
MSC_LOG_LEVEL_DICT['emerg']=$MSC_SEVERITY_EMERG
export MSC_LOG_LEVEL_DICT