{include file='user/main.tpl'}
{$ssr_prefer = URL::SSRCanConnect($user, 0)}

<style>
.table {
    box-shadow: none;
}
table tr td:first-child {
    text-align: right;
    font-weight: bold;
}
</style>

<main class="content">

    <div class="content-header ui-content-header">
        <div class="container">
            <h1 class="content-heading">トップ画面</h1>
        </div>
    </div>
    <div class="container">
        <section class="content-inner margin-top-no">
            <div class="ui-card-wrap">

                <div class="col-xx-12 col-xs-6 col-lg-3">
                    <div class="card user-info">
                        <div class="user-info-main">
                            <div class="nodemain">
                                <div class="nodehead node-flex">
                                    <div class="nodename">ユーザーランク</div>
                                </div>
                                <div class="nodemiddle node-flex">
                                    <div class="nodetype">
                                        {if $user->class!=0}
                                            <dd>VIP {$user->class}</dd>
                                        {else}
                                            <dd>通常ユーザー</dd>
                                        {/if}
                                    </div>
                                </div>
                                <div class="nodemiddle node-flex">
                                    {if $user->class_expire!="1989-06-04 00:05:00"}
                                        <div style="font-size: 14px">等级到期时间 {$user->class_expire}</div>
                                    {else}
                                        <div style="font-size: 14px">账户等级不会过期</div>
                                    {/if}
                                </div>
                            </div>
                        </div>
                        <div class="user-info-bottom">
                            <div class="nodeinfo node-flex">
                                {if $user->class!=0}
                                    <span><i class="icon icon-md">add_circle</i>通信量を追加する</span>
                                {else}
                                    <span><i class="icon icon-md">add_circle</i>VIPを購入して利用可能なサーバーを追加する</span>
                                {/if}
                                <a href="/user/shop" class="card-tag tag-orange">ストア</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-xx-12 col-xs-6 col-lg-3">
                    <div class="card user-info">
                        <div class="user-info-main">
                            <div class="nodemain">
                                <div class="nodehead node-flex">
                                    <div class="nodename">残高</div>
                                </div>
                                <div class="nodemiddle node-flex">
                                    <div class="nodetype">
                                        {$user->money} 円
                                    </div>
                                </div>
                                <div class="nodemiddle node-flex">
                                    <div style="font-size: 14px">账户有效时间 {$user->expire_in}</div>
                                </div>
                            </div>
                        </div>
                        <div class="user-info-bottom">
                            <div class="nodeinfo node-flex">
                                <span><i class="icon icon-md">attach_money</i>残高をチャージする</span>
                                <a href="/user/code" class="card-tag tag-green">チャージ</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-xx-12 col-xs-6 col-lg-3">
                    <div class="card user-info">
                        <div class="user-info-main">
                            <div class="nodemain">
                                <div class="nodehead node-flex">
                                    <div class="nodename">現在の接続数</div>
                                </div>
                                <div class="nodemiddle node-flex">
                                    <div class="nodetype">
                                        {if $user->node_connector!=0}
                                            <dd>{$user->online_ip_count()} / {$user->node_connector}</dd>
                                        {else}
                                            <dd>{$user->online_ip_count()} / 無制限</dd>
                                        {/if}
                                    </div>
                                </div>
                                <div class="nodemiddle node-flex">
                                    {if $user->lastSsTime()!="从未使用喵"}
                                        <div style="font-size: 14px">上次使用：{$user->lastSsTime()}</div>
                                    {else}
                                        <div style="font-size: 14px">从未使用过</div>
                                    {/if}
                                </div>
                            </div>
                        </div>
                        <div class="user-info-bottom">
                            <div class="nodeinfo node-flex">
                                <span><i class="icon icon-md">donut_large</i>接続数/制限数</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-xx-12 col-xs-6 col-lg-3">
                    <div class="card user-info">
                        <div class="user-info-main">
                            <div class="nodemain">
                                <div class="nodehead node-flex">
                                    <div class="nodename">回線速度</div>
                                </div>
                                <div class="nodemiddle node-flex">
                                    <div class="nodetype">
                                        {if $user->node_speedlimit!=0}
                                            <dd><code>{$user->node_speedlimit}</code>Mbps</dd>
                                        {else}
                                            <dd>無制限</dd>
                                        {/if}
                                    </div>
                                </div>
                                <div class="nodemiddle node-flex">
                                    <div style="font-size: 14px">实际速率受限于运营商带宽上限</div>
                                </div>
                            </div>
                        </div>
                        <div class="user-info-bottom">
                            <div class="nodeinfo node-flex">
                                <span><i class="icon icon-md">signal_cellular_alt</i>サーバーで利用できる下り最大速度</span>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
            <div class="ui-card-wrap">

                <div class="col-xx-12 col-sm-5">

                    <div class="card">
                        <div class="card-main">
                            <div class="card-inner">

                                {*
                                <div id="traffic_chart" style="height: 300px; width: 100%;"></div>

                                <script src="/assets/js/canvasjs.min.js"> </script>
                                <script type="text/javascript">
                                    var chart = new CanvasJS.Chart("traffic_chart", {
                                        theme: "light1",
                                        title: {
                                            text: "通信量の状況",
                                            fontFamily: "Impact",
                                            fontWeight: "normal"
                                        },
                                        legend: {
                                            verticalAlign: "bottom",
                                            horizontalAlign: "center"
                                        },
                                        data: [{
                                            startAngle: -15,
                                            indexLabelFontSize: 20,
                                            indexLabelFontFamily: "Garamond",
                                            indexLabelFontColor: "darkgrey",
                                            indexLabelLineColor: "darkgrey",
                                            indexLabelPlacement: "outside",
                                            yValueFormatString: "##0.00\"%\"",
                                            type: "pie",
                                            showInLegend: true,
                                            dataPoints: [
                                                {if $user->transfer_enable != 0}
                                                {
                                                    y: {$user->last_day_t/$user->transfer_enable*100},label: "利用した通信量", legendText:"利用した通信量 {number_format($user->last_day_t/$user->transfer_enable*100,2)}% {$user->LastusedTraffic()}", indexLabel: "利用した通信量 {number_format($user->last_day_t/$user->transfer_enable*100,2)}% {$user->LastusedTraffic()}"
                                                },
                                                {
                                                    y: {($user->u+$user->d-$user->last_day_t)/$user->transfer_enable*100},label: "今日利用した通信量", legendText:"今日利用した通信量 {number_format(($user->u+$user->d-$user->last_day_t)/$user->transfer_enable*100,2)}% {$user->TodayusedTraffic()}", indexLabel: "今日利用した通信量 {number_format(($user->u+$user->d-$user->last_day_t)/$user->transfer_enable*100,2)}% {$user->TodayusedTraffic()}"
                                                },
                                                {
                                                    y: {($user->transfer_enable-($user->u+$user->d))/$user->transfer_enable*100},label: "残りの通信量", legendText:"残りの通信量 {number_format(($user->transfer_enable-($user->u+$user->d))/$user->transfer_enable*100,2)}% {$user->unusedTraffic()}", indexLabel: "残りの通信量 {number_format(($user->transfer_enable-($user->u+$user->d))/$user->transfer_enable*100,2)}% {$user->unusedTraffic()}"
                                                }
                                                {/if}
                                            ]
                                        }
                                        ]
                                    });

                                    chart.render();
                                </script>
                                *}

                                <div class="progressbar">
                                    <div class="before"></div>
                                    <div class="bar tuse color3"
                                         style="width:calc({($user->transfer_enable==0)?0:($user->u+$user->d-$user->last_day_t)/$user->transfer_enable*100}%);"></div>
                                    <div class="label-flex">
                                        <div class="label la-top">
                                            <div class="bar ard color3"></div>
                                            <span class="traffic-info">今日利用した通信量</span>
                                            <code class="card-tag tag-red">{$user->TodayusedTraffic()}</code>
                                        </div>
                                    </div>
                                </div>
                                <div class="progressbar">
                                    <div class="before"></div>
                                    <div class="bar ard color2"
                                         style="width:calc({($user->transfer_enable==0)?0:$user->last_day_t/$user->transfer_enable*100}%);">
                                        <span></span>
                                    </div>
                                    <div class="label-flex">
                                        <div class="label la-top">
                                            <div class="bar ard color2"><span></span></div>
                                            <span class="traffic-info">利用した通信量</span>
                                            <code class="card-tag tag-orange">{$user->LastusedTraffic()}</code>
                                        </div>
                                    </div>
                                </div>
                                <div class="progressbar">
                                    <div class="before"></div>
                                    <div class="bar remain color"
                                         style="width:calc({($user->transfer_enable==0)?0:($user->transfer_enable-($user->u+$user->d))/$user->transfer_enable*100}%);">
                                        <span></span>
                                    </div>
                                    <div class="label-flex">
                                        <div class="label la-top">
                                            <div class="bar ard color"><span></span></div>
                                            <span class="traffic-info">残りの通信量</span>
                                            <code class="card-tag tag-green" id="remain">{$user->unusedTraffic()}</code>
                                        </div>
                                    </div>
                                </div>

                            </div>

                            <div class="card-inner margin-bottom-no">
                                <p class="card-heading"><i class="icon icon-md">account_circle</i>アカウント状態</p>
                                <dl class="dl-horizontal">


                                    <dt>ランクの有効期限</dt>
                                    {if $user->class_expire!="1989-06-04 00:05:00"}
                                    <dd><i class="icon icon-md">event</i>&nbsp;{$user->class_expire}</dd>
                                    {else}
                                    <dd><i class="icon icon-md">event</i>&nbsp;無し</dd>
                                    {/if}

                                    <dt>ランクが失効するまで</dt>
                                    <i class="icon icon-md">event</i>
                                    <span class="label-level-expire">残り</span>
                                    <code><span id="days-level-expire"></span></code>
                                    <span class="label-level-expire">日</span>

                                    <dt>アカウントの有効期限</dt>
                                    <dd><i class="icon icon-md">event</i>&nbsp;{$user->expire_in}</dd>

                                    <dt>アカウントの失効するまで</dt>
                                    <i class="icon icon-md">event</i>
                                    <span class="label-account-expire">残り</span>
                                    <code><span id="days-account-expire"></span></code>
                                    <span class="label-account-expire">日</span>

                                    <dt>最後の接続時刻</dt>
                                    {if $user->lastSsTime()!="まだ接続したことがないようです"}
                                    <dd><i class="icon icon-md">event</i>&nbsp;{$user->lastSsTime()}</dd>
                                    {else}
                                    <dd><i class="icon icon-md">event</i>&nbsp;まだ接続したことがないようです</dd>
                                    {/if}
                                    </div>
                        </div>
                    </div>

                    <div class="card">
                        <div class="card-main">
                            <div class="card-inner margin-bottom-no">
                                <p class="card-heading"><i class="icon icon-md">notifications_active</i>お知らせ</p>
                                {if $ann != null}
                                    <p>{$ann->content}</p>
                                    <br/>
                                    <strong>全てのお知らせを見たい場合は<a href="/user/announcement">ここをクリック</a></strong>
                                {/if}
                                {if $config["enable_admin_contact"] == 'true'}
                                    <p class="card-heading">管理人の連絡先</p>
                                    {if $config["admin_contact1"]!=null}
                                        <p>{$config["admin_contact1"]}</p>
                                    {/if}
                                    {if $config["admin_contact2"]!=null}
                                        <p>{$config["admin_contact2"]}</p>
                                    {/if}
                                    {if $config["admin_contact3"]!=null}
                                        <p>{$config["admin_contact3"]}</p>
                                    {/if}
                                {/if}
                            </div>
                        </div>
                    </div>

                </div>

                <div class="col-xx-12 col-sm-7">

                    <div class="card quickadd">
                        <div class="card-main">
                            <div class="card-inner">
                                <div class="cardbtn-edit">
                                    <div class="card-heading"><i class="icon icon-md">phonelink</i>サブスクリプション</div>
                                    <div class="reset-flex"><span>リンクを変更する</span><a
                                                class="reset-link btn btn-brand-accent btn-flat"><i class="icon">autorenew</i>&nbsp;</a>
                                    </div>
                                </div>
                                <nav class="tab-nav margin-top-no">
                                    <ul class="nav nav-list">
                                        <li {if $ssr_prefer}class="active"{/if}>
                                            <a class="" data-toggle="tab" href="#all_ssr"><i class="icon icon-lg">flight_takeoff</i>&nbsp;SS/SSR</a>
                                        </li>
                                    </ul>
                                </nav>
                                <div>
                                    <div class="tab-content">
                                        <div class="tab-pane fade {if $ssr_prefer}active in{/if}" id="all_ssr">
                                            {$pre_user = URL::cloneUser($user)}
                                            <nav class="tab-nav margin-top-no">
                                                <ul class="nav nav-list">
                                                    <li class="active">
                                                        <a class="" data-toggle="tab" href="#all_ssr_windows">
                                                            <i class="icon icon-lg">desktop_windows</i>&nbsp;Windows
                                                        </a>
                                                    </li>
                                                    <li>
                                                        <a class="" data-toggle="tab" href="#all_ssr_info">
                                                            <i class="icon icon-lg">info_outline</i>&nbsp;连接信息
                                                        </a>
                                                    </li>
                                                </ul>
                                            </nav>

                                            <div class="tab-pane fade active in" id="all_ssr_windows">
                                                {$user = URL::getSSRConnectInfo($pre_user)}
                                                {$ssr_url_all = URL::getAllUrl($pre_user, 0, 0)}
                                                {$ssr_url_all_mu = URL::getAllUrl($pre_user, 1, 0)}
                                                {if URL::SSRCanConnect($user)}
                                                <table class="table">
                                                    <tbody>
                                                        <tr>
                                                            <td><strong>端口</strong></td>
                                                            <td>{$user->port}</td>
                                                        </tr>
                                                        <tr>
                                                            <td><strong>密码</strong></td>
                                                            <td>{$user->passwd}</td>
                                                        </tr>
                                                        <tr>
                                                            <td><strong>自定义加密</strong></td>
                                                            <td>{$user->method}</td>
                                                        </tr>
                                                        <tr>
                                                            <td><strong>自定义协议</strong></td>
                                                            <td>{$user->protocol}</td>
                                                        </tr>
                                                        <tr>
                                                            <td><strong>自定义混淆</strong></td>
                                                            <td>{$user->obfs}</td>
                                                        </tr>
                                                        <tr>
                                                            <td><strong>自定义混淆参数</strong></td>
                                                            <td>{$user->obfs_param}</td>
                                                        </tr>
                                                    </tbody>
                                                </table>

                                                <br>

                                                {if $mergeSub!='true'}
                                                <div>
                                                    <span class="icon icon-lg text-white">flash_auto</span> 普通节点订阅地址：
                                                </div>
                                                <div class="float-clear">
                                                    <input type="text" class="input form-control form-control-monospace cust-link col-xx-12 col-sm-8 col-lg-7" name="input1" value="{$subUrl}{$ssr_sub_token}?mu=0" readonly="true">
                                                    <button class="copy-text btn btn-subscription col-xx-12 col-sm-3 col-lg-2" type="button" data-clipboard-text="{$subUrl}{$ssr_sub_token}?mu=0">点击复制</button>
                                                </div>
                                                <br>
                                                <div>
                                                    <span class="icon icon-lg text-white">flash_auto</span> 单端口节点订阅地址：
                                                </div>
                                                <div class="float-clear">
                                                    <input type="text" class="input form-control form-control-monospace cust-link col-xx-12 col-sm-8 col-lg-7" name="input1" value="{$subUrl}{$ssr_sub_token}?mu=1" readonly="true">
                                                    <button class="copy-text btn btn-subscription col-xx-12 col-sm-3 col-lg-2" type="button" data-clipboard-text="{$subUrl}{$ssr_sub_token}?mu=1">点击复制</button>
                                                </div>
                                                {else}
                                                <div>
                                                    <span class="icon icon-lg text-white">flash_auto</span> 订阅地址：
                                                </div>
                                                <div class="float-clear">
                                                    <input type="text" class="input form-control form-control-monospace cust-link col-xx-12 col-sm-8 col-lg-7" name="input1" value="{$subUrl}{$ssr_sub_token}" readonly="true">
                                                    <button class="copy-text btn btn-subscription col-xx-12 col-sm-3 col-lg-2" type="button" data-clipboard-text="{$subUrl}{$ssr_sub_token}">点击复制</button>
                                                </div>
                                                {/if}

                                                <br>

                                                    {if $mergeSub!='true'}
                                                        <button class="copy-text btn btn-subscription" type="button" data-clipboard-text="{$ssr_url_all}">点击复制 SSR 普通端口节点链接</button>
                                                        <button class="copy-text btn btn-subscription" type="button" data-clipboard-text="{$ssr_url_all_mu}">点击复制 SSR 单端口多用户链接</button>
                                                    {else}
                                                        <button class="copy-text btn btn-subscription" type="button" data-clipboard-text="{$ssr_url_all}">点击复制全部 SSR 节点链接</button>
                                                    {/if}

                                                {else}
                                                    <p>您好，您目前的 加密方式，混淆，或者协议设置在 ShadowsocksR 客户端下无法连接。请您选用 Shadowsocks
                                                        客户端来连接，或者到 资料编辑 页面修改后再来查看此处</p>
                                                    <p>同时, ShadowsocksR 单端口多用户的连接不受您设置的影响,您可以在此使用相应的客户端进行连接~</p>
                                                    <p>请注意，在当前状态下您的 SSR 订阅链接已经失效，您无法通过此种方式导入节点</p>
                                                {/if}

                                        </div>
                                                <div class="float-clear"><input type="text"
                                                                                class="input form-control form-control-monospace cust-link col-xx-12 col-sm-8 col-lg-7"
                                                                                name="input1" readonly
                                                                                value="{$subUrl}{$ssr_sub_token}?mu=3"
                                                                                readonly="true">
                                                    <button class="copy-text btn btn-subscription col-xx-12 col-sm-3 col-lg-2"
                                                            type="button"
                                                            data-clipboard-text="{$subUrl}{$ssr_sub_token}?mu=3">点击复制
                                                    </button>
                                                </div>

                                                <br>
                                                <button class="copy-text btn btn-subscription" type="button" data-clipboard-text="{$ssd_url_all}">点击复制全部 SSD 节点链接</button>
                                                <button class="copy-text btn btn-subscription" type="button" data-clipboard-text="{$ss_url_all}">点击复制全部 SS 节点链接</button>
                                                
                                                {else}
                                                    <p>您好，您目前的 加密方式，混淆，或者协议设置在 SS 客户端下无法连接。请您选用 SSR 客户端来连接，或者到 资料编辑 页面修改后再来查看此处</p>
                                                    <p>同时, Shadowsocks 单端口多用户的连接不受您设置的影响,您可以在此使用相应的客户端进行连接~</p>
                                                {/if}
                                        </div>
                                        </div>
                                        </div>
                                        {/if}

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>

            </div>
            {include file='dialog.tpl'}

    </div>


    </div>
    </section>
    </div>
</main>


{include file='user/footer.tpl'}

<script src="https://cdn.jsdelivr.net/npm/shake.js@1.2.2/shake.min.js"></script>

<script>
    ;(function () {
        'use strict'

        let onekeysubBTN = document.querySelectorAll('[data-onekeyfor]');
        for (let i = 0; i < onekeysubBTN.length; i++) {
            onekeysubBTN[i].addEventListener('click', () => {
                let onekeyId = onekeysubBTN[i].dataset.onekeyfor;
                AddSub(onekeyId);
            });
        }

        function AddSub(id) {
            let url = $$getValue(id),
                tmp = window.btoa(url);

            tmp = tmp.substring(0, tmp.length);
            url = "sub://" + tmp + "#";
            window.location.href = url;
        }
    })();
</script>

<script>

    function DateParse(str_date) {
        var str_date_splited = str_date.split(/[^0-9]/);
        return new Date(str_date_splited[0], str_date_splited[1] - 1, str_date_splited[2], str_date_splited[3], str_date_splited[4], str_date_splited[5]);
    }

    /*
     * Author: neoFelhz & CloudHammer
     * https://github.com/CloudHammer/CloudHammer/make-sspanel-v3-mod-great-again
     * License: MIT license & SATA license
     */
    function CountDown() {
        var levelExpire = DateParse("{$user->class_expire}");
        var accountExpire = DateParse("{$user->expire_in}");
        var nowDate = new Date();
        var a = nowDate.getTime();
        var b = levelExpire - a;
        var c = accountExpire - a;
        var levelExpireDays = Math.floor(b / (24 * 3600 * 1000));
        var accountExpireDays = Math.floor(c / (24 * 3600 * 1000));
        if (levelExpireDays < 0 || levelExpireDays > 315360000000) {
            document.getElementById('days-level-expire').innerHTML = "無期限";
            for (var i = 0; i < document.getElementsByClassName('label-level-expire').length; i += 1) {
                document.getElementsByClassName('label-level-expire')[i].style.display = 'none';
            }
        } else {
            document.getElementById('days-level-expire').innerHTML = levelExpireDays;
        }
        if (accountExpireDays < 0 || accountExpireDays > 315360000000) {
            document.getElementById('days-account-expire').innerHTML = "無期限";
            for (var i = 0; i < document.getElementsByClassName('label-account-expire').length; i += 1) {
                document.getElementsByClassName('label-account-expire')[i].style.display = 'none';
            }
        } else {
            document.getElementById('days-account-expire').innerHTML = accountExpireDays;
        }
    }
</script>

<script>

    $(function () {
        new Clipboard('.copy-text');
    });

    $(".copy-text").click(function () {
        $("#result").modal();
        $$.getElementById('msg').innerHTML = '已复制，请您继续接下来的操作';
    });

    $(function () {
        new Clipboard('.reset-link');
    });

    $(".reset-link").click(function () {
        $("#result").modal();
        $$.getElementById('msg').innerHTML = '已重置您的订阅链接，请变更或添加您的订阅链接！';
        window.setTimeout("location.href='/user/url_reset'", {$config['jump_delay']});
    });

    {if $user->transfer_enable-($user->u+$user->d) == 0}
    window.onload = function () {
        $("#result").modal();
        $$.getElementById('msg').innerHTML = '您的流量已经用完或账户已经过期了，如需继续使用，请进入商店选购新的套餐~';
    };
    {/if}

    {if $geetest_html == null}

    var checkedmsgGE = '<p><a class="btn btn-brand disabled btn-flat waves-attach" href="#"><span class="icon">check</span>&nbsp;已签到</a></p>';
    window.onload = function () {
        var myShakeEvent = new Shake({
            threshold: 15
        });

        myShakeEvent.start();
        CountDown();

        window.addEventListener('shake', shakeEventDidOccur, false);

        function shakeEventDidOccur() {
            if ("vibrate" in navigator) {
                navigator.vibrate(500);
            }

            $.ajax({
                type: "POST",
                url: "/user/checkin",
                dataType: "json",{if $recaptcha_sitekey != null}
                data: {
                    recaptcha: grecaptcha.getResponse()
                },{/if}
                success: (data) => {
                    if (data.ret) {

                        $$.getElementById('checkin-msg').innerHTML = data.msg;
                        $$.getElementById('checkin-btn').innerHTML = checkedmsgGE;
                        $("#result").modal();
                        $$.getElementById('msg').innerHTML = data.msg;
                        $$.getElementById('remain').innerHTML = data.traffic;
                        $('.bar.remain.color').css('width', (data.unflowtraffic - ({$user->u}+{$user->d})) / data.unflowtraffic * 100 + '%');
                    } else {
                        $("#result").modal();
                        $$.getElementById('msg').innerHTML = data.msg;
                    }
                },
                error: (jqXHR) => {
                    $("#result").modal();
                    $$.getElementById('msg').innerHTML = `发生错误：${
                            jqXHR.status
                            }`;
                }
            });
        }
    };


    $(document).ready(function () {
        $("#checkin").click(function () {
            $.ajax({
                type: "POST",
                url: "/user/checkin",
                dataType: "json",{if $recaptcha_sitekey != null}
                data: {
                    recaptcha: grecaptcha.getResponse()
                },{/if}
                success: (data) => {
                    if (data.ret) {
                        $$.getElementById('checkin-msg').innerHTML = data.msg;
                        $$.getElementById('checkin-btn').innerHTML = checkedmsgGE;
                        $("#result").modal();
                        $$.getElementById('msg').innerHTML = data.msg;
                        $$.getElementById('remain').innerHTML = data.traffic;
                        $('.bar.remain.color').css('width', (data.unflowtraffic - ({$user->u}+{$user->d})) / data.unflowtraffic * 100 + '%');
                    } else {
                        $("#result").modal();
                        $$.getElementById('msg').innerHTML = data.msg;
                    }
                },
                error: (jqXHR) => {
                    $("#result").modal();
                    $$.getElementById('msg').innerHTML = `发生错误：${
                            jqXHR.status
                            }`;
                }
            })
        })
    })


    {else}


    window.onload = function () {
        var myShakeEvent = new Shake({
            threshold: 15
        });

        myShakeEvent.start();

        window.addEventListener('shake', shakeEventDidOccur, false);

        function shakeEventDidOccur() {
            if ("vibrate" in navigator) {
                navigator.vibrate(500);
            }

            c.show();
        }
    };


    var handlerPopup = function (captchaObj) {
        c = captchaObj;
        captchaObj.onSuccess(function () {
            var validate = captchaObj.getValidate();
            $.ajax({
                url: "/user/checkin", // 进行二次验证
                type: "post",
                dataType: "json",
                data: {
                    // 二次验证所需的三个值
                    geetest_challenge: validate.geetest_challenge,
                    geetest_validate: validate.geetest_validate,
                    geetest_seccode: validate.geetest_seccode
                },
                success: (data) => {
                    if (data.ret) {
                        $$.getElementById('checkin-msg').innerHTML = data.msg;
                        $$.getElementById('checkin-btn').innerHTML = checkedmsgGE;
                        $("#result").modal();
                        $$.getElementById('msg').innerHTML = data.msg;
                        $$.getElementById('remain').innerHTML = data.traffic;
                        $('.bar.remain.color').css('width', (data.unflowtraffic - ({$user->u}+{$user->d})) / data.unflowtraffic * 100 + '%');
                    } else {
                        $("#result").modal();
                        $$.getElementById('msg').innerHTML = data.msg;
                    }
                },
                error: (jqXHR) => {
                    $("#result").modal();
                    $$.getElementById('msg').innerHTML = `发生错误：${
                            jqXHR.status
                            }`;
                }
            });
        });
        // 弹出式需要绑定触发验证码弹出按钮
        //captchaObj.bindOn("#checkin")
        // 将验证码加到id为captcha的元素里
        captchaObj.appendTo("#popup-captcha");
        // 更多接口参考：http://www.geetest.com/install/sections/idx-client-sdk.html
    };

    initGeetest({
        gt: "{$geetest_html->gt}",
        challenge: "{$geetest_html->challenge}",
        product: "popup", // 产品形式，包括：float，embed，popup。注意只对PC版验证码有效
        offline: {if $geetest_html->success}0{else}1{/if} // 表示用户后台检测极验服务器是否宕机，与SDK配合，用户一般不需要关注
    }, handlerPopup);



    {/if}


</script>
{if $recaptcha_sitekey != null}
    <script src="https://recaptcha.net/recaptcha/api.js" async defer></script>
{/if}
