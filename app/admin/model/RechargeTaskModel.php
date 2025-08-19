<?php

namespace app\admin\model;
use think\admin\Model;
use think\admin\model\SystemUser;

class RechargeTaskModel extends Model
{
    protected $table = 't4391_recharge_task_new';


    protected $fillable = ['name','system_user_id','equipment_id','state','create_time','begin_time','end_time'];

    public function equipment()
    {
        return $this->belongsTo(EquipmentModel::class,'equipment_id','id');
    }

    public function user()
    {
        return $this->belongsTo(SystemUser::class,'system_user_id','id');
    }

    public function getStateAttr($value){
        $status = [
            -1=>'Fail',
            0=>'Waiting',
            1=>'Running',
            2=>'Success',
            3=>'Cancel'
        ];
        return $status[$value];
    }
}