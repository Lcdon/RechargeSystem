<?php

namespace app\service;

use think\admin\model\SystemUser;
use think\facade\Db;

class User
{
    protected SystemUser $system_user_model;
    public function __construct()
    {
        $this->system_user_model = new SystemUser();
    }

    /**
     * 更新用户余额
     */
    public function updateUserLimit(): bool
    {
        $res = $this->system_user_model->where('daily_balance_update_switch', 1)
            ->update(['daily_limit_remain' => Db::raw('daily_limit')]);
        if($res){
            return true;
        }
        return false;
    }
}