<?php

namespace app\admin\model;
use think\admin\Model;
use think\admin\model\SystemUser;

class EquipmentUserBindModel extends Model
{

    protected $table = 't4391_equipment_user_bind';

    /**
     * 定义与Equipment的反向关系
     * @return \think\model\relation\BelongsTo
     */
    public function equipment()
    {
        return $this->belongsTo(EquipmentModel::class,'equipment_id','id');
    }

    /**
     * 定义与System的反向关系
     * @return \think\model\relation\BelongsTo
     */
    public function user()
    {
        return $this->belongsTo(SystemUser::class,'system_user_id','id');
    }
}