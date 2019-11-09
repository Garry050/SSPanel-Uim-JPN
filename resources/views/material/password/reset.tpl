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
                    <label class="floating-label" for="email">メールアドレス</label>
                    <input class="form-control maxwidth-auth" id="email" type="text">
                </div>
            </div>

            <div class="btn-auth auth-row">
                <button id="reset" type="submit" class="btn btn-block btn-brand waves-attach waves-light">パスワードの再設定</button>
            </div>

            <div class="auth-bottom auth-row auth-reset">
                <div class="tgauth">
                    <p>パスワードは必ず自身で管理してください</p>
                </div>
            </div>
        </div>

        <div class="card auth-tg">
            <div class="card-main"></div>
        </div>
    </div>
</div>


{include file='dialog.tpl'}


{include file='footer.tpl'}

<script>
    $(document).ready(function () {
        function reset() {
            $("#result").modal();
            $$.getElementById('msg').innerHTML = '送信中…'
            $.ajax({
                type: "POST",
                url: "/password/reset",
                dataType: "json",
                data: {
                    email: $$getValue('email'),
                },
                success: (data) => {
                    if (data.ret == 1) {
                        $("#result").modal();
                        $$.getElementById('msg').innerHTML = data.msg;
                        window.setTimeout("location.href='/auth/login'", 2000);
                    } else {
                        $("#result").modal();
                        $$.getElementById('msg').innerHTML = data.msg;
                    }
                },
                error: (jqXHR) => {
                    $("#result").modal();
                    $$.getElementById('msg').innerHTML = data.msg;
                }
            });
        }

        $("html").keydown(function (event) {
            if (event.keyCode === 13) {
                reset();
            }
        });
        $("#reset").click(function () {
            reset();
        });
    })
</script>