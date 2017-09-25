#!/usr/bin/env perl

my @array_pre_flag = ();

$ARGC = @ARGV;
if($ARGC gt 0){
    print qq{usage: perl aj.pl};
    exit;}

# 请将bash命令放于 " 符号间.
# 请注意双引号" 和 $ 符号的转义.
$pre_cmd{'id'} = "echo result";
$pre_cmd{1} = "cat /etc/default/login|grep 'PASSREQ=YES'";
$pre_cmd{2} = "cat /etc/passwd | grep -v  '^ *#' | grep -v '^\$'";
$pre_cmd{3} = "cat /etc/passwd | grep -v  '^ *#' | grep -v '^\$'；cat  /etc/shadow | grep -v  '^ *#' | grep -v '^\$'";
$pre_cmd{4} = "grep ^+: /etc/passwd;grep ^+: /etc/security/passwd ;grep ^+:/etc/group";
$pre_cmd{5} = "cat /etc/ssh/sshd_config | grep -v  '^ *#' | grep -v '^\$'";
$pre_cmd{6} = "cat /etc/default/security | grep -v  '^ *#' | grep -v '^\$'";
$pre_cmd{7} = "echo 口令定期更换";
$pre_cmd{8} = "echo 口令定期更换";
$pre_cmd{9} = "echo 口令定期更换";
$pre_cmd{10} = "cat  /etc/default/security | grep -v  '^ *#' | grep -v '^\$'; cat /etc/default/login  | grep -v  '^ *#' | grep -v '^\$'";
$pre_cmd{11} = "cat /etc/securetty | grep -v  '^ *#' | grep -v '^\$';cat /var/adm/syslog | grep -v  '^ *#' | grep -v '^\$';cat /var/adm/syslog/syslog | grep -v  '^ *#' | grep -v '^\$';cat /var/adm/messages | grep -v  '^ *#' | grep -v '^\$';last /var/adm/wtmp ";
$pre_cmd{12} = "ls -l /etc/passwd;ls -l /etc/shadow;ls -l /etc/group ";
$pre_cmd{13} = "cat  /etc/default/security | grep -v  '^ *#' | grep -v '^\$'";
$pre_cmd{14} = "cat /etc/syslog.conf| grep -v  '^ *#' | grep -v '^\$';cat /usr/spool/mqueue/syslog | grep -v  '^ *#' | grep -v '^\$'";
$pre_cmd{15} = "ls  -l  /var/adm";
$pre_cmd{17} = "echo 访谈系统管理员是否定期（至少3个月一次转储，并至少保存6个月）";
$pre_cmd{18} = "cat   /etc/syslog.conf | grep -v  '^ *#' | grep -v '^\$'";
$pre_cmd{19} = "ps -elf|grep telnet；ps -elf|grep ssh";
$pre_cmd{20} = "uname -a；show_patches|awk '{print $1}'";
$pre_cmd{21} = "Find / -name *.rhosts;Find / -name *.netrc";
$pre_cmd{22} = "cat  /var/adm/inetd.sec | grep -v  '^ *#' | grep -v '^\$'";
$pre_cmd{23} = "cat   /etc/profile | grep -v  '^ *#' | grep -v '^\$'";
$pre_cmd{24} = "ps –eaf";
$pre_cmd{25} = "ntp –v ip";
$pre_cmd{26} = "cat  /etc/resolv.conf |search ca.hp.com  hp.com nameserver | grep -v  '^ *#' | grep -v '^\$';cat /etc/hosts.deny  | grep -v  '^ *#' | grep -v '^\$'";
$pre_cmd{27} = "cat  /usr/sbin/kmtune | grep -v  '^ *#' | grep -v '^\$';cat /etc/hosts.deny  | grep -v  '^ *#' | grep -v '^\$'";


push(@array_pre_flag, 'id');
push(@array_pre_flag, 1);
push(@array_pre_flag, 2);
push(@array_pre_flag, 3);
push(@array_pre_flag, 4);
push(@array_pre_flag, 5);
push(@array_pre_flag, 6);
push(@array_pre_flag, 7);
push(@array_pre_flag, 8);
push(@array_pre_flag, 9);
push(@array_pre_flag, 10);
push(@array_pre_flag, 11);
push(@array_pre_flag, 12);
push(@array_pre_flag, 13);
push(@array_pre_flag, 14);
push(@array_pre_flag, 15);
push(@array_pre_flag, 16);
push(@array_pre_flag, 17);
push(@array_pre_flag, 18);
push(@array_pre_flag, 19);
push(@array_pre_flag, 20);
push(@array_pre_flag, 21);
push(@array_pre_flag, 22);
push(@array_pre_flag, 23);
push(@array_pre_flag, 24);
push(@array_pre_flag, 25);
push(@array_pre_flag, 26);
push(@array_pre_flag, 27);
#end

sub add_item{
    my ($string, $flag, $value)= @_;
    $result = `$value`;
    chomp $result;
    $string .= "\t".'<item flag="'.$flag.'">'."\n";
    if ( $result eq "result" ){
        $value = "command";
    }
    $string .= "\t\t<command><![CDATA[".$value."]]></command>\n";
    $string .= "\t\t<value><![CDATA[".$result."]]></value>\n";
    $string .= "\t</item>\n";
    return $string;
}
sub generate_xml{
    my $xml_string = "";
    $xml_string .='<?xml version="1.0" encoding="UTF-8"?>'."\n";
    $xml_string .='<?xml-stylesheet type="text/xsl" href="xml.xsl"?>'."\n";
    $xml_string .= '<result>'."\n";
    foreach $key (@array_pre_flag){
        $value = $pre_cmd{$key};
        $xml_string = &add_item( $xml_string, $key, $value );
    }
    $xml_string .= "</result>"."\n";
    $xmlfile = "result.xml";
    print "generate ".$xmlfile."\n";
    open XML,">./".$xmlfile or die "Cannot create xml file:$!";
    print XML $xml_string;
    print "Done\n";}
generate_xml();
