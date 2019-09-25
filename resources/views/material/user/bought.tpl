{include file='user/main.tpl'}


<main class="content">
    <div class="content-header ui-content-header">
        <div class="container">
            <h1 class="content-heading">購入履歴</h1>
        </div>
    </div>
    <div class="container">
        <div class="col-lg-12 col-sm-12">
            <section class="content-inner margin-top-no">

                <div class="card">
                    <div class="card-main">
                        <div class="card-inner">
                            <p>システム内の購入履歴</p>
                        </div>
                    </div>
                </div>

                <div class="card">
                    <div class="card-main">
                        <div class="card-inner">
                            <div class="card-table">
                                <div class="table-responsive table-user">
                                    {$shops->render()}
                                    <table class="table">
                                        <tr>
                                            <th>ID</th>
                                            <th>購入時間</th>
                                            <th>商品名</th>
                                            <th>内容</th>
                                            <th>価格</th>
                                            <th>商品の更新期間</th>
                                            <th>購入時に通信量のリセット</th>
                                            <th>操作</th>
                                        </tr>
                                        {foreach $shops as $shop}
                                            <tr>
                                                <td>#{$shop->id}</td>
                                                <td>{$shop->datetime("Y/m/d",$date_unix)}</td>
                                                <td>{$shop->shop()->name}</td>
                                                <td>{$shop->shop()->content()}</td>
                                                <td>{$shop->price} 円</td>

                                                {if $shop->renew==0}
                                                    <td>自動的に更新しない</td>
                                                {else}
                                                    <td>{$shop->renew_date()} に更新する</td>
                                                {/if}

                                                {if $shop->shop()->auto_reset_bandwidth==0}
                                                    <td>リセットしない</td>
                                                {else}
                                                    <td>リセットする</td>
                                                {/if}

                                                <td>
                                                    <a class="btn btn-brand"
                                                       {if $shop->renew==0}disabled{else}href="javascript:void(0);"
                                                       onClick="delete_modal_show('{$shop->id}')"{/if}>自動更新を無効にする</a>
                                                </td>

                                            </tr>
                                        {/foreach}
                                    </table>
                                    {$shops->render()}
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div aria-hidden="true" class="modal modal-va-middle fade" id="delete_modal" role="dialog"
                     tabindex="-1">
                    <div class="modal-dialog modal-xs">
                        <div class="modal-content">
                            <div class="modal-heading">
                                <a class="modal-close" data-dismiss="modal">×</a>
                                <h2 class="modal-title">自動更新を無効にしますか？</h2>
                            </div>
                            <div class="modal-inner">
                                <p>無効にする場合は決定を押してください</p>
                            </div>
                            <div class="modal-footer">
                                <p class="text-right">
                                    <button class="btn btn-flat btn-brand-accent waves-attach waves-effect"
                                            data-dismiss="modal" type="button">
                                        キャンセル
                                    </button>
                                    <button class="btn btn-flat btn-brand-accent waves-attach" data-dismiss="modal"
                                            id="delete_input" type="button">
                                        決定
                                    </button>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>

                {include file='dialog.tpl'}

        </div>

    </div>
</main>


{include file='user/footer.tpl'}


<script>
    function delete_modal_show(id) {
        var deleteid = id;
        $("#delete_modal").modal();
    }

    $(document).ready(function () {
        function delete_id() {
            $.ajax({
                type: "DELETE",
                url: "/user/bought",
                dataType: "json",
                data: {
                    id: deleteid
                },
                success: (data) => {
                    if (data.ret) {
                        $("#result").modal();
                        $$.getElementById('msg').innerHTML = data.msg;
                        window.setTimeout("location.href=window.location.href", {$config['jump_delay']});
                    } else {
                        $("#result").modal();
                        $$.getElementById('msg').innerHTML = data.msg;
                    }
                },
                error: (jqXHR) => {
                    $("#result").modal();
                    $$.getElementById('msg').innerHTML = `${
                            data.msg
                            } エラーが発生しました`;
                }
            });
        }

        $$.getElementById('delete_input').addEventListener('click', delete_id);
    })

</script>
