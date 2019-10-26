<!DOCTYPE html>
<html lang="ja-JP">
<head>
    <meta charset="UTF-8">
    <meta content="IE=edge" http-equiv="X-UA-Compatible">
    <meta content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no, width=device-width" name="viewport">
    <meta name="theme-color" content="#4285f4">
    <title>{$config["appName"]}</title>

    <!-- css -->
    <link href="/theme/material/css/base.min.css" rel="stylesheet">
    <link href="/theme/material/css/project.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="/theme/material/css/user.css">
    <!-- jquery -->
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.2.1"></script>
    <script src="https://cdn.jsdelivr.net/gh/davidshimjs/qrcodejs@gh-pages/qrcode.min.js"></script>
    <!-- js -->
    <script src="/assets/js/fuck.js"></script>
</head>
<body class="page-orange">
<header class="header header-orange header-transparent header-waterfall ui-header">
    <ul class="nav nav-list pull-left">
        <div>
            <a data-toggle="menu" href="#ui_menu">
                <span class="icon icon-lg text-white">menu</span>
            </a>
        </div>
    </ul>

    <ul class="nav nav-list pull-right">
        <div class="dropdown margin-right">
            <a class="dropdown-toggle padding-left-no padding-right-no" data-toggle="dropdown">
                {if $user->isLogin}
                <span class="access-hide">{$user->user_name}</span>
                <span class="icon icon-cd margin-right">account_circle</span>
            </a>
            <ul class="dropdown-menu dropdown-menu-right">
                <li>
                    <a class="waves-attach" href="/user/"><span class="icon icon-lg margin-right">account_box</span>トップ画面</a>
                </li>

                <li>
                    <a class="padding-right-cd waves-attach" href="/user/logout"><span
                                class="icon icon-lg margin-right">exit_to_app</span>ログアウト</a>
                </li>
            </ul>
            {else}
            <span class="access-hide">ログインしていません</span>
            <span class="icon icon-lg margin-right">account_circle</span>
            <ul class="dropdown-menu dropdown-menu-right">
                <li>
                    <a class="padding-right-lg waves-attach" href="/auth/login"><span class="icon icon-lg margin-right">account_box</span>ログイン</a>
                </li>
                <li>
                    <a class="padding-right-lg waves-attach" href="/auth/register"><span
                                class="icon icon-lg margin-right">pregnant_woman</span>新規登録</a>
                </li>
            </ul>
            {/if}
        </div>
    </ul>
</header>
<nav aria-hidden="true" class="menu menu-left nav-drawer nav-drawer-md" id="ui_menu" tabindex="-1">
    <div class="menu-scroll">
        <div class="menu-content">
            <a class="menu-logo" href="/"><i class="icon icon-lg">language</i>&nbsp;{$config["appName"]}</a>
            <ul class="nav">
                <li>
                    <a class="waves-attach" data-toggle="collapse" href="#ui_menu_me">アカウント</a>
                    <ul class="menu-collapse collapse in" id="ui_menu_me">
                        <li>
                            <a href="/user"><i class="icon icon-lg">account_balance_wallet</i>&nbsp;トップ画面</a>
                        </li>

                        <li>
                            <a href="/user/profile"><i class="icon icon-lg">account_box</i>&nbsp;アカウント情報</a>
                        </li>

                        <li>
                            <a href="/user/edit"><i class="icon icon-lg">sync_problem</i>&nbsp;アカウント設定</a>
                        </li>

                        <li>
                            <a href="/user/trafficlog"><i class="icon icon-lg">hourglass_empty</i>&nbsp;通信量の使用履歴</a>
                        </li>

                        {if $config['enable_ticket']=='true'}
                            <li>
                                <a href="/user/ticket"><i class="icon icon-lg">question_answer</i>&nbsp;問い合わせ</a>
                            </li>
                        {/if}

                        <li>
                            <a href="/user/invite"><i class="icon icon-lg">loyalty</i>&nbsp;招待する</a>
                        </li>
                    </ul>


                    <a class="waves-attach" data-toggle="collapse" href="#ui_menu_use">サーバー</a>
                    <ul class="menu-collapse collapse in" id="ui_menu_use">
                        <li>
                            <a href="/user/node"><i class="icon icon-lg">airplanemode_active</i>&nbsp;サーバー一覧</a>
                        </li>

                        <li>
                            <a href="/user/relay"><i class="icon icon-lg">compare_arrows</i>&nbsp;サーバー中継設定</a>
                        </li>

                        <li>
                            <a href="/user/lookingglass"><i class="icon icon-lg">visibility</i>&nbsp;Ping確認</a>
                        </li>

                        <li>
                            <a href="/user/announcement"><i class="icon icon-lg">announcement</i>&nbsp;お知らせ</a>
                        </li>

                        <li>
                            <a href="/user/tutorial"><i class="icon icon-lg">start</i>&nbsp;使用方法</a>
                        </li>
                    </ul>

                    <a class="waves-attach" data-toggle="collapse" href="#ui_menu_help">ストア</a>
                    <ul class="menu-collapse collapse in" id="ui_menu_help">
                        <li>
                            <a href="/user/code"><i class="icon icon-lg">code</i>&nbsp;残高のチャージ</a>
                        </li>

                        <li>
                            <a href="/user/shop"><i class="icon icon-lg">shop</i>&nbsp;プランの購入</a>
                        </li>

                        <li><a href="/user/bought"><i class="icon icon-lg">shopping_cart</i>&nbsp;購入履歴</a></li>

                        {if $config['enable_donate']=='true'}
                            <li>
                                <a href="/user/donate"><i class="icon icon-lg">attach_money</i>&nbsp;捐赠公示</a>
                            </li>
                        {/if}

                    </ul>

                    {if $user->isAdmin()}
                <li>
                    <a href="/admin"><i class="icon icon-lg">person_pin</i>&nbsp;管理者パネル</a>
                </li>
                {/if}

                {if $can_backtoadmin}
                    <li>
                        <a class="padding-right-cd waves-attach" href="/user/backtoadmin"><span
                                    class="icon icon-lg margin-right">backtoadmin</span>管理者アカウントに戻る</a>
                    </li>
                {/if}
            </ul>
        </div>
    </div>
</nav>

{if $config["enable_mylivechat"] == 'true'}{include file='mylivechat.tpl'}{/if}
