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

declare(strict_types=1);

namespace app\admin\controller;

use think\admin\Controller;
use think\admin\extend\CodeExtend;
use think\admin\model\SystemUser;
use think\admin\service\AdminService;
use think\admin\service\CaptchaService;
use think\admin\service\RuntimeService;
use think\admin\service\SystemService;
use app\admin\model\WhiteMacAddressModel;

/**
 * 用户登录管理
 * @class Login
 * @package app\admin\controller
 */
class Login extends Controller
{

    /**
     * 后台登录入口
     * @return void
     * @throws \think\admin\Exception
     */
    public function index()
    {
        if ($this->app->request->isGet()) {
            if (AdminService::isLogin()) {
                $this->redirect(sysuri('admin/index/index'));
            }
            else {
                // 加载登录模板
                $this->title = '系统登录';
                // 登录验证令牌
                $this->captchaType = 'LoginCaptcha';
                $this->captchaToken = CodeExtend::uuid();
                // 当前运行模式
                $this->runtimeMode = RuntimeService::check();
                // 后台背景处理
                $images = str2arr(sysconf('login_image|raw') ?: '', '|');
                if (empty($images)) $images = [
                    SystemService::uri('/static/theme/img/login/bg1.jpg'),
                    SystemService::uri('/static/theme/img/login/bg2.jpg'),
                ];
                $this->loginStyle = sprintf('style="background-image:url(%s)" data-bg-transition="%s"', $images[0], join(',', $images));
                // 更新后台主域名，用于部分无法获取域名的场景调用
                if ($this->request->domain() !== sysconf('base.site_host|raw')) {
                    sysconf('base.site_host', $this->request->domain());
                }
                $this->fetch();
            }
        }
        else {
            $data = $this->_vali([
                'username.require' => lang('登录账号不能为空!'),
                'username.min:4'   => lang('账号不能少于4位字符!'),
                'password.require' => lang('登录密码不能为空!'),
                'password.min:4'   => lang('密码不能少于4位字符!'),
                'verify.require'   => lang('图形验证码不能为空!'),
                'uniqid.require'   => lang('图形验证标识不能为空!'),
            ]);
            
            if($data['username'] != 'admin'){
                if(!isset($_POST['mac_address']) or empty($_POST['mac_address'])){
                    $this->error("The getUserMacAddress script is not open!");
                }
                $allew_mac_address_list = WhiteMacAddressModel::column('mac_address');
                if(!in_array($_POST['mac_address'],$allew_mac_address_list)){
                    $this->error("The computer's Mac address is not allowed to log in!");
                }
            }
            
            if (!CaptchaService::instance()->check($data['verify'], $data['uniqid'])) {
                $this->error('The verification code failed to be verified, please re-enter it!');
            }
            /*! 用户信息验证 */
            $map = ['username' => $data['username'], 'is_deleted' => 0];
            $user = SystemUser::mk()->where($map)->findOrEmpty();
            if ($user->isEmpty()) {
                $this->app->session->set('LoginInputSessionError', true);
                $this->error('If your login account or password is incorrect, please re-enter it!');
            }
            if (empty($user['status'])) {
                $this->app->session->set('LoginInputSessionError', true);
                $this->error('The account has been disabled, please contact the administrator!');
            }
            if (md5("{$user['password']}{$data['uniqid']}") !== $data['password']) {
                $this->app->session->set('LoginInputSessionError', true);
                $this->error('If your login account or password is incorrect, please re-enter it!');
            }
            $user->hidden(['sort', 'status', 'password', 'is_deleted']);
            $this->app->session->set('user', $user->toArray());
            $this->app->session->delete('LoginInputSessionError');
            // 更新登录次数
            $user->where(['id' => $user->getAttr('id')])->inc('login_num')->update([
                'login_at' => date('Y-m-d H:i:s'), 'login_ip' => $this->app->request->ip(),
            ]);
            // 刷新用户权限
            AdminService::apply(true);
            sysoplog('系统用户登录', '登录系统后台成功');
            $this->success('Login successful', sysuri('admin/index/index?lang=en-us'));
        }
    }

    //apipost登录使用
    public function indexPost()
    {
        $data = $this->_vali([
            'username.require' => '登录账号不能为空!',
            'username.min:4'   => '账号不能少于4位字符!',
            'password.require' => '登录密码不能为空!',
            'password.min:4'   => '密码不能少于4位字符!',
//            'mac_address.require'   => '没有开启用户地址脚本!',
//            'uniqid.require'   => '图形验证标识不能为空!',
        ]);
//        dump($data);die;
        /*! 用户信息验证 */
        $map = ['username' => $data['username'], 'is_deleted' => 0];
        $user = SystemUser::mk()->where($map)->findOrEmpty();
        if ($user->isEmpty()) {
            $this->app->session->set('LoginInputSessionError', true);
            $this->error('登录账号或密码错误，请重新输入!');
        }
        if (empty($user['status'])) {
            $this->app->session->set('LoginInputSessionError', true);
            $this->error('账号已经被禁用，请联系管理员!');
        }
//        if (md5("{$user['password']}{$data['uniqid']}") !== $data['password']) {
//            $this->app->session->set('LoginInputSessionError', true);
//            $this->error('登录账号或密码错误，请重新输入!');
//        }
        $user->hidden(['sort', 'status', 'password', 'is_deleted']);
        $this->app->session->set('user', $user->toArray());
        $this->app->session->delete('LoginInputSessionError');
        // 更新登录次数
        $user->where(['id' => $user->getAttr('id')])->inc('login_num')->update([
            'login_at' => date('Y-m-d H:i:s'), 'login_ip' => $this->app->request->ip(),
        ]);
        // 刷新用户权限
        AdminService::apply(true);
        sysoplog('系统用户登录', '登录系统后台成功');
        return json('success');
    }

    /**
     * 生成验证码
     * @return void
     */
    public function captcha()
    {
        $input = $this->_vali([
            'type.require'  => '类型不能为空!',
            'token.require' => '标识不能为空!',
        ]);
        $image = CaptchaService::instance()->initialize();
        $captcha = ['image' => $image->getData(), 'uniqid' => $image->getUniqid()];
        // 未发生异常时，直接返回验证码内容
        if (!$this->app->session->get('LoginInputSessionError')) {
            $captcha['code'] = $image->getCode();
        }
        $this->success('生成验证码成功', $captcha);
    }

    /**
     * 退出登录
     * @return void
     */
    public function out()
    {
        $this->app->session->destroy();
        $this->success('logout success!', sysuri('admin/login/index'));
    }
}
