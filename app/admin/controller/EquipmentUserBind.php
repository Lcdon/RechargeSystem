<?php

namespace app\admin\controller;

use app\admin\model\EquipmentUserBindModel;
use think\facade\View;
use app\admin\model\EquipmentUserBindModel as EUB;
use app\admin\model\EquipmentModel;
use think\admin\model\SystemUser;

/**
 * 设备账号绑定
 * @class EquipmentUserBind
 * @package app\admin\controller
 */
class EquipmentUserBind extends Base
{
    /**
     * 绑定页面
     * @auth true
     * @menu true
     */
    public function index()
    {
        View::assign('title',lang('设备账号绑定'));
        return View::fetch();
    }

    /**
     * 绑定列表
     * @auth true
     */
    public function list()
    {
        $data = $this->_vali([
            'page.require'=>'page is null',
            'limit.require'=>'limit is null',
            '_order_.default'=>'asc',
            'equipment_name.default'=>'',
            'user.default'=>'',
        ]);
        $page = $data['page'];
        $limit = $data['limit'];

        $offset = ($page - 1) * $limit;
        $query = new EUB();
        if($data['user']){
            $user_ids = SystemUser::where('username','like','%'.$data['user'].'%')->column('id');
            if(!$user_ids){$user_ids=[0];}
            $query = $query->whereIn('system_user_id',$user_ids);
        }
        if($data['equipment_name']){
            $equipment_ids = EquipmentModel::where('equipment_name','like','%'.$data['equipment_name'].'%')->column('id');

            if(!$equipment_ids){$equipment_ids=[0];}
            $query = $query->whereIn('equipment_id',$equipment_ids);
        }
        $query = $query->with(['equipment','user'])
            ->limit($offset, $limit)
            ->order('id '.$data['_order_']);
        $binds = $query
            ->select()
            ->toArray();
        $response['code']   = 0;
        $response['count']  = EUB::count();
        $response['data']   = $binds;
        return json($response);
    }

    /**
     * 添加绑定
     * @auth true
     */
    public function add()
    {
        if(request()->isPost()){
            $data = $this->_vali([
                'equipment_id.require'=>'equipment is null',
                'system_user_id.require'=>'user is null'
            ]);
//            if(EUB::where('equipment_id',$data['equipment_id'])->find()){
//                $response['code'] = CodeMsg('fail');
//                $response['msg'] = 'equipment has been bound';
//                return json($response);
//            }
            if(EUB::where('system_user_id',$data['system_user_id'])->find()){
                $response['code'] = CodeMsg('fail');
                $response['msg'] = 'account has been bound';
                return json($response);
            }
            $newItem = new EUB;
            $newItem->save($data);
            $response['code'] = CodeMsg('success');
            $response['msg'] = 'success';
            return json($response);
        }else{
            
            $Equipments = EquipmentModel::column('id,equipment_name');
            foreach($Equipments as $Equipment_key=>$Equipment_val){
                $Equipments[$Equipment_key]['default'] = 0;
            }
            View::assign('equipments',$Equipments);
            View::assign('users',SystemUser::where('status',1)->column('id,username,nickname'));
            View::assign('page_type','add');
            return View::fetch('form');
        }
    }

    /**
     * 修改绑定
     * @auth true
     */
    public function edit()
    {
        $data = $this->_vali([
            'id.require'=>'id is null',
            // 'system_user_id.default'=>null,
            'equipment_id.default'=>null
        ]);
        // dump($data);die;
        if(empty($data['equipment_id'])){
            $EquipmentBind = EquipmentUserBindModel::where('id',$data['id'])->field('system_user_id,equipment_id')->find()->toArray();
            $Equipment = EquipmentModel::field('id,equipment_name')->select()->toArray();
            foreach($Equipment as $Equipment_key=>$Equipment_val){
                if($Equipment_val['id']==$EquipmentBind['equipment_id']){
                    $Equipment[$Equipment_key]['default'] = 1;
                }else{
                    $Equipment[$Equipment_key]['default'] = 0;
                }
            }
            $Users = SystemUser::where('id',$EquipmentBind['system_user_id'])->column('id,username,nickname');
            View::assign('page_type','edit');
            View::assign('equipments',$Equipment);
            View::assign('id',$data['id']);
            View::assign('users',$Users);
            return View::fetch('form');
        }else{
            EquipmentUserBindModel::where('id',$data['id'])->save(['equipment_id'=>$data['equipment_id']]);
            $response['code'] = CodeMsg('success');
            $response['msg'] = 'success';
            return json($response);
        }
    }

    /**
     * 删除绑定
     * @auth true
     */
    public function remove()
    {
        $this->_vali(['id.require'=>'id is null']);
        EUB::mDelete();
    }

    public function excel()
    {

    }
}