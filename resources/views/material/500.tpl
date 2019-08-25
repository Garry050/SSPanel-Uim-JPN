<!DOCTYPE HTML>
<html>
<head>
    <title>内部エラー - {$config["appName"]}</title>
    <meta name="keywords" content=""/>
    <meta name="description" content=""/>
    <meta charset="utf-8"/>
    <link rel="shortcut icon" href="/favicon.ico"/>
    <link rel="bookmark" href="/favicon.ico" type="image/x-icon"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no"/>
    <link rel="shortcut icon" type="image/ico" href="images/ssr.ico">
    <link rel="stylesheet" href="/assets/css/main.css"/>

    <noscript>
        <link rel="stylesheet" href="/assets/css/noscript.css"/>
    </noscript>
</head>

<body>

<div id="wrapper">
    <header id="header">
        <div class="logo">
            <span class="icon fa-rocket"></span>
        </div>
        <div class="content">
            <div class="inner">
                <h1>500 INTERNAL SERVER ERROR</h1>
                <p>内部エラー</p>
                <p>サーバー側に問題が発生しています。常に表示されている場合はadmin@workupa.meまでご連絡ください</p>
            </div>
        </div>
        <nav>
            <ul>
                <li><a href="./#">トップに戻る</a></li>
            </ul>
        </nav>
    </header>
    <footer id="footer">
        <p class="copyright">&copy;{date("Y")} {$config["appName"]} </p>
    </footer>
</div>
<div id="bg"></div>

<script src="https://cdn.jsdelivr.net/npm/jquery@1.11.3"></script>
<script src="https://cdn.jsdelivr.net/gh/ajlkn/skel@3.0.1/dist/skel.min.js"></script>
<script src="/assets/js/util.js"></script>
<script src="/assets/js/main.js"></script>
</body>

</html>
