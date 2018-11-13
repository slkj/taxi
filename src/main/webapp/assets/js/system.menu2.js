var _menus_oneLeve=[{"menuid":"0","menuname":"系统管理","icon":"fa-home"},
	{"menuid":"1","menuname":"从业人员","icon":"fa-trophy"},
	{"menuid":"2","menuname":"企业信息","icon":"fa-inbox"},
	{"menuid":"3","menuname":"车辆信息","icon":"fa-suitcase"},
	{"menuid":"4","menuname":"人员管理","icon":"fa-dropbox"},
	{"menuid":"5","menuname":"考试管理","icon":"fa-dropbox"},
	{"menuid":"6","menuname":"处罚文书","icon":"fa-dropbox"}
	];
var _menus=[
    {"menuid":"00","icon":"fa-trophy","menuname":"系统管理",parentMenu:'0',
        "menus":[{"menuid":"000","menuname":"角色管理","icon":"fa-dashboard","url":"role/roleListPage"},
                {"menuid":"001","menuname":"系统用户","icon":"fa-delicious","url":"user/userListPage"},
                {"menuid":"0001","menuname":"菜单管理","icon":"fa-delicious","url":"module/menusPage"}
            ]},
	{"menuid":"11","icon":"fa-trophy","menuname":"从业人员管理",parentMenu:'1',
		"menus":[{"menuid":"110","menuname":"人员信息","icon":"fa-window-restore","url":"demo/form-success-popup1.html"},
                {"menuid":"111","menuname":"新报名人员","icon":"fa-window-restore","url":"demo/form-success-popup2.html"},
                {"menuid":"112","menuname":"通过考试人员","icon":"fa-window-maximize","url":"demo/form-success1.html"},
                {"menuid":"113","menuname":"未通过考试人员","icon":"fa-window-maximize","url":"demo/form-success2.html"},
                {"menuid":"114","menuname":"总台账","icon":"fa-align-center","url":"demo/form1.html"},
                {"menuid":"115","menuname":"死亡库","icon":"fa-align-center","url":"demo/form2.html"},
                {"menuid":"116","menuname":"超龄库","icon":"fa-columns","url":"demo/form2-column.html"},
                {"menuid":"117","menuname":"发证机关","icon":"fa-columns","url":"demo/form2-column2.html"},
                {"menuid":"116","menuname":"超龄库","icon":"fa-columns","url":"demo/form2-column.html"},
                {"menuid":"116","menuname":"注册审核","icon":"fa-columns","url":"demo/form2-column.html"},
                {"menuid":"116","menuname":"扫码注册","icon":"fa-columns","url":"demo/form2-column.html"},
                {"menuid":"116","menuname":"延续注册信息","icon":"fa-columns","url":"demo/form2-column.html"},
                {"menuid":"116","menuname":"扫码延续注册","icon":"fa-columns","url":"demo/form2-column.html"},
                {"menuid":"116","menuname":"注销审核","icon":"fa-columns","url":"demo/form2-column.html"},
                {"menuid":"116","menuname":"扫码注销","icon":"fa-columns","url":"demo/form2-column.html"},
                {"menuid":"116","menuname":"审核补办从业证","icon":"fa-columns","url":"demo/form2-column.html"},
                {"menuid":"116","menuname":"审批补办从业证","icon":"fa-columns","url":"demo/form2-column.html"},
                {"menuid":"116","menuname":"变更公司审核","icon":"fa-columns","url":"demo/form2-column.html"},
                {"menuid":"116","menuname":"报废注销审核","icon":"fa-columns","url":"demo/form2-column.html"},
                {"menuid":"116","menuname":"扫码换证","icon":"fa-columns","url":"demo/form2-column.html"},
                {"menuid":"116","menuname":"换证信息","icon":"fa-columns","url":"demo/form2-column.html"},
                {"menuid":"116","menuname":"扫码评级","icon":"fa-columns","url":"demo/form2-column.html"},
			]},{
     "menuid":"12","icon":"fa-television","menuname":"企业信息",parentMenu:'2',
        "menus":[{"menuid":"120","menuname":"企业基本信息","icon":"fa-globe","url":"https://item.taobao.com/item.htm?id=545823027227"},
                {"menuid":"121","menuname":"信誉考核管理","icon":"fa-laptop","url":"http://www.uimaker.com/member/index.php?uid=poya"}
            ]
    },
	{"menuid":"21","icon":"fa-plug","menuname":"车辆信息",parentMenu:'3',
		"menus":[
            {"menuid":"210","menuname":"出租车信息","icon":"fa-toggle-down","url":"demo/msgTip.html"},
            {"menuid":"211","menuname":"年审记录表","icon":"fa-puzzle-piece","url":"demo/msgTip.html"},
            {"menuid":"212","menuname":"过期审批","icon":"fa-desktop","url":"demo/msgTip.html"}
		]
	},
    {"menuid":"31","icon":"fa-suitcase","menuname":"人员管理",parentMenu:'4',
    	"menus":[{"menuid":"311","menuname":"考试报名","icon":"fa-inbox","url":"demo/msgTip.html"},
    			{"menuid":"312","menuname":"从业资格注册","icon":"fa-share-alt-square","url":"demo/msgTip.html"},
    	{"menuid":"221","menuname":"从业资格注销","icon":"fa-sticky-note","url":"demo/msgTip.html"},
        {"menuid":"222","menuname":"从业资格证补办","icon":"fa-window-minimize","url":"demo/msgTip.html"},
        {"menuid":"223","menuname":"公司变更","icon":"fa-sort-numeric-asc","url":"demo/msgTip.html"},
        {"menuid":"224","menuname":"报废注销","icon":"fa-bookmark","url":"demo/msgTip.html"},
        {"menuid":"224","menuname":"从业证换证申请","icon":"fa-bookmark","url":"demo/msgTip.html"},
        {"menuid":"224","menuname":"从业资格延续注册","icon":"fa-bookmark","url":"demo/msgTip.html"},
        {"menuid":"224","menuname":"从业人员考核","icon":"fa-bookmark","url":"demo/msgTip.html"}
    		]
    	},
    	{"menuid":"22","icon":"fa-cubes","menuname":"处罚文书",parentMenu:'6',
    		"menus":[{"menuid":"220","menuname":"案件登记","icon":"fa-dot-circle-o","url":"demo/inonSvg.html"},
                {"menuid":"226","menuname":"案件查询","icon":"fa-warning","url":"demo/msgTip.html"},
                {"menuid":"411","menuname":"基本信息管理","icon":"fa-id-card","url":"demo/resource.html"},
    			{"menuid":"412","menuname":"执法人员管理","icon":"fa-users","url":"demo/msgTip.html"},
    			{"menuid":"413","menuname":"执法依据信息管理","icon":"fa-address-card","url":"demo/msgTip.html"}
    		]
    	},
	{"menuid":"41","icon":"fa-dashboard","menuname":"诚信考核",parentMenu:'1',
		"menus":[
			{"menuid":"411","menuname":"基本信息管理","icon":"fa-id-card","url":"demo/resource.html"},
			{"menuid":"412","menuname":"考核标准信息管理","icon":"fa-users","url":"demo/msgTip.html"},
			{"menuid":"413","menuname":"考核记录","icon":"fa-address-card","url":"demo/msgTip.html"}
		]
	},
	{"menuid":"41","icon":"fa-dashboard","menuname":"考试管理",parentMenu:'5',
		"menus":[
			{"menuid":"411","menuname":"成绩录入","icon":"fa-id-card","url":"demo/resource.html"},
		]
	}
];

    //设置登录窗口
    function openPwd() {$('#updatePwd').window({title: '修改密码', width: 300, modal: true, shadow: true, closed: true, height: 160, resizable:false }); }
    //关闭登录窗口
    function closePwd() {$('#updatePwd').window('close');}

    //修改密码
    function serverLogin() {
        var $newpass = $('#txtNewPass');
        var $rePass = $('#txtRePass');

        if ($newpass.val() == '') {
            msgShow('系统提示', '请输入密码！', 'admin');
            return false;
        }
        if ($rePass.val() == '') {
            msgShow('系统提示', '请在一次输入密码！', 'admin');
            return false;
        }

        if ($newpass.val() != $rePass.val()) {
            msgShow('系统提示', '两次密码不一至！请重新输入', 'admin');
            return false;
        }

        $.post('/ajax=' + $newpass.val(), function(msg) {
            msgShow('系统提示', '恭喜，密码修改成功！<br>您的新密码为：' + msg, 'info');
            $newpass.val('');
            $rePass.val('');
            close();
        })
        
    }

    $(function() {
        openPwd();

        $('#editpass').click(function(){$('#updatePwd').window('open');});

        $('#btnEp').click(function(){serverLogin();});

		$('#btnCancel').click(function(){closePwd();});

        $('#loginOut').click(function() {
            $.messager.confirm('系统提示', '您确定要退出本次登录吗?', function(r) {
                if (r) {
                    location.href = 'logout';
                }
            });
        })
    });

$(function(){var mydate = new Date(); var tm=mydate.getFullYear(); $("#timeYear").text(tm); });