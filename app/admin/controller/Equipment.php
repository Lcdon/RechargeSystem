<?php
namespace app\admin\controller;

use think\facade\View;
use app\admin\model\EquipmentModel as EM;

/**
 * 设备管理
 * @class Equipment
 * @package app\admin\controller
 */
class Equipment extends Base
{
    public function __construct()
    {
        $recharge_method = config('app.recharge_method');
        View::assign('recharge_method',$recharge_method);
    }
    /**
     * 设备管理
     * @auth true
     * @menu true
     */
     public function index()
     {
         View::assign('title',lang('设备管理'));
         return View::fetch();
     }

    // 设备管理列表

    /**
     * 设备列表
     * @auth true
     * @return \think\response\Json
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function list()
    {
        if(!isset($_POST['page']))$page = 1;
        else $page = $_POST['page'];
        if(!isset($_POST['limit'])) $limit = 10;
        else $limit = $_POST['limit'];
        $where = [];
        if(isset($_POST['equipment_name']) && $_POST['equipment_name']!=''){
            $where[] = ['equipment_name','like','%'.$_POST['equipment_name'].'%'];
        }
        if(isset($_POST['recharge_method']) && $_POST['recharge_method']!=''){
            $where[] = ['recharge_method','=',$_POST['recharge_method']];
        }
        $equipment_model = new EM();
        $list = $equipment_model
            ->where($where)
            ->limit(($page-1)*$limit,$limit)
            ->select()
            ->toArray();
        $count = $equipment_model->count();
        $data['code'] = 0;
        $data['count'] = $count;
        $data['data'] = $list;
        return json($data);
    }

    /**
     * 添加设备
     * @auth true
     */
    public function add()
    {
        if(request()->isPost()){
            if(!isset($_POST['equipment_name']) || !isset($_POST['account']) || !isset($_POST['password']) || !isset($_POST['recharge_id']) || !isset($_POST['recharge_password']) || !isset($_POST['remark']))
                return json(['msg'=>'The parameters are incomplete'],CodeMsg('fail'));
            $equipment = new EM;
            $equipment->save($_POST);
            $response['code'] = CodeMsg('success');
            $response['msg'] = 'success';
            return  json($response);
        }else{
            EM::mForm('form');
        }
    }

    /**
     * 编辑设备
     * @auth true
     */
    public function edit()
    {
        if(request()->isPost()){
            if(!isset($_POST['id']))
                return json(['msg'=>'The parameters are incomplete'],CodeMsg('fail'));
            $equipment = EM::where("id",$_POST['id'])->find();
            unset($_POST['id']);
            $equipment->save($_POST);
            $response['code'] = CodeMsg('success');
            $response['msg'] = 'success';
            return  json($response);
        }else{
            EM::mForm('form');
        }
    }

    /**
     * 删除设备
     * $auth true
     */
    public function remove()
    {
        if(!isset($_POST['id']))
            return json(['msg'=>'The parameters are incomplete'],CodeMsg('fail'));
        EM::mDelete();
        $response['code'] = CodeMsg('success');
        $response['msg'] = 'success';
        return  json($response);
    }

    /**
     * 修改设备开启状态
     * $auth true
     */
    public function initiate_state()
    {
        $data = $this->_vali(['id.require'=>'id is null','initiate_state.require'=>'initiate_state is null']);
        EM::mSave($data);
    }
}