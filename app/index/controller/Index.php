<?php

// +----------------------------------------------------------------------
// | Static Plugin for ThinkAdmin
// +----------------------------------------------------------------------
// | 版权所有 2014~2023 ThinkAdmin [ thinkadmin.top ]
// +----------------------------------------------------------------------
// | 官方网站: https://thinkadmin.top
// +----------------------------------------------------------------------
// | 开源协议 ( https://mit-license.org )
// | 免责声明 ( https://thinkadmin.top/disclaimer )
// +----------------------------------------------------------------------
// | gitee 代码仓库：https://gitee.com/zoujingli/think-plugs-static
// | github 代码仓库：https://github.com/zoujingli/think-plugs-static
// +----------------------------------------------------------------------

namespace app\index\controller;

use think\admin\Controller;


class GetMac{
    var $result   = array(); 
    var $macAddrs = array(); //所有mac地址
    var $macAddr;            //第一个mac地址
 
    function __construct($OS){
        $this->GetMac($OS);
    }
 
    function GetMac($OS){
        switch ( strtolower($OS) ){
        	case "unix": break;
        	case "solaris": break;
        	case "aix": break;
        	case "linux":
        	    $this->getLinux();
        	    break;
        	default: 
        	    $this->getWindows();
        	    break;
        }
        $tem = array();
        foreach($this->result as $val){
            if(preg_match("/[0-9a-f][0-9a-f][:-]"."[0-9a-f][0-9a-f][:-]"."[0-9a-f][0-9a-f][:-]"."[0-9a-f][0-9a-f][:-]"."[0-9a-f][0-9a-f][:-]"."[0-9a-f][0-9a-f]/i",$val,$tem) ){
                $this->macAddr = $tem[0];//多个网卡时，会返回第一个网卡的mac地址，一般够用。
                break;
                //$this->macAddrs[] = $temp_array[0];//返回所有的mac地址
            }
        }
        unset($temp_array);
        return $this->macAddr;
    }
    //Linux系统
    function getLinux(){
        @exec("ifconfig -a", $this->result);
        return $this->result;
    }
    //Windows系统
    function getWindows(){
        @exec("ipconfig /all", $this->result);
        if ( $this->result ) {
            return $this->result;
        } else {
            $ipconfig = $_SERVER["WINDIR"]."\system32\ipconfig.exe";
            if(is_file($ipconfig)) {
                @exec($ipconfig." /all", $this->result);
            } else {
                @exec($_SERVER["WINDIR"]."\system\ipconfig.exe /all", $this->result);
                return $this->result;
            }
        }
    }
}

class Index extends Controller
{
    public function index()
    {
        $this->redirect(sysuri('admin/login/index'));
    }
    
    
    
    public function getMac()
    {
        $obj = new GetMac(PHP_OS);
        print_r($obj->result);
        echo $obj->macAddr;
    }
}