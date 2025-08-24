<?php
namespace app\admin\model;

use think\admin\Model;

class EquipmentModel extends Model
{
    protected $table = 't4391_equipment';

    //设备状态
    public function getEquipmentStateAttr($value)
    {
        $status = [0=>'空闲',1=>'充值中'];
        return $status[$value];
    }

    //设备任务执行状态
    public function getEquipmentTaskStateAttr($value)
    {
        $status = [0=>'掉线',1=>'在线'];
        return $status[$value];
    }


    public function equipment_user_bind()
    {
        return $this->hasOne(EquipmentUserBindModel::class,'equipment_id','id');
    }

    protected $insert = [
    ];
}