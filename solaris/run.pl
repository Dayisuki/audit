#!/usr/bin/env perl

my @array_pre_flag = ();

$ARGC = @ARGV;
if($ARGC gt 0){
    print qq{usage: perl aj.pl};
    exit;}

# 请将bash命令放于 " 符号间.
# 请注意双引号" 和 $ 符号的转义.
$pre_cmd{'id'} = "echo result";
$pre_cmd{1} = "ps -elf|grep ssh";
$pre_cmd{2} = "cat /etc/passwd | grep -v  '^ *#' | grep -v '^\$'";
$pre_cmd{3} = "/usr/sbin/eeprom";
$pre_cmd{4} = "ls -l /etc/passwd; ls -l /etc/shadow;ls -l /etc/group";
$pre_cmd{5} = "cat /etc/passwd | grep -v  '^ *#' | grep -v '^\$';cat /etc/shadow  | grep -v  '^ *#' | grep -v '^\$'";
$pre_cmd{6} = "ls -l /etc/passwd;ls -l /etc/shadow; ls -l /etc/group ";
$pre_cmd{7} = "cat /etc/ssh/sshd_config | grep -v  '^ *#' | grep -v '^\$'";
$pre_cmd{8} = "cat  /etc/default/passwd | grep -v  '^ *#' | grep -v '^\$'";
$pre_cmd{9} = "cat /etc/default/passwd  | grep -v  '^ *#' | grep -v '^\$'";
$pre_cmd{10} = "cat /etc/security/policy.conf  | grep -v  '^ *#' | grep -v '^\$'; cat /etc/default/login  | grep -v  '^ *#' | grep -v '^\$'";
$pre_cmd{11} = "cat /etc/default/passwd  | grep -v  '^ *#' | grep -v '^\$'";
$pre_cmd{12} = "ls -l /etc/passwd;ls -l /etc/shadow;ls -l /etc/group";
$pre_cmd{13} = "cat /etc/default/login | grep -v  '^ *#' | grep -v '^\$';cat /etc/profile  | grep -v  '^ *#' | grep -v '^\$'";
$pre_cmd{14} = "cat /etc/syslog.conf | grep -v  '^ *#' | grep -v '^\$';last /var/adm/wtmpx";
$pre_cmd{15} = "cat /etc/default/su | grep -v  '^ *#' | grep -v '^\$'";
$pre_cmd{16} = "cat /etc/default/su | grep -v  '^ *#' | grep -v '^\$'";
$pre_cmd{17} = "more /etc/default/cron| grep -v  '^ *#' | grep -v '^\$'";
$pre_cmd{18} = "echo 审核的内容应包括日期时间、类型、主机和课题，分别查看各个已有的日志记录，如message、cron等";
$pre_cmd{19} = "ls –l /var/adm";
$pre_cmd{20} = "echo 访谈系统管理员是否定期（至少3个月一次转储，并至少保存6个月）";
$pre_cmd{21} = "cat /etc/syslog.conf  | grep -v  '^ *#' | grep -v '^\$'";
$pre_cmd{22} = "ps -elf|grep telnet ；ps -elf|grep ssh";
$pre_cmd{23} = "cat /etc/default/login | grep -v  '^ *#' | grep -v '^\$'";
$pre_cmd{24} = "echo 待定使用漏洞扫描器对Solaris系统进行扫描，记录是否存在未进行更新漏洞";
$pre_cmd{25} = "cat /etc/hosts.allow | grep -v  '^ *#' | grep -v '^\$';cat /etc/hosts.deny  | grep -v  '^ *#' | grep -v '^\$'";
$pre_cmd{26} = "cat   /etc/profile | grep -v  '^ *#' | grep -v '^\$';cat /etc/hosts.deny  | grep -v  '^ *#' | grep -v '^\$'";
$pre_cmd{27} = "ps -elf";
$pre_cmd{28} = "cat /etc/inet/ntp.conf | grep -v  '^ *#' | grep -v '^\$'";
$pre_cmd{29} = "cat /etc/resolv.conf | grep -v  '^ *#' | grep -v '^\$'";
$pre_cmd{30} = "cat /etc/system | grep -v  '^ **' | grep -v '^\$'";

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
push(@array_pre_flag, 28);
push(@array_pre_flag, 29);
push(@array_pre_flag, 30);
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
