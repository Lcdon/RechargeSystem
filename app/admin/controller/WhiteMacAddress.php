<?php

// +----------------------------------------------------------------------
// | Admin Plugin for ThinkAdmin
// +----------------------------------------------------------------------
// | 版权所有 2014~2024 ThinkAdmin [ thinkadmin.top ]
// +----------------------------------------------------------------------
// | 官方网站: https://thinkadmin.top
// +----------------------------------------------------------------------
// | 开源协议 ( https://mit-license.org )
// | 免责声明 ( https://thinkadmin.top/disclaimer )
// +----------------------------------------------------------------------
// | gitee 代码仓库：https://gitee.com/zoujingli/think-plugs-admin
// | github 代码仓库：https://github.com/zoujingli/think-plugs-admin
// +----------------------------------------------------------------------

namespace app\admin\controller;

use think\admin\Controller;
use think\admin\model\SystemBase;
use think\admin\model\SystemUser;
use app\admin\model\WhiteMacAddressModel;
use think\admin\helper\QueryHelper;

/**
 * 系统用户管理
 * @class User
 * @package app\admin\controller
 */
class WhiteMacAddress extends Controller
{
    /**
     * 系统用户管理
     * @auth true
     * @menu true
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function index()
    {
//        dump(WhiteMacAddressModel::select()->toArray());die;
        $this->type = $this->get['type'] ?? 'index';
        WhiteMacAddressModel::mQuery()->layTable(function(QueryHelper $query){
            // 前置操作，处理 HTML 模型
            $this->title = 'Mac Address Manage';
            $this->bases = SystemBase::items('身份权限');
        },function(QueryHelper $query){
        // 后置操作，处理表格数据
        });
    }


    public function add()
    {
        WhiteMacAddressModel::mForm('form');
    }

    public function remove()
    {
        WhiteMacAddressModel::mDelete();
    }
}