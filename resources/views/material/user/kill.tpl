{include file='user/main.tpl'}


<main class="content">
    <div class="content-header ui-content-header">
        <div class="container">
            <h1 class="content-heading">アカウントを削除</h1>
        </div>
    </div>
    <div class="container">
        <section class="content-inner margin-top-no">
            <div class="row">

                <div class="col-lg-12 col-md-12">
                    <div class="card margin-bottom-no">
                        <div class="card-main">
                            <div class="card-inner">
                                <div class="card-inner">
                                    <h4>警告</h4>

                                    <p>アカウントを削除すると残高を含む全てのユーザーデータが削除されます。</p>
                                    <p><b>アカウントを削除した後に残高を返金することはできません。</b></p>
                                    <p>再度Global-SSRを利用したい場合は再度新規登録してください。</p>

                                </div>

                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-12 col-md-12">
                    <div class="card margin-bottom-no">
                        <div class="card-main">
                            <div class="card-inner">
                                <div class="card-inner">
                                    <p class="card-heading">パスワードの確認</p>
                                    <div class="form-group form-group-label">
                                        <label class="floating-label" for="passwd">パスワードを入力してください</label>
                                        <input class="form-control" id="passwd" type="password">
                                    </div>
                                </div>
                                <div class="card-action">
                                    <div class="card-action-btn pull-left">
                                        <button class="btn btn-flat waves-attach" id="kill"><span
                                                    class="icon">check</span>&nbsp;アカウントを削除する
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                {include file='dialog.tpl'}
            </div>
        </section>
    </div>
</main>


{include file='user/footer.tpl'}


<script>
    $(document).ready(function () {
        $("#kill").click(function () {
            $.ajax({
                type: "POST",
                url: "kill",
                dataType: "json",
                data: {
                    passwd: $$getValue('passwd'),
                },
                success: (data) => {
                    if (data.ret) {
                        $("#result").modal();
                        $$.getElementById('msg').innerHTML = data.msg;
                        window.setTimeout("location.href='/'", {$config['jump_delay']});
                    } else {
                        $("#result").modal();
                        $$.getElementById('msg').innerHTML = data.msg;
                    }
                },
                error: (jqXHR) => {
                    $("#result").modal();
                    $$.getElementById('msg').innerHTML = `エラーが発生しました：${
                            jqXHR.status
                            } ${
                            data.msg
                            }`;
                }
            })
        })
    })
</script>

