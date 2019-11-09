{include file='header.tpl'}


<!-- 新的 -->
<div class="authpage">
    <div class="container">

        <div class="auth-main auth-row auth-col-one">
            <div class="auth-top auth-row">
                <a class="boardtop-left" href="/">
                    <div>トップ</div>
                </a>
                <div class="auth-logo">
                    <img src="/images/authlogo.jpg">
                </div>
                <a href="/auth/login" class="boardtop-right">
                    <div>ログイン</div>
                </a>
            </div>
            <div class="auth-row">
                <div class="form-group-label auth-row row-login">
                    <label class="floating-label" for="password">新しいパスワード</label>
                    <input class="form-control maxwidth-auth" id="password" type="password">
                </div>
            </div>
            <div class="auth-row">
                <div class="form-group-label auth-row row-login">
                    <label class="floating-label" for="repasswd">新しいパスワードの確認</label>
                    <input class="form-control maxwidth-auth" id="repasswd" type="password">
                </div>
            </div>

            <div class="btn-auth auth-row">
                <button id="reset" type="submit" class="btn btn-block btn-brand waves-attach waves-light">パスワードを設定</button>
            </div>
            <div class="auth-help auth-row">
                <div class="auth-help-table auth-row auth-reset">
                    <a href="/auth/register">再登録する</a>
                </div>
            </div>
            <div class="auth-bottom auth-row auth-reset">
                <div class="tgauth">
                    <p>パスワードは必ず自身で管理してください</p>
                </div>
            </div>
        </div>

        <div class="card auth-tg">
            <div class="card-main">

            </div>
        </div>
    </div>
</div>


{include file='dialog.tpl'}





{include file='footer.tpl'}


<script>
    $(document).ready(function () {
        function reset() {
            $.ajax({
                type: "POST",
                url: "/password/token/{$token}",
                dataType: "json",
                data: {
                    password: $$getValue('password'),
                    repasswd: $$getValue('repasswd'),
                },
                success: (data) => {
                    if (data.ret) {
                        $("#result").modal();
                        $$.getElementById('msg').innerHTML = data.msg;
                        window.setTimeout("location.href='/auth/login'", {$config['jump_delay']});
                    } else {
                        $("#result").modal();
                        $$.getElementById('msg').innerHTML = data.msg;
                    }
                },
                error: (jqXHR) => {
                    $("#msg-error").hide(10);
                    $("#msg-error").show(100);
                    $$.getElementById('msg-error-p').innerHTML = `エラーコード：${
                            jqXHR.status
                            }`;
                    // 在控制台输出错误信息
                    //console.log(removeHTMLTag(jqXHR.responseText));
                }
            });
        }

        $("html").keydown(function (event) {
            if (event.keyCode == 13) {
                reset();
            }
        });
        $("#reset").click(function () {
            reset();
        });
    })
</script>



