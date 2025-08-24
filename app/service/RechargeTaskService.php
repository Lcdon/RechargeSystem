<?php

namespace app\service;

use app\admin\model\EquipmentModel;
use app\admin\model\EquipmentUserBindModel;
use app\admin\model\RechargeTaskModel;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;
use think\admin\model\SystemUser;
use think\facade\Cache;

class RechargeTaskService
{
    protected RechargeTaskModel $recharge_task_model;
    protected EquipmentModel $equipment_model;
    protected EquipmentUserBindModel $equipment_user_bind_model;
    protected SystemUser $system_user_model;
    public function __construct()
    {
        $this->recharge_task_model = new RechargeTaskModel();
        $this->equipment_model = new EquipmentModel();
        $this->equipment_user_bind_model = new EquipmentUserBindModel();
        $this->system_user_model = new SystemUser();
    }

    /**
     * 获取充值任务列表
     * @param $params
     * @param $page
     * @param $limit
     * @return array
     */
    public function getRechargeTaskList($params, $page, $limit): array
    {
        try{
            $query = $this->recharge_task_model;
            if(isset($params['system_user_id']) and $params['system_user_id']){
                $query = $query->where('system_user_id',$params['system_user_id']);
            }
            if(isset($params['equipment_id']) and $params['equipment_id']){
                $query = $query->where('equipment_id',$params['equipment_id']);
            }
            if(isset($params['state']) and $params['state']){
                $query = $query->where('state',$params['state']);
            }
            if(isset($params['recharge_tel']) and $params['recharge_tel']){
                $query = $query->where('recharge_tel',$params['recharge_tel']);
            }
            if(isset($params['begin_time']) and $params['begin_time']){
                $explode_time = explode(' - ',$params['begin_time']);
                $params['begin_time'][0] = strtotime($explode_time[0]);
                $params['begin_time'][1] = strtotime($explode_time[1]);
                $query = $query->whereBetween('begin_time',$params['begin_time']);
            }
            if(isset($params['create_time']) and $params['create_time']) {
                $explode_time = explode(' - ', $params['create_time']);
                $params['create_time'][0] = strtotime($explode_time[0]);
                $params['create_time'][1] = strtotime($explode_time[1]);
                $query = $query->whereBetween('create_time', $params['create_time']);
            }
            if(isset($params['recharge_time']) and $params['recharge_time']){
                $explode_time = explode(' - ',$params['recharge_time']);
                $params['recharge_time'][0] = strtotime($explode_time[0]);
                $params['recharge_time'][1] = strtotime($explode_time[1]);
                $query = $query->whereBetween('recharge_time',$params['recharge_time']);
            }
//            if(isset($params['recharge_method']) and $params['recharge_method']){
//                $query = $query->where('recharge_method',$params['recharge_method']);
//            }
            $count = $query->count();
            $items = $query
                ->with('equipment')
                ->page($page, $limit)->select();
            return ['code'=>0, 'count'=>$count, 'data'=>$items];
        }catch (\Exception $e){
            return ['code'=>CodeMsg('fail'), 'msg'=>$e->getMessage()];
        }
    }

    /**
     * @param $data
     * @return bool
     */
    public function add($data): bool
    {
        return $this->recharge_task_model->insert($data);
    }

    /**
     * @return void
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function pushTask(): void
    {
        $redis = Cache::store('redis')->handler();
        $recharge_task = $this->recharge_task_model->where('state',0)->select()->toArray();
        foreach ($recharge_task as $task){
            if($task['equipment_id']){
                $queue_name = 'equipment_'.$task['equipment_id'];
            }else{
                $item = $this->equipment_user_bind_model
                    ->alias('eub')
                    ->with(['user'=>function ($query) use ($task) {
                        $query->where('daily_limit_remain','>',$task['amount']);
                    }])
                    ->leftJoin($this->equipment_model->getTable().' e','eub.equipment_id=e.id')
                    ->where('e.assignment_status',1)
                    ->order('e.sort')
                    ->limit(1)
                    ->select()->toArray();
                $item = $item[0] ?? [];
                if($item){
                    $queue_name = 'equipment_'.$item['equipment_id'];
                    $this->recharge_task_model->where('id',$task['id'])->update(['equipment_id'=>$item['equipment_id']]);
                }else{
                    continue;
                }
            }
            $res = $redis->lrange($queue_name, 0, -1);
            if(!$res) $res = [];
            if(!in_array($task['id'], $res)){
                echo $queue_name.':'.$task['id'].PHP_EOL;
                $this->recharge_task_model->where('id',$task['id'])->update(['state'=>1,'state_msg'=>'待充值']);
                $redis->lpush($queue_name, $task['id']);
            }
        }
    }


}