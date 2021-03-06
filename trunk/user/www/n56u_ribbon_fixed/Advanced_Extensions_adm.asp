<!DOCTYPE html>
<html>
<head>
<title><#Web_Title#> - ADM</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">

<link rel="shortcut icon" href="images/favicon.ico">
<link rel="icon" href="images/favicon.png">
<link rel="stylesheet" type="text/css" href="/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="/bootstrap/css/main.css">
<link rel="stylesheet" type="text/css" href="/bootstrap/css/engage.itoggle.css">

<script type="text/javascript" src="/jquery.js"></script>
<script type="text/javascript" src="/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/bootstrap/js/engage.itoggle.min.js"></script>
<script type="text/javascript" src="/state.js"></script>
<script type="text/javascript" src="/general.js"></script>
<script type="text/javascript" src="/itoggle.js"></script>
<script type="text/javascript" src="/popup.js"></script>
<script type="text/javascript" src="/help.js"></script>
<script>
var $j = jQuery.noConflict();

$j(document).ready(function() {
	init_itoggle('adm_enable',change_adbyby_adm_bridge);
	init_itoggle('adbyby_CPUAverages');
	init_itoggle('adm_https');
	init_itoggle('adm_hookport');
	init_itoggle('ss_DNS_Redirect',change_ss_DNS_Redirect);
});

</script>
<script>

<% login_state_hook(); %>

function initial(){
	show_banner(1);
	 show_menu(8,<% nvram_get_x("", "adm_L2"); %>,<% nvram_get_x("", "adm_L3"); %>);
	show_footer();
	//change_adbyby_whitehost_bridge(1);
	change_adbyby_adm_bridge(1);
	change_ss_DNS_Redirect();
	//change_ss_sub4_bridge(1);
	//change_adbyby_adblocks_bridge(1);
	if (!login_safe())
		textarea_scripts_enabled(0);
}

function textarea_scripts_enabled(v){
	inputCtrl(document.form['scripts.adm_rules_script.sh'], v);
	inputCtrl(document.form['scripts.ad_config_script.sh'], v);
}

function applyRule(){
//	if(validForm()){
		showLoading();
		
		document.form.action_mode.value = " Apply ";
		document.form.current_page.value = "/Advanced_Extensions_adm.asp";
		document.form.next_page.value = "";
		
		document.form.submit();
//	}
}


function done_validating(action){
	refreshpage();
}
function change_adbyby_whitehost_bridge(mflag){
	var m = document.form.adbyby_whitehost_x[0].checked;
	showhide_div("adbyby_whitehost1", m);
}
function change_adbyby_adm_bridge(mflag){
	var m = document.form.adm_enable[0].checked;
	showhide_div("adm_update_b", m);
	if(m == "1"){
	document.form.adbyby_enable.value = "0";
	document.form.koolproxy_enable.value = "0";
	}
	else{
	document.form.adbyby_enable.value = document.form.adbyby_enable_o.value;
	document.form.koolproxy_enable.value = document.form.koolproxy_enable_o.value;
	}
}
function change_ss_sub4_bridge(mflag){
	var m = document.form.ss_sub4[0].checked;
	if(m){
		var str = "hosts 广告过滤规则有可能导致 Adbyby 过滤失效!!!\n你确定要启用吗？";
		if(confirm(str)){
		//refreshpage();
		return;
		}
		else{
		refreshpage();
		}
	}
}
function change_adbyby_adblocks_bridge(mflag){
	var m = document.form.adbyby_adblocks[0].checked;
	if(m){
		var str = "第三方规则有可能导致 Adbyby 过滤失效!!!\n你确定要启用吗？";
		if(confirm(str)){
		//refreshpage();
		return;
		}
		else{
		refreshpage();
		}
	}
}
function change_ss_DNS_Redirect(){
	var m = document.form.ss_DNS_Redirect[0].checked;
	var is_ss_DNS_Redirect = (m == "1") ? 1 : 0;
	showhide_div("ss_DNS_Redirect_IP_tr", is_ss_DNS_Redirect);
}
function button_updatead(){
	var $j = jQuery.noConflict();
	$j.post('/apply.cgi',
	{
		'action_mode': ' updateadm ',
	});
}

</script>
</head>

<body onload="initial();" onunLoad="return unload_body();">

<div class="wrapper">
	<div class="container-fluid" style="padding-right: 0px">
		<div class="row-fluid">
			<div class="span3"><center><div id="logo"></div></center></div>
			<div class="span9" >
				<div id="TopBanner"></div>
			</div>
		</div>
	</div>

	<div id="Loading" class="popup_bg"></div>

	<iframe name="hidden_frame" id="hidden_frame" src="" width="0" height="0" frameborder="0"></iframe>

	<form method="post" name="form" id="ruleForm" action="/start_apply.htm" target="hidden_frame">

	<input type="hidden" name="current_page" value="Advanced_Extensions_adm.asp">
	<input type="hidden" name="next_page" value="">
	<input type="hidden" name="next_host" value="">
	<input type="hidden" name="sid_list" value="LANHostConfig;General;">
	<input type="hidden" name="group_id" value="">
	<input type="hidden" name="action_mode" value="">
	<input type="hidden" name="action_script" value="">
	<input type="hidden" name="wan_ipaddr" value="<% nvram_get_x("", "wan0_ipaddr"); %>" readonly="1">
	<input type="hidden" name="wan_netmask" value="<% nvram_get_x("", "wan0_netmask"); %>" readonly="1">
	<input type="hidden" name="dhcp_start" value="<% nvram_get_x("", "dhcp_start"); %>">
	<input type="hidden" name="adbyby_enable_o" value="<% nvram_get_x("", "adbyby_enable"); %>">
	<input type="hidden" name="koolproxy_enable_o" value="<% nvram_get_x("", "koolproxy_enable"); %>">
	<input type="hidden" name="dhcp_end" value="<% nvram_get_x("", "dhcp_end"); %>">

	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span3">
				<!--Sidebar content-->
				<!--=====Beginning of Main Menu=====-->
				<div class="well sidebar-nav side_nav" style="padding: 0px;">
					<ul id="mainMenu" class="clearfix"></ul>
					<ul class="clearfix">
						<li>
							<div id="subMenu" class="accordion"></div>
						</li>
					</ul>
				</div>
			</div>

			<div class="span9">
				<!--Body content-->
				<div class="row-fluid">
					<div class="span12">
						<div class="box well grad_colour_dark_blue">
							<h2 class="box_head round_top">广告屏蔽功能 - ADM</h2>
							<div class="round_bottom">
								<div class="row-fluid">
									<div id="tabMenu" class="submenuBlock"></div>
									<div class="alert alert-info" style="margin: 10px;">ADM - 广告拦截。<a href="http://www.admflt.com/" target="blank">项目地址: http://www.admflt.com/</a> <div>https须知:启动ADM后保存证书并导入相应的证书到浏览器（证书安装到“受信任的根证书颁发机构”）</div></div>

									<table width="100%" align="center" cellpadding="4" cellspacing="0" class="table">
										<tr >
											<th width="30%" style="border-top: 0 none;">启用 ADM 功能 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<input id="adm_update_b" class="btn btn-success" style="width:110px display:none;" type="button" name="updatefrp" value="重启、更新程序" onclick="button_updatead()" /></th>
											<td style="border-top: 0 none;">
													<div class="main_itoggle">
													<div id="adm_enable_on_of">
														<input type="checkbox" id="adm_enable_fake" <% nvram_match_x("", "adm_enable", "1", "value=1 checked"); %><% nvram_match_x("", "adm_enable", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="adm_enable" id="adm_enable_1" class="input" value="1" onClick="change_adbyby_adm_bridge(1);" <% nvram_match_x("", "adm_enable", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="adm_enable" id="adm_enable_0" class="input" value="0" onClick="change_adbyby_adm_bridge(1);" <% nvram_match_x("", "adm_enable", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
										</tr>
										<tr >
											<th width="30%" style="border-top: 0 none;">启用 https 全局过滤 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<input type="button" onClick="location.href='adm_ca.crt'" value="<#CTL_onlysave#>证书" class="btn btn-success" style="width: 90px"></th>
											<td style="border-top: 0 none;">
													<div class="main_itoggle">
													<div id="adm_https_on_of">
														<input type="checkbox" id="adm_https_fake" <% nvram_match_x("", "adm_https", "1", "value=1 checked"); %><% nvram_match_x("", "adm_https", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="adm_https" id="adm_https_1" class="input" value="1" <% nvram_match_x("", "adm_https", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="adm_https" id="adm_https_0" class="input" value="0" <% nvram_match_x("", "adm_https", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
										</tr>
										<tr style="display:none;">
											<th width="50%">Adbyby</th>
											<td style="border-top: 0 none;">
												<select name="adbyby_enable" class="input">
													<option value="0" <% nvram_match_x("","adbyby_enable", "0","selected"); %>>0</option>
													<option value="1" <% nvram_match_x("","adbyby_enable", "1","selected"); %>>1</option>
												</select>
											</td>
										</tr>
										<tr style="display:none;">
											<th width="50%">koolproxy</th>
											<td style="border-top: 0 none;">
												<select name="koolproxy_enable" class="input">
													<option value="0" <% nvram_match_x("","koolproxy_enable", "0","selected"); %>>0</option>
													<option value="1" <% nvram_match_x("","koolproxy_enable", "1","selected"); %>>1</option>
												</select>
											</td>
										</tr>
										<tr>
											<th width="50%">过滤方案选择</th>
											<td style="border-top: 0 none;">
												<select name="adbyby_mode_x" class="input">
													<option value="0" <% nvram_match_x("","adbyby_mode_x", "0","selected"); %>>方案一全局模式（推荐），全部IP走adm过滤</option>
													<option value="1" <% nvram_match_x("","adbyby_mode_x", "1","selected"); %>>方案二admlist，有过滤规则的站点IP走adm</option>
												</select>
												<div><span style="color:#888;">方案二是ipset匹配模式，过滤效果稍差，</span></div>
												<div><span style="color:#888;">但有效降低CPU占用，推荐方案一</span></div>
											</td>
										</tr>
										<tr>
											<th width="30%" style="border-top: 0 none;"><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 26, 1);">启用 CPU 占用率较高时自动关闭 Adbyby 功能</a></th>
											<td style="border-top: 0 none;">
													<div class="main_itoggle">
													<div id="adbyby_CPUAverages_on_of">
														<input type="checkbox" id="adbyby_CPUAverages_fake" <% nvram_match_x("", "adbyby_CPUAverages", "1", "value=1 checked"); %><% nvram_match_x("", "adbyby_CPUAverages", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="adbyby_CPUAverages" id="adbyby_CPUAverages_1" class="input" value="1" <% nvram_match_x("", "adbyby_CPUAverages", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="adbyby_CPUAverages" id="adbyby_CPUAverages_0" class="input" value="0" <% nvram_match_x("", "adbyby_CPUAverages", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
										</tr>
										<tr>
											<th width="30%" style="border-top: 0 none;">启用更多的端口过滤功能？</th>
											<td>
													<div class="main_itoggle">
													<div id="adm_hookport_on_of">
														<input type="checkbox" id="adm_hookport_fake" <% nvram_match_x("", "adm_hookport", "1", "value=1 checked"); %><% nvram_match_x("", "adm_hookport", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="adm_hookport" id="adm_hookport_1" class="input" value="1" <% nvram_match_x("", "adm_hookport", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="adm_hookport" id="adm_hookport_0" class="input" value="0" <% nvram_match_x("", "adm_hookport", "0", "checked"); %> /><#checkbox_No#>
												</div>
												<div><span style="color:#FF0000;">有些广告过滤规则可能是非80端口</span></div>
											</td>
										</tr>
										<tr id="ss_DNS_Redirect_tr" >
											<th width="30%" style="border-top: 0 none;"><a class="help_tooltip"  href="javascript:void(0);" onmouseover="openTooltip(this, 25,15);">重定向 DNS (admlist 模式建议开启)</a></th>
											<td style="border-top: 0 none;">
													<div class="main_itoggle">
													<div id="ss_DNS_Redirect_on_of">
														<input type="checkbox" id="ss_DNS_Redirect_fake" <% nvram_match_x("", "ss_DNS_Redirect", "1", "value=1 checked"); %><% nvram_match_x("", "ss_DNS_Redirect", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="ss_DNS_Redirect" id="ss_DNS_Redirect_1" class="input" value="1" onclick="change_ss_DNS_Redirect();" <% nvram_match_x("", "ss_DNS_Redirect", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="ss_DNS_Redirect" id="ss_DNS_Redirect_0" class="input" value="0" onclick="change_ss_DNS_Redirect();" <% nvram_match_x("", "ss_DNS_Redirect", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
										</tr>
										<tr id="ss_DNS_Redirect_IP_tr" style="display:none;">
											<th style="border-top: 0 none;">DNS 重定向地址:</th>
											<td style="border-top: 0 none;">
												<input type="text" maxlength="15"  class="none" size="60" name="ss_DNS_Redirect_IP" placeholder="<% nvram_get_x("", "lan_ipaddr"); %>" value="<% nvram_get_x("","ss_DNS_Redirect_IP"); %>" onKeyPress="return is_ipaddr(this,event);"/>
												<div>&nbsp;<span style="color:#888;">[留空]为路由的IP</span></div>
											</td>
										</tr>
										<tr id="adm_update_tr" >
											<th style="border-top: 0 none;">规则自动更新:</th>
											<td style="border-top: 0 none;">
												<select name="adm_update" class="input" style="width: 60px;">
													<option value="0" <% nvram_match_x("","adm_update", "0","selected"); %>>每天</option>
													<option value="1" <% nvram_match_x("","adm_update", "1","selected"); %>>每隔</option>
													<option value="2" <% nvram_match_x("","adm_update", "2","selected"); %>>关闭</option>
												</select>
												<input style="width: 20px;" type="text" maxlength="2"  class="none" size="60" name="adm_update_hour" placeholder="23" value="<% nvram_get_x("","adm_update_hour"); %>" onKeyPress="return is_number(this,event);"/>时，<input style="width: 20px;" type="text" maxlength="2"  class="none" size="60" name="adm_update_min" placeholder="59" value="<% nvram_get_x("","adm_update_min"); %>" onKeyPress="return is_number(this,event);"/>分，更新
												&nbsp;<span style="color:#888;"></span>
												<div>&nbsp;<span style="color:#888;">注意：更新时可能会造成网游断线！</span></div>
											</td>
										</tr>
										<tr>
											<td colspan="3" style="border-top: 0 none;">
												<i class="icon-hand-right"></i> <a href="javascript:spoiler_toggle('script10')"><span>ADM 自定义过滤规则:</span></a>
												<div id="script10" style="display:none;">
													<textarea rows="24" wrap="off" spellcheck="false" maxlength="2097152" class="span12" name="scripts.adm_rules_script.sh" style="font-family:'Courier New'; font-size:12px;"><% nvram_dump("scripts.adm_rules_script.sh",""); %></textarea>
												</div>
											</td>
										</tr>
										<tr id="ad_config">
											<td colspan="3" style="border-top: 0 none;">
												<i class="icon-hand-right"></i> <a href="javascript:spoiler_toggle('script11')"><span>点这里自定义内网 IP 过滤广告控制功能、订阅第三方自定义规则</span></a>
												<div id="script11" style="display:none;">
													<textarea rows="24" wrap="off" spellcheck="false" maxlength="2097152" class="span12" name="scripts.ad_config_script.sh" style="font-family:'Courier New'; font-size:12px;"><% nvram_dump("scripts.ad_config_script.sh",""); %></textarea>
												</div>
											</td>
										</tr>
										<tr>
											<td colspan="2" style="border-top: 0 none;">
												<br />
												<center><input class="btn btn-primary" style="width: 219px" type="button" value="<#CTL_apply#>" onclick="applyRule()" /></center>
											</td>
										</tr>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	</form>

	<div id="footer"></div>
</div>
</body>
</html>

